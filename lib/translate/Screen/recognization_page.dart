import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

// translate feature
import 'API.dart';
import 'dart:convert';

class RecognizePage extends StatefulWidget {
  final String? path;
  const RecognizePage({Key? key, this.path}) : super(key: key);

  @override
  State<RecognizePage> createState() => _RecognizePageState();
}

class _RecognizePageState extends State<RecognizePage> {
  bool _isBusy = false;

  TextEditingController controller = TextEditingController();

  String tempUrl = '';
  Uri url = Uri.parse('');
  var data = '';
  String queryText = 'Query';
  String src = 'en';
  String text = '';
  String dest = 'fr';

  final Map<String, String> _languages = {
    'English': 'en',
    'French': 'fr',
    'German': 'de',
    'Italian': 'it',
    'Spanish': 'es',
    'Korean': 'ko',
    'Japanese': 'Japanese'
    // add more languages as needed
  };

  @override
  void initState() {
    super.initState();

    final InputImage inputImage = InputImage.fromFilePath(widget.path!);

    processImage(inputImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("recognized page")),
      body: _isBusy == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                // Source language
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: DropdownButton<String>(
                    key: const Key('srcKey'),
                    items: _languages
                        .map((lang, value) {
                          return MapEntry(
                              lang,
                              DropdownMenuItem<String>(
                                  value: value, child: Text(lang)));
                        })
                        .values
                        .toList(),
                    value: src,
                    onChanged: (newValue) {
                      setState(() {
                        src = newValue!;
                      });
                    },
                  ),
                ),
                // Text
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    height: 150,
                    child: TextField(
                      maxLines: controller.text.trim().length.toInt(),
                      controller: controller,
                      decoration:
                          const InputDecoration(hintText: "Text goes here..."),
                      onChanged: (value) {
                        setState(() {
                          text = value;
                        });
                      },
                    ),
                  ),
                ),
                // Target Language
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: DropdownButton<String>(
                    key: const Key('destKey'),
                    items: _languages
                        .map((lang, value) {
                          return MapEntry(
                              lang,
                              DropdownMenuItem<String>(
                                  value: value, child: Text(lang)));
                        })
                        .values
                        .toList(),
                    value: dest,
                    onChanged: (newValue) {
                      setState(() {
                        dest = newValue!;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () async {
                      tempUrl =
                          'http://127.0.0.1:5000/api?Query=$src|$text|$dest|';
                      url = Uri.parse(tempUrl);
                      data = await Getdata(url);
                      var decodedData = jsonDecode(data);
                      setState(() {
                        queryText = decodedData['Query'];
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 0, 115, 255),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Translate',
                          style: TextStyle(
                            color: Color.fromARGB(255, 251, 232, 232),
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        )),
                    alignment: Alignment.topLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Translated Text',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            queryText,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 0, 98, 255),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  void processImage(InputImage image) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

    setState(() {
      _isBusy = true;
    });

    log(image.filePath!);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(image);

    controller.text = recognizedText.text;

    ///End busy state
    setState(() {
      _isBusy = false;
    });
  }
}
