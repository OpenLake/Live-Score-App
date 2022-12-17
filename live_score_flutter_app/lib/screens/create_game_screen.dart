import 'package:flutter/material.dart';
import 'package:live_score_flutter_app/screens/edit_game_screen.dart';

class CreateGameScreen extends StatelessWidget {
  static const id = 'creategame';

  final team1TextController = TextEditingController();
  final team2TextController = TextEditingController();
  final descriptionTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextField(
                textController: team1TextController,
                placeholderText: "Team 1",
              ),
              const Text('VS'),
              CustomTextField(
                textController: team2TextController,
                placeholderText: "Team 2",
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SizedBox(
                  width: 0.75 * MediaQuery.of(context).size.width,
                  child: TextFormField(
                    controller: descriptionTextController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                      labelText: 'Description',
                      hintText: 'Enter Description',
                    ),
                  ),
                ),
              ),
              MaterialButton(
                height: 50,
                minWidth: 120,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                color: Colors.green,
                onPressed: () {
                  final isValid = formKey.currentState!.validate();
                  if (isValid) return;
                  Navigator.pushNamed(context, EditGameScreen.id);
                },
                child: const Text('Next',
                    style: TextStyle(color: Colors.white, fontSize: 22)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    this.hideText = false,
    this.lines = 1,
    required this.textController,
    required this.placeholderText,
  });

  final bool hideText;
  final TextEditingController textController;
  final String placeholderText;
  final int lines;

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
          validator: (value) =>
              value != null && value.isEmpty ? 'Enter min 1 character' : null,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: placeholderText,
          ),
        ),
      ),
    );
  }
}
