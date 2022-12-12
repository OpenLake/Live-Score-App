import 'package:flutter/material.dart';
import 'package:live_score_flutter_app/screens/auth_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        ListTile(
          title: const Text('Login/Signup'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, AuthScreen.id);
          },
        ),
        const ListTile(
          title: Text('Previous Games'),
        )
      ]),
    );
  }
}
