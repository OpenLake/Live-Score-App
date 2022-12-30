import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:live_score_flutter_app/providers/games_users_provider.dart';
import 'package:provider/provider.dart';

import '../models/announcement.dart';

class AnnouncementScreen extends StatelessWidget {
  static const id = 'announcement';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: Provider.of<GameUsersProvider>(context, listen: false)
            .getAnnouncements(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Text('Some error occured');
          }

          if (!snapshot.hasData) {
            return const Text('No Announcements 👍');
          }

          List<Announcement> announcementList = [];
          announcementList = List<Announcement>.from(
              snapshot.data.docs.map((DocumentSnapshot e) {
            return Announcement.fromJson(e.data() as Map<String, dynamic>);
          }).toList());

          announcementList
              .sort((a, b) => -1 * a.createdOn.compareTo(b.createdOn));

          return ListView.builder(
              itemCount: announcementList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(announcementList[index].message),
                  subtitle: Text(
                      '${announcementList[index].creatorName} (${announcementList[index].collegeName})'),
                  trailing: Text(
                    DateFormat('dd MMMM yyyy\nkk:mm').format(
                        DateTime.parse(announcementList[index].createdOn)),
                    textAlign: TextAlign.right,
                  ),
                );
              });
        },
      ),
    );
  }
}
