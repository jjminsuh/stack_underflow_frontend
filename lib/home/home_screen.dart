import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:stack_underflow_frontend/constant/constants.dart';

class HomeScreen extends StatelessWidget {
  var hospitalType = "Hospital Type Test";
  var name = "Name Test";
  var birthDate = "2023-02-11";
  var gender = 0;
  var genderText = "Not selected";
  var lastVisitDate = "2023-02-10";
  var lastUpdateDate = "2023-02-10";

  @override
  Widget build(BuildContext context) {
    
    double height = MediaQuery.of(context).size.height;

    FlipCardController _controller;

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
              front: CardFront(hospitalType: hospitalType, name: name, birthDate: birthDate, genderText: genderText, lastVisitDate: lastVisitDate, lastUpdateDate: lastUpdateDate),
              back: CardBack(hospitalType: hospitalType, name: name, birthDate: birthDate, genderText: genderText,),
              controller: _controller,
            ),
          ),
        ),
      ),
    );
  }
}

class CardFront extends StatelessWidget {
  const CardFront({
    Key? key,
    required this.hospitalType,
    required this.name,
    required this.birthDate,
    required this.genderText,
    required this.lastVisitDate,
    required this.lastUpdateDate,
  }) : super(key: key);

  final String hospitalType;
  final String name;
  final String birthDate;
  final String genderText;
  final String lastVisitDate;
  final String lastUpdateDate;

  @override
  Widget build(BuildContext context) {
    double heightCard = MediaQuery.of(context).size.height * 0.7;

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30)
      ),
      child: Container(
        decoration:  const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue,
              Colors.white,
            ]
          ),
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
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),
                    ),
                  ),
                  SizedBox(
                    height: heightCard * 0.3,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(
                    height:  heightCard * 0.03,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Image.network(
                      "https://picsum.photos/200",
                      height: heightCard * 0.25,
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
    );
  }
}

class CardBack extends StatelessWidget {
  const CardBack({
    Key? key,
    required this.hospitalType,
    required this.name,
    required this.birthDate,
    required this.genderText,
  }) : super(key: key);

  final String hospitalType;
  final String name;
  final String birthDate;
  final String genderText;

  @override
  Widget build(BuildContext context) {
    double heightCard = MediaQuery.of(context).size.height * 0.7;

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30)
      ),
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
            mainAxisSize: MainAxisSize.max,
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
                        fontSize: 20
                      ),
                    ),
                  ),
                  SizedBox(
                    height: heightCard * 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: Text(
                      name,
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
                        padding: const EdgeInsets.only(left: 24.0),
                        child: Text(
                          birthDate,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 2.0),
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
                  const Padding(
                    padding: EdgeInsets.only(left: 24.0),
                    child: SizedBox(
                      width: 200,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter your ...',
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          
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
      )
    );
  }
}