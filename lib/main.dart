import 'package:flutter/material.dart';
import 'API.dart';
import 'dart:convert';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Translate_BETA'),
        ),
        body: Column(
          children: <Widget>[
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
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                onChanged: (value) {
                  text = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Text to be translated',
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
                  tempUrl = 'http://127.0.0.1:5000/api?Query=$src|$text|$dest|';
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
              child: Row(
                children: [
                  const Text(
                    'Translated: ',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    queryText,
                    style: const TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 98, 255),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
