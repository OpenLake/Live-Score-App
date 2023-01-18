import 'package:flutter/material.dart';
import 'package:live_score_flutter_app/screens/login_screen.dart';
import 'package:live_score_flutter_app/screens/signup_screen.dart';
import 'package:live_score_flutter_app/widgets/custom_button.dart';

class AuthScreen extends StatelessWidget {
  static final id = 'authscreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height:20.0),
            Hero(tag:"main-image",child: Image.asset("assets/sports_auth.png")),
            SizedBox(height:MediaQuery.of(context).size.height * 0.1),
            Column(children: [
              CustomButton(
                title: 'Login',
                color: Colors.blue,
                textColor:Colors.white,
                onTap: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
              ),
              const SizedBox(height:20.0),
              CustomButton(
                title: 'Signup',
                color: Colors.white,
                textColor: Colors.black,
                onTap: () {
                  Navigator.pushNamed(context, SignupScreen.id);
                },
              )
            ]),
          ],
        ),
      ),
    );
  }
}

