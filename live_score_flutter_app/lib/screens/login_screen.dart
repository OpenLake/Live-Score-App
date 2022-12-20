import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:live_score_flutter_app/screens/user_screen.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class LoginScreen extends StatelessWidget {
  static const id = 'loginscreen';

  final nameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  final formKey = GlobalKey<FormState>();

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
                    final isValid = formKey.currentState!.validate();
                    if (!isValid) return;
                    //Firebase Login will be here
                    final authProv =
                        Provider.of<AuthProvider>(context, listen: false);
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => const Center(
                              child: CircularProgressIndicator(),
                            ));
                    await authProv.logIn(
                        email: emailTextController.text,
                        password: passwordTextController.text);
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
  const CustomTextField({
    this.hideText = false,
    required this.textController,
    required this.placeholderText,
  });

  final bool hideText;
  final TextEditingController textController;
  final String placeholderText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: 0.75 * MediaQuery.of(context).size.width,
        child: TextFormField(
          controller: textController,
          obscureText: hideText,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) => value != null && value.isEmpty
              ? 'Enter min 1 character'
              : null,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: placeholderText,
          ),
        ),
      ),
    );
  }
}
