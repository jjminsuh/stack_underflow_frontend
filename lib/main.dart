import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'user_form.dart';
import 'dart:convert';

void main() async {
  runApp(MaterialApp(home: homePage()));
}

class homePage extends StatefulWidget {
  @override
  homePageState createState() => homePageState();
}

class homePageState extends State<homePage> {
  Map<String, String> qrData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () async {
                Future<Map<String, String>> navigateAndGetResult() async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => qrForm()),
                  );
                  return result;
                }

                final result = await navigateAndGetResult();
                setState(() {
                  qrData = result;
                });
              },
              child: const Text("Go to Profile"),
            ),
          ),
          if (qrData.isNotEmpty)
            Column(
              children: [
                Center(
                    child: Column(children: [
                  Text("Name: ${qrData['Name']}"),
                  Text("DOB: ${qrData['DOB']}"),
                  Text("Gender: ${qrData['Gender']}"),
                  Text("Allergies: ${qrData['Allergies']}"),
                  Text("Blood Type: ${qrData['Blood Type']}"),
                ])),
                Container(
                  margin: const EdgeInsets.only(top: 16.0),
                  child: QrImage(
                    data: jsonEncode(qrData),
                    size: 0.5 * MediaQuery.of(context).size.width,
                  ),
                )
              ],
            ),
        ],
      ),
    );
  }
}
