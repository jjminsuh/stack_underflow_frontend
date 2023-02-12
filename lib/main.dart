import 'package:flutter/material.dart';
import 'package:stack_underflow_frontend/home/home_screen.dart';
import 'package:stack_underflow_frontend/map/map_screen.dart';
import 'package:stack_underflow_frontend/mypage/mypage_screen.dart';
import 'package:stack_underflow_frontend/translate/translate_screen.dart';
import 'package:stack_underflow_frontend/notification/notification_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    const TranslateScreen(),
    const MyPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('MedicGo'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                print("IconButton map");
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return MapScreen();
                  }),
                );
              },
              icon: const Icon(Icons.map_outlined)),
          IconButton(
              onPressed: () {
                print("IconButton notification");
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return NotificationScreen();
                  }),
                );
              }, icon: const Icon(Icons.notifications_outlined))
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_2_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.translate_outlined),
            label: 'Translate',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: 'My Page',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.lightBlue[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
