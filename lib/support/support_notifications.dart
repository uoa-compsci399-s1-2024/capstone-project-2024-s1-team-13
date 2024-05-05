import 'package:flutter/material.dart';
import 'package:inka_test/modules/module_items/notification_item.dart';

// Temporary screen for notifications - perhaps a Notification Listener should be used
class SupportNotifications extends StatelessWidget {
  SupportNotifications({super.key, required this.title});
  final String title;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
            iconSize: 40,
            icon: Icon(Icons.arrow_back_ios_rounded),
            padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),

      // Body of screen
      body: Center(
          child: Column(
        children: [
          Expanded(
              child: ListView.builder(
            itemCount: mockNotifs.length,
            itemBuilder: (context, index) {
              final note = mockNotifs[index];
              return _NotifCard(note);
            },
          ))
        ],
      )),
    );
  }

  // Widgets
  // Notification Widget
  Widget _NotifCard(notification) => Card(
      margin: EdgeInsets.all(15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      elevation: 2,
      color: Colors.white,
      child: ListTile(
          title: Padding(
              padding: EdgeInsets.all(30),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${notification.notificationTitle}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: "Lexend Exa",
                          fontSize: 35,
                          fontWeight: FontWeight.w500,
                        )),
                    Text('${notification.dateTime}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: "Lexend Exa",
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[400]))
                  ])),
          subtitle: Padding(
              padding: EdgeInsets.only(left: 30, right: 30, bottom: 30),
              child: _getIcon(notification))));

// Mock Data
  final List<NotificationItem> mockNotifs = [
    NotificationItem(
        type: 'task',
        notificationTitle: 'Task Added',
        dateTime: DateTime.now(),
        description: 'Opening'),
    NotificationItem(
        type: 'task',
        notificationTitle: 'Task Added',
        dateTime: DateTime.now(),
        description: 'Closing'),
    NotificationItem(
        type: 'trainee',
        notificationTitle: 'Trainee Added',
        dateTime: DateTime.now(),
        description: 'Jack Sparrow'),
  ];

  // Mock Function
  Widget? _getIcon(notif) {
    if (notif.type == 'trainee') {
      return Row(
        children: [
          CircleAvatar(
              foregroundImage:
                  AssetImage('assets/images/trainee_placeholder.jpeg'),
              radius: 40),
          SizedBox(width: 50),
          Text("${notif.description}",
              maxLines: 2,
              style: TextStyle(
                  fontFamily: 'Lexend Exa',
                  fontSize: 30,
                  fontWeight: FontWeight.w500))
        ],
      );
    } else {
      return Row(
        children: [
          Icon(
            Icons.task_rounded,
            size: 50,
            color: Colors.pink[900],
          ),
          SizedBox(width: 15),
          Text("${notif.description}",
              maxLines: 2,
              style: TextStyle(
                  fontFamily: 'Lexend Exa',
                  fontSize: 30,
                  fontWeight: FontWeight.w500))
        ],
      );
    }
  }
}
