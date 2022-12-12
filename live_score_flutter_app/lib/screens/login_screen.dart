import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static final id = 'loginscreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text('This is login screen')),
    );
  }
}