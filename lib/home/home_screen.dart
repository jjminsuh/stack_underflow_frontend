import 'dart:io';

import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:stack_underflow_frontend/constant/constants.dart';

import 'package:qr_flutter/qr_flutter.dart';
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var hospitalType = "Hospital Type Test";
  var userName = "Name Test";
  var birthDate = "2023-02-11";
  var gender = 0;
  var genderText = "Not selected";
  var lastVisitDate = "2023-02-10";
  var lastUpdateDate = "2023-02-10";

  final _formKey = GlobalKey<FormState>();
  String? _name = '';
  String? _dob = '';
  String? _gender = '';
  String? _allergies = '';
  String? _bloodtype = '';
  String? _pastrecords = '';
  Map<String, String> _qrData = {};
  bool _qrVisible = false;

  late FlipCardController _controller;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _controller = FlipCardController();
    _scrollController = ScrollController();
  }

  //final _allergies

  void doStuff() {
    _controller.toggleCard();
  }

  void _convertToQR() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _qrData = {
          'Name': '$_name',
          'DOB': '$_dob',
          'Gender': '$_gender',
          'Allergies': '$_allergies',
          'Blood Type': '$_bloodtype',
        };
        _qrVisible = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double heightCard = MediaQuery.of(context).size.height * 0.7;

    switch (gender) {
      case 0:
        genderText = "Male";
        break;
      case 1:
        genderText = "Female";
        break;
      default:
        genderText = "Not selected";
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 50, 40, 50),
        child: SizedBox(
          height: height * 0.7,
          child: AspectRatio(
            aspectRatio: 2 / 3,
            child: FlipCard(
              direction: FlipDirection.HORIZONTAL,
              front: Card(
                clipBehavior: Clip.antiAlias,
                elevation: 8,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.blue,
                          Colors.white,
                        ]),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(
                                hospitalType,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                            SizedBox(
                              height: heightCard * 0.3,
                            ),
                            // if (_qrData.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(left: 24.0),
                                child: Text(
                                  userName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: heightCard * 0.03,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 28.0),
                                    child: Text(
                                      birthDate,
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 2.0),
                                    child: Text(TEXT_SLASH),
                                  ),
                                  Text(
                                    genderText,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(
                              height: heightCard * 0.1,
                            )
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            if (_qrVisible)
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: QrImage(
                                  data: jsonEncode(_qrData),
                                  size: heightCard * 0.2,
                                ),
                              )
                            else
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Container(
                                  color: Colors.white,
                                  height: heightCard * 0.2,
                                  width: heightCard * 0.2,
                                ),
                              ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  TEXT_LAST_VISIT_DATE,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  lastVisitDate,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(
                                  height: heightCard * 0.03,
                                ),
                                const Text(
                                  TEXT_LAST_UPDATE_DATE,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  lastUpdateDate,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ),
              back: Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                            Colors.blue,
                            Colors.white,
                          ]
                        )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 16.0),
                                      child: Text(
                                        hospitalType,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                    SizedBox(
                                      height: heightCard * 0.3,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 24.0),
                                      child: Text(
                                        userName,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: heightCard * 0.03,
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 24.0),
                                          child: Text(
                                            birthDate,
                                            style: const TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        const Padding(
                                          padding:
                                              EdgeInsets.symmetric(horizontal: 2.0),
                                          child: Text(TEXT_SLASH),
                                        ),
                                        Text(
                                          genderText,
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: heightCard * 0.05,
                                    ),
                                    Form(
                                      key: _formKey,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 2.0),
                                        child: Column(
                                          children: <Widget> [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 24.0),
                                              child: SizedBox(
                                                width: 200,
                                                child: TextFormField(
                                                  decoration: const InputDecoration(
                                                      labelText: 'Name'),
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.trim().isEmpty) {
                                                      return 'Please enter a name';
                                                    }
                                                    return null;
                                                  },
                                                  onSaved: (value) => _name = value,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 24.0),
                                              child: SizedBox(
                                                width: 200,
                                                child: TextFormField(
                                                  decoration: const InputDecoration(
                                                      labelText: 'Date of Birth'),
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.trim().isEmpty) {
                                                      return 'Please enter your date of birth';
                                                    }
                                                    return null;
                                                  },
                                                  onSaved: (value) => _dob = value,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 24.0),
                                              child: SizedBox(
                                                width: 200,
                                                child: TextFormField(
                                                  decoration: const InputDecoration(
                                                      labelText: 'Gender'),
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.trim().isEmpty) {
                                                      return 'Please enter your gender';
                                                    }
                                                    return null;
                                                  },
                                                  onSaved: (value) => _gender = value,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 24.0),
                                              child: SizedBox(
                                                width: 200,
                                                child: TextFormField(
                                                  decoration: const InputDecoration(
                                                      labelText: 'Allergies'),
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.trim().isEmpty) {
                                                      return 'Please type "None" if no Allergies';
                                                    }
                                                    return null;
                                                  },
                                                  onTap: () {
                                                    _scrollController.animateTo(
                                                      MediaQuery.of(context).viewInsets.bottom + 100, 
                                                      duration: const Duration(
                                                        microseconds: 100),
                                                      curve: Curves.ease);
                                                  },
                                                  onSaved: (value) =>
                                                      _allergies = value,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 24.0),
                                              child: SizedBox(
                                                width: 200,
                                                child: TextFormField(
                                                  decoration: const InputDecoration(
                                                      labelText: 'Blood Type'),
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.trim().isEmpty) {
                                                      return 'Please enter your blood type';
                                                    }
                                                    return null;
                                                  },
                                                  onTap: () {
                                                    _scrollController.animateTo(
                                                      MediaQuery.of(context).viewInsets.bottom + 100, 
                                                      duration: const Duration(
                                                        microseconds: 100),
                                                      curve: Curves.ease);
                                                  },
                                                  onSaved: (value) =>
                                                      _bloodtype = value,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 24.0),
                                              child: SizedBox(
                                                width: 200,
                                                child: TextFormField(
                                                  decoration: const InputDecoration(
                                                      labelText:
                                                          'Past Medical Records'),
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.trim().isEmpty) {
                                                      return 'Enter "None" if no records';
                                                    }
                                                    return null;
                                                  },
                                                  onTap: () {
                                                    _scrollController.animateTo(
                                                      MediaQuery.of(context).viewInsets.bottom + 100, 
                                                      duration: const Duration(
                                                        microseconds: 100),
                                                      curve: Curves.ease);
                                                  },
                                                  onSaved: (value) =>
                                                      _pastrecords = value,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 24.0),
                                      child: Text(
                                        TEXT_WRITE_YOUR_CONDITION,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: heightCard * 0.05,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 24.0),
                                      child: SizedBox(
                                        width: 200,
                                        child: TextField(
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: 'Enter your ...',
                                          ),
                                          onTap: () {
                                            _scrollController.animateTo(
                                                MediaQuery.of(context).viewInsets.bottom + 100,
                                                duration: const Duration(
                                                    milliseconds: 100),
                                                curve: Curves.ease);
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        // Fluttertoast.showToast(
                                        //   msg: "Updated the QR code",

                                        // );
                                        _convertToQR();
                                        _controller.toggleCard();
                                      },
                                      child: const Text(TEXT_CONFIRM),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
              controller: _controller,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
