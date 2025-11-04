class Conversation {
  final String id;
  final String contactName;
  final String lastMessage;
  final String time;
  final String profileImageUrl;
  final int unreadCount;
  final bool isOnline;

  Conversation({
    required this.id,
    required this.contactName,
    required this.lastMessage,
    required this.time,
    required this.profileImageUrl,
    this.unreadCount = 0,
    this.isOnline = false,
  });
}
