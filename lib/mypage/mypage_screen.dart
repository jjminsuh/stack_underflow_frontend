import 'package:flutter/material.dart';
import 'package:stack_underflow_frontend/mypage/user/profile_widget.dart';
import 'package:stack_underflow_frontend/mypage/user/user_preferences.dart';

import 'user/user_data.dart';

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              ProfileWidget(imagePath: user.imagePath, onClicked: () async {}),
              const SizedBox(height: 24),
              buildName(user),
            ],
          ),
        )
      ),
    );
  }

  Widget buildName(User user) => Column(
    children: [
      Text(
        user.name,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      const SizedBox(height: 4),
      Text(
        user.email,
        style: TextStyle(color: Colors.grey),
      )
    ],
  );

}
