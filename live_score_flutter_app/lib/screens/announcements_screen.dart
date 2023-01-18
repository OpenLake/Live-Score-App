import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:live_score_flutter_app/providers/games_users_provider.dart';
import 'package:provider/provider.dart';

import '../models/announcement.dart';

class AnnouncementScreen extends StatelessWidget {
  static const id = 'announcement';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Announcements 🔊"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: FutureBuilder(
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

            return Column(
              children: [
                NotificationDropdown(),
                Expanded(
                  child: GroupedListView(
                    elements: announcementList,
                    groupComparator: (value1, value2) =>
                        -1 * value1.compareTo(value2),
                    groupBy: (element) => element.createdOn.substring(0, 10),
                    groupSeparatorBuilder: (String value) => Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.40,
                        padding: const EdgeInsets.all(10.0),
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        decoration: const BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        child: Text(
                          DateFormat('dd MMM yyyy')
                              .format(DateTime.parse(value)),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    itemBuilder: (context, element) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        child: ListTile(
                          title: Text(
                              '${element.creatorName} (${element.collegeName})',
                              style: const TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.w700)),
                          subtitle: Text(element.message),
                          trailing: Text(
                            DateFormat('kk:mm')
                                .format(DateTime.parse(element.createdOn)),
                            textAlign: TextAlign.right,
                          ),
                          textColor: Colors.white,
                          tileColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            // side: const BorderSide(width: 1, color: Colors.grey),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class NotificationDropdown extends StatefulWidget {
  @override
  State<NotificationDropdown> createState() => _NotificationDropdownState();
}

class _NotificationDropdownState extends State<NotificationDropdown> {
  @override
  Widget build(BuildContext context) {
    final dropDownNode = FocusNode();
    final myFuture =
        Provider.of<GameUsersProvider>(context, listen: false).getAllColleges();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7.5),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Subscribe to Notification: '),
          FutureBuilder<Map<String, bool>>(
              future: myFuture,
              builder: (context, snapshot) {
                Map<String, bool> collegeMap = {'All': false};
                if (snapshot.hasData) {
                  collegeMap = snapshot.data ?? {};
                  return DropdownButton(
                      focusNode: dropDownNode,
                      hint: const Text('Select Colleges'),
                      items: collegeMap.keys
                          .map((e) => DropdownMenuItem(
                              value: e,
                              child: Row(children: [
                                Checkbox(
                                    tristate: true,
                                    value: collegeMap[e],
                                    onChanged: (value) async {
                                      Navigator.pop(dropDownNode.context!);
                                      showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) => const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ));
                                      await Provider.of<GameUsersProvider>(
                                              context,
                                              listen: false)
                                          .subscribeToCollege(
                                              value ?? false, e);
                                      Navigator.pop(context);
                                      setState(() {
                                      });
                                    }),
                                Text(e),
                              ])))
                          .toList(),
                      onChanged: (value) {});
                } else {
                  return DropdownButton(
                      hint: const Text('Select College'),
                      items: ['All']
                          .map((e) => DropdownMenuItem(
                              value: e,
                              child: Row(children: [
                                Checkbox(
                                    value: collegeMap[e],
                                    onChanged: (value) async {}),
                                Text(e)
                              ])))
                          .toList(),
                      onChanged: (value) {
                        Navigator.pop(context);
                      });
                }
              })
        ],
      ),
    );
  }
}
