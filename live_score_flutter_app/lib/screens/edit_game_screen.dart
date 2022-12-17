import 'package:flutter/material.dart';

class EditGameScreen extends StatelessWidget {

  static const id = 'editgame';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Edit the game here'),
      ),
    );
  }
}
