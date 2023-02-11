import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class TranslateScreen extends StatefulWidget {
  const TranslateScreen({Key? key}) : super(key: key);

  @override
  State<TranslateScreen> createState() => _TranslateScreenState();
}

class _TranslateScreenState extends State<TranslateScreen> {
  File? image;

  Future pickImage() async {
    try {
      final image =  await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch(e) {
      print("Failed to pick image : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 카메라 접근
            Card(
              color: Colors.blueAccent[100],
              child: InkWell(
                onTap: () {

                },
                child: SizedBox(
                  width: 250,
                  height: 100,
                  child: Center(
                    child: Text(
                      'Camera',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            // 갤러리 접근
            Card(
              color: Colors.blueAccent[100],
              child: InkWell(
                onTap: () {
                  pickImage();
                },
                child: SizedBox(
                  width: 250,
                  height: 100,
                  child: Center(
                      child: Text(
                    'Gallery',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
