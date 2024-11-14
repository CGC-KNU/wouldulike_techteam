import 'package:flutter/material.dart';

class WishlistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('찜 화면')),
      body: Center(
        child: Text(
          '찜 화면입니다.',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
