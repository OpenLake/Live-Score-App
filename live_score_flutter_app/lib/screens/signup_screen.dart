import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:live_score_flutter_app/providers/auth_provider.dart';
import 'package:live_score_flutter_app/screens/user_screen.dart';
import 'package:live_score_flutter_app/utils.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  static const id = 'signupscreen';

  TextEditingController nameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController collegeNameTextController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextField(
                  textController: nameTextController,
                  placeholderText: "Name",
                ),
                CustomTextField(
                  textController: collegeNameTextController,
                  placeholderText: "College Name",
                ),
                CustomTextField(
                  textController: emailTextController,
                  placeholderText: "Email",
                ),
                CustomTextField(
                  textController: passwordTextController,
                  placeholderText: "Password",
                  hideText: true,
                ),
                MaterialButton(
                  height: 50,
                  minWidth: 120,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  color: Colors.green,
                  onPressed: () async {
                    final valid = formKey.currentState!.validate();
                    if (!valid) return;
                    //Firebase Signup will take place here
                    final authProv =
                        Provider.of<AuthProvider>(context, listen: false);
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => const Center(
                              child: CircularProgressIndicator(),
                            ));
                    await authProv.signUp(
                        email: emailTextController.text,
                        password: passwordTextController.text,
                        name: nameTextController.text,
                        collegeName: collegeNameTextController.text);
                    Navigator.pop(context);
                    if (!authProv.error) {
                      Navigator.pushReplacementNamed(context, UserScreen.id);
                    }
                  },
                  child: const Text('Next',
                      style: TextStyle(color: Colors.white, fontSize: 22)),
                )
              ],
            ),
          ),
        ));
  }
}

class CustomTextField extends StatelessWidget {
  CustomTextField({
    this.hideText = false,
    required this.textController,
    required this.placeholderText,
  });

  bool hideText;
  TextEditingController textController;
  String placeholderText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: 0.75 * MediaQuery.of(context).size.width,
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) => value != null && value.isEmpty
              ? 'Enter min 1 characters'
              : null,
          controller: textController,
          obscureText: hideText,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: placeholderText,
          ),
        ),
      ),
    );
  }
}
