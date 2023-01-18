import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:live_score_flutter_app/screens/admin_screen.dart';
import 'package:live_score_flutter_app/widgets/custom_button.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  static const id = 'loginscreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final nameTextController = TextEditingController();

  final emailTextController = TextEditingController();

  final passwordTextController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    nameTextController.dispose();
    emailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(height:40.0),
              Image.asset("assets/login_bg.png"),
              SizedBox(height:MediaQuery.of(context).size.height * 0.10),
              Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomTextField(
                      textController: emailTextController,
                      placeholderText: "Email",
                      icon:Icons.email,
                    ),
                    CustomTextField(
                      textController: passwordTextController,
                      placeholderText: "Password",
                      icon:Icons.lock,
                      hideText: true,
                    ),
                    CustomButton(
                        title: "Login",
                        color: Colors.blue,
                        textColor: Colors.white,
                        onTap: () async {
                          final isValid = formKey.currentState!.validate();
                          if (!isValid) return;
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => const Center(
                                    child: CircularProgressIndicator(),
                                  ));
                          await AuthProvider.logIn(
                              email: emailTextController.text.toUpperCase(),
                              password: passwordTextController.text.toUpperCase());
                          Navigator.pop(context);
                          if (auth.currentUser != null) {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              AdminScreen.id,
                              (Route<dynamic> route) => false,
                            );
                          }
                        })
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}


