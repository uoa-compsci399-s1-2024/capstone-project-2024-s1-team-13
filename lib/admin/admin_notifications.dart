import 'package:flutter/material.dart';
import 'package:inka_test/modules/module_items/notification_item.dart';

// Temporary screen for notifications - perhaps a Notification Listener should be used
class AdminNotifications extends StatelessWidget {
  AdminNotifications({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
            iconSize: 40,
            icon: const Icon(Icons.arrow_back_ios_rounded),
            padding:
                const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
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
      margin: const EdgeInsets.all(15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      elevation: 2,
      color: Colors.white,
      child: ListTile(
          title: Padding(
              padding: const EdgeInsets.all(30),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${notification.notificationTitle}',
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontFamily: "Lexend Exa",
                          fontSize: 35,
                          fontWeight: FontWeight.w500,
                        )),
                    Text('${notification.dateTime}', // current time
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: "Lexend Exa",
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[400]))
                  ])),
          subtitle: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
              child: _getIcon(notification))));

// Mock Data
  final List<NotificationItem> mockNotifs = [
    NotificationItem(
        type: 'trainee',
        notificationTitle: 'Task Completion',
        dateTime: DateTime.now(),
        description: 'John has successfully completed a task.'),
    NotificationItem(
        type: 'trainee',
        notificationTitle: 'Task Completion',
        dateTime: DateTime.now(),
        description: 'Tom has successfully completed a task.')
  ];

  // Mock Function
  Widget? _getIcon(notif) {
    if (notif.type == 'trainee') {
      return Row(
        children: [
          const CircleAvatar(
              foregroundImage:
                  AssetImage('assets/images/trainee_placeholder.jpeg'),
              radius: 40),
          const SizedBox(width: 50),
          Text(
            "${notif.description}",
            maxLines: 3, // This property does not work - text overflow here?
            style: const TextStyle(
                fontFamily: 'Lexend Exa',
                fontSize: 30,
                fontWeight: FontWeight.w500),
          )
        ],
      );
    } else // In the case that the notificatiion is not related to a trainee.
    {
      return Row(
        children: [
          Icon(
            Icons.task_rounded,
            size: 50,
            color: Colors.pink[900],
          ),
          const SizedBox(width: 15),
          Text("${notif.description}",
              maxLines: 3, // This property does not work - text overflow
              style: const TextStyle(
                  fontFamily: 'Lexend Exa',
                  fontSize: 30,
                  fontWeight: FontWeight.w500))
        ],
      );
    }
  }
}
