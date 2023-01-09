import 'package:flutter/material.dart';
import 'package:live_score_flutter_app/providers/games_admin_provider.dart';
import 'package:live_score_flutter_app/screens/edit_game_screen.dart';
import 'package:live_score_flutter_app/screens/admin_screen.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_textfield.dart';

class CreateGameScreen extends StatefulWidget {
  static const id = 'creategame';

  @override
  State<CreateGameScreen> createState() => _CreateGameScreenState();
}

class _CreateGameScreenState extends State<CreateGameScreen> {
  final team1TextController = TextEditingController();

  final team2TextController = TextEditingController();

  final descriptionTextController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  String selectedItem = 'Football ⚽';

  List<String> gamesList = ['Football ⚽', 'Cricket 🏏', 'Tennis 🎾','Other ❓'];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
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
                    width: 0.75 * size.width,
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
                Container(
                  width: 0.75 * MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      const Text('Choose Game:  '),
                      DropdownButton(
                          alignment: AlignmentDirectional.centerStart,
                          value: selectedItem,
                          items: gamesList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? item) {
                            setState(() {
                              selectedItem = item ?? "Football ⚽";
                            });
                          }),
                    ],
                  ),
                ),
                MaterialButton(
                  height: 50,
                  minWidth: 120,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  color: Colors.green,
                  onPressed: () async {
                    final gamesProvider =
                        Provider.of<GamesAdminProvider>(context, listen: false);
                    final isValid = formKey.currentState!.validate();
                    if (!isValid) return;
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                    await gamesProvider.addGame(
                        team1TextController.text.toUpperCase(),
                        team2TextController.text.toUpperCase(),
                        descriptionTextController.text.isEmpty?descriptionTextController.text:
                        descriptionTextController.text[0].toUpperCase()+descriptionTextController.text.substring(1),
                        selectedItem);
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, AdminScreen.id);
                  },
                  child: const Text('Next',
                      style: TextStyle(color: Colors.white, fontSize: 22)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


