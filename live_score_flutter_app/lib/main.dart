import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:live_score_flutter_app/providers/games_admin_provider.dart';
import 'package:live_score_flutter_app/providers/games_users_provider.dart';
import 'package:live_score_flutter_app/screens/announcements_screen.dart';
import 'package:live_score_flutter_app/screens/auth_screen.dart';
import 'package:live_score_flutter_app/screens/create_game_screen.dart';
import 'package:live_score_flutter_app/screens/edit_game_screen.dart';
import 'package:live_score_flutter_app/screens/login_screen.dart';
import 'package:live_score_flutter_app/screens/ongoing_games_screen.dart';
import 'package:live_score_flutter_app/screens/previous_games_screen.dart';
import 'package:live_score_flutter_app/screens/signup_screen.dart';
import 'package:live_score_flutter_app/screens/admin_screen.dart';
import 'package:live_score_flutter_app/utils.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'notificationservice/local_notification_service.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  LocalNotificationService.initialize();
  await dotenv.load();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("Called when app is fully closed");
      },
    );

    FirebaseMessaging.onMessage.listen(
      (message) {
        print("Called when app is opened in foreground");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("Called when app is minimized");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
        }
      },
    );

    //Subscribing to topic 'All' if first installing the app
    GameUsersProvider.subscribeToAllIfFirstTime();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool isAuth = FirebaseAuth.instance.currentUser != null;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GamesAdminProvider()),
        ChangeNotifierProvider(create: (context) => GameUsersProvider())
      ],
      child: MaterialApp(
        scaffoldMessengerKey: Utils.messengerKey,
        initialRoute: isAuth ? AdminScreen.id : OngoingGamesScreen.id,
        routes: {
          OngoingGamesScreen.id: (context) => OngoingGamesScreen(),
          AuthScreen.id: (context) => AuthScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          SignupScreen.id: (context) => SignupScreen(),
          AnnouncementScreen.id: (context) => AnnouncementScreen(),
          AdminScreen.id: (context) => AdminScreen(),
          CreateGameScreen.id: (context) => CreateGameScreen(),
          EditGameScreen.id: (context) => EditGameScreen(),
          PreviousGamesScreen.id: (context) => PreviousGamesScreen(),
        },
      ),
    );
  }
}
