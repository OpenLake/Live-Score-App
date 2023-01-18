import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:live_score_flutter_app/providers/auth_provider.dart';
import 'package:live_score_flutter_app/screens/admin_screen.dart';
import 'package:live_score_flutter_app/utils.dart';
import 'package:live_score_flutter_app/widgets/custom_button.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_textfield.dart';

class SignupScreen extends StatefulWidget {
  static const id = 'signupscreen';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController nameTextController = TextEditingController();

  TextEditingController emailTextController = TextEditingController();

  TextEditingController passwordTextController = TextEditingController();

  TextEditingController collegeNameTextController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    nameTextController.dispose();
    emailTextController.dispose();
    passwordTextController.dispose();
    collegeNameTextController.dispose();
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.40,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  "assets/signup_bg.png",
                  fit: BoxFit.cover,
                ),
              ),
              Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomTextField(
                      textController: nameTextController,
                      placeholderText: "Name",
                      icon: Icons.person,
                    ),
                    CustomTextField(
                      textController: collegeNameTextController,
                      placeholderText: "College Name",
                      icon: Icons.school,
                    ),
                    CustomTextField(
                      textController: emailTextController,
                      placeholderText: "Email",
                      icon: Icons.email,
                    ),
                    CustomTextField(
                      textController: passwordTextController,
                      placeholderText: "Password",
                      icon: Icons.lock,
                      hideText: true,
                    ),
                    CustomButton(
                      title: "Signup",
                      color:Colors.green,
                      textColor: Colors.white,
                      onTap: () async {
                        final valid = formKey.currentState!.validate();
                        if (!valid) return;
                        //Firebase Signup will take place here

                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => const Center(
                                  child: CircularProgressIndicator(),
                                ));
                        await AuthProvider.signUp(
                            email: emailTextController.text.toUpperCase(),
                            password: passwordTextController.text.toUpperCase(),
                            name: nameTextController.text.toUpperCase(),
                            collegeName: collegeNameTextController.text.toUpperCase());
                        Navigator.pop(context);
                        if (auth.currentUser != null) {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            AdminScreen.id,
                            (Route<dynamic> route) => false,
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
