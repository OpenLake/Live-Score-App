import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:live_score_flutter_app/providers/auth_provider.dart';
import 'package:live_score_flutter_app/screens/announcements_screen.dart';
import 'package:live_score_flutter_app/screens/auth_screen.dart';
import 'package:live_score_flutter_app/screens/login_screen.dart';
import 'package:live_score_flutter_app/screens/ongoing_games_screen.dart';
import 'package:live_score_flutter_app/screens/signup_screen.dart';
import 'package:live_score_flutter_app/screens/user_screen.dart';
import 'package:live_score_flutter_app/utils.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool isAuth = FirebaseAuth.instance.currentUser != null;
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        scaffoldMessengerKey: Utils.messengerKey,
        initialRoute: isAuth ? UserScreen.id : OngoingGamesScreen.id,
        routes: {
          OngoingGamesScreen.id: (context) => OngoingGamesScreen(),
          AuthScreen.id: (context) => AuthScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          SignupScreen.id: (context) => SignupScreen(),
          AnnouncementScreen.id: (context) => AnnouncementScreen(),
          UserScreen.id: ((context) => UserScreen())
        },
      ),
    );
  }
}
