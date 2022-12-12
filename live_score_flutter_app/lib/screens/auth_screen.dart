import 'package:flutter/material.dart';
import 'package:live_score_flutter_app/screens/login_screen.dart';
import 'package:live_score_flutter_app/screens/signup_screen.dart';

class AuthScreen extends StatelessWidget {
  static final id = 'authscreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AuthButton(
            title: 'Login',
            color: Colors.blue,
            onTap: () {
              Navigator.pushNamed(context, LoginScreen.id);
            },
          ),
          const SizedBox(height: 20,),
           AuthButton(
            title: 'Signup',
            color: Colors.red,
            onTap: () {
              Navigator.pushNamed(context, SignupScreen.id);
            },
          )
        ],
      )),
    );
  }
}

class AuthButton extends StatelessWidget {
  String? title;
  Color? color;
  VoidCallback? onTap;
  AuthButton({this.title, this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 150,
      height: 50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
      color: color,
      onPressed: onTap,
      child: Text(title ?? '',style: TextStyle(color: Colors.white,fontSize: 25),),
    );
  }
}
