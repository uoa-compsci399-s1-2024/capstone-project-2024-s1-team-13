class NotificationItem {
  final String type;
  final String notificationTitle;
  final DateTime dateTime;
  final String description;

  NotificationItem(
      {required this.type,
      required this.notificationTitle,
      required this.dateTime,
      required this.description});
}
