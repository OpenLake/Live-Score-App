# Live Score Flutter App
<p align="center">
<img src="https://github.com/FaizFk/Live-Score-App/blob/dev/live_score_flutter_app/Screenshots/live_score_icon.png?raw=true" width="23%"></img> 
</p>

Many times a lot of games like cricket, football, badminton are occuing in your college but you are very lazy to attend these live or maybe you are at your home or not available at college and unfortunately you have to miss these events and its thrill.
But now no need to be disheartened, Live Score App will not only let you know the live score but also see its highlights moments. You will also get notified for the upcoming games in your college or any other college. You can take a look at the previous games too.
Made using Firebase and Flutter

## Features

- **Ongoing Section:** View the score and highlights live                                                                                                                                                                               
<p align="center">
<img src="https://github.com/FaizFk/Live-Score-App/blob/dev/live_score_flutter_app/Screenshots/ongoing.jpg?raw=true" width="23%"></img> 
<img src="https://github.com/FaizFk/Live-Score-App/blob/dev/live_score_flutter_app/Screenshots/ongoing-details.jpg?raw=true" width="23%"></img> 
</p>



- **Previous Section:** View the score, highlights and winner of the previous games

<p align="center">
<img src="https://github.com/FaizFk/Live-Score-App/blob/dev/live_score_flutter_app/Screenshots/previous.jpg?raw=true" width="23%"></img> 
<img src="https://github.com/FaizFk/Live-Score-App/blob/dev/live_score_flutter_app/Screenshots/previous-details.jpg?raw=true" width="23%"></img> 
</p>

- **Announcement Section:** Get notified about the upcoming games as well as choose to subscribe to your interest college notifications

<p align="center">
<img src="https://github.com/FaizFk/Live-Score-App/blob/dev/live_score_flutter_app/Screenshots/announcements.jpg?raw=true" width="23%"></img> 
<img src="https://github.com/FaizFk/Live-Score-App/blob/dev/live_score_flutter_app/Screenshots/announcement-settings.jpg?raw=true" width="23%"></img> 
</p>

- **Authentication Section:** Login or signup to create games
<p align="center">
<img src="https://github.com/FaizFk/Live-Score-App/blob/dev/live_score_flutter_app/Screenshots/login.jpg?raw=true" width="23%"></img> 
<img src="https://github.com/FaizFk/Live-Score-App/blob/dev/live_score_flutter_app/Screenshots/signup.jpg?raw=true" width="23%"></img> 
</p>

- **Admin Section:** Create games occuring in your college and update its score accordingly. You can also choose to notify users about upcoming games

<p align="center">
<img src="https://github.com/FaizFk/Live-Score-App/blob/dev/live_score_flutter_app/Screenshots/admin-screen.jpg?raw=true" width="23%"></img> 
<img src="https://github.com/FaizFk/Live-Score-App/blob/dev/live_score_flutter_app/Screenshots/score-controller.jpg?raw=true" width="23%"></img> 
<img src="https://github.com/FaizFk/Live-Score-App/blob/dev/live_score_flutter_app/Screenshots/create-game.jpg?raw=true" width="23%"></img> 
</p>


# Demo Video

Here is the demo video of working of this app: [Watch the Video](https://youtu.be/RqpSwHATNSU)

## How to Run

1. Download or Clone the repo
2. Install all the packages by typing the following command into your terminal

   ```sh
   flutter pub get
   ```
3. Go to [games-admin-provider](lib/providers/games_admin_provider.dart) file and replace **${dotenv.env["SERVER_KEY"]}** with the firebase server key

```dart
   Future<void> sendNotificationToDevices(
      String title, String body, String topic) async {
    await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=${dotenv.env["SERVER_KEY"]}',
        },
        body: jsonEncode({
          "condition": "'$topic' in topics || 'All' in topics",
          'notification': {
            'android_channel_id': 'pushnotificationapp',
            'title': title,
            'body': body,
          },
        }));
  }
```

### Apk link: 
[Live Score Apk Download](https://drive.google.com/file/d/15Oe7inzXqqoRK0KAg_L7alOm9GaOZX8C/view?usp=share_link)

## Contact

- [Faiz Khan](https://github.com/FaizFk/) | [LinkedIn](https://linkedin.com/in/faiz-khan-4793731ba/)
