import 'package:flutter/material.dart';
import 'package:inka_test/modules/module_items/notification_item.dart';

// Temporary screen for notifications - perhaps a Notification Listener should be used
class ModulesNotifications extends StatelessWidget {
  ModulesNotifications({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
            iconSize: 40,
            icon: const Icon(Icons.arrow_back_ios_rounded),
            padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),

      // Bottom Navigation Bar -- needs working
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task_rounded),
            label: 'TASKS',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded),
            label: 'RECIPES',
          ),
        ],
        //currentIndex: _selectedIndex,
        //onTap: _onItemTapped,
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
                    Text('${notification.dateTime}',
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

// Mock Data (temporary)
  final List<NotificationItem> mockNotifs = [
    NotificationItem(
        type: 'task',
        notificationTitle: 'Task Added',
        dateTime: DateTime.now(),
        description: 'Opening'),
    NotificationItem(
        type: 'recipe',
        notificationTitle: 'Recipe Added',
        dateTime: DateTime.now(),
        description: 'Cupcakes'),
  ];

  // Mock Function
  Widget? _getIcon(notif) {
    if (notif.type == 'recipe') {
      return Row(
        children: [
          Icon(
            Icons.grid_view_rounded,
            size: 50,
            color: Colors.pink[900],
          ),
          const SizedBox(width: 15),
          Text("${notif.description}",
              maxLines: 2,
              style: const TextStyle(
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
          const SizedBox(width: 15),
          Text("${notif.description}",
              maxLines: 2,
              style: const TextStyle(
                  fontFamily: 'Lexend Exa',
                  fontSize: 30,
                  fontWeight: FontWeight.w500))
        ],
      );
    }
  }
}
