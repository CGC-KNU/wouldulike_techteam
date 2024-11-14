import 'package:flutter/material.dart';

class MyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('마이 화면')),
      body: Center(
        child: Text(
          '마이 화면입니다.',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
