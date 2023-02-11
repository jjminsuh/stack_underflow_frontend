import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final _formKey = GlobalKey<FormState>();
  String? _name = '';
  String? _dob = '';
  String? _gender = '';
  String? _allergies = '';
  String? _bloodtype = '';
  String? _pastrecords = '';
  String _qrData = '';
  bool _qrVisible = false;

  void _convertToQR() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _qrData =
            'Name: $_name|DOB: $_dob|Gender: $_gender|Allergies: $_allergies|Blood Type: $_bloodtype|Past Medical Records: $_pastrecords';
        _qrVisible = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('QR Code Generator'),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                  onSaved: (value) => _name = value,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Date of Birth'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your date of birth';
                    }
                    return null;
                  },
                  onSaved: (value) => _dob = value,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Gender'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your gender';
                    }
                    return null;
                  },
                  onSaved: (value) => _gender = value,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Allergies'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please type "None" if no Allergies';
                    }
                    return null;
                  },
                  onSaved: (value) => _allergies = value,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Blood Type'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your blood type';
                    }
                    return null;
                  },
                  onSaved: (value) => _bloodtype = value,
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Past Medical Records'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter "None" if no records';
                    }
                    return null;
                  },
                  onSaved: (value) => _pastrecords = value,
                ),
                _qrVisible
                    ? Container(
                        margin: const EdgeInsets.only(top: 16.0),
                        child: QrImage(
                          data: _qrData,
                          size: 0.5 * MediaQuery.of(context).size.width,
                        ),
                      )
                    : Container(),
                Container(
                  margin: const EdgeInsets.only(top: 16.0),
                  child: ElevatedButton(
                    onPressed: _convertToQR,
                    child: const Text('Save details'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
