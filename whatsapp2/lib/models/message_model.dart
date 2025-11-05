class Message {
  final String id;
  final String conversationId;
  final String senderId;
  final String senderName;
  final String content;
  final MessageType type;
  final DateTime createdAt;
  final DateTime? editedAt;
  final bool isDeleted;
  final String? mediaUrl;

  Message({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.senderName,
    required this.content,
    required this.type,
    required this.createdAt,
    this.editedAt,
    this.isDeleted = false,
    this.mediaUrl,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] as String,
      conversationId: json['conversation_id'] as String,
      senderId: json['sender_id'] as String,
      senderName: json['sender_name'] as String? ?? 'Usuário',
      content: json['content'] as String,
      type: MessageType.values.firstWhere(
        (e) => e.toString() == 'MessageType.${json['type']}',
        orElse: () => MessageType.text,
      ),
      createdAt: DateTime.parse(json['created_at'] as String),
      editedAt: json['edited_at'] != null 
          ? DateTime.parse(json['edited_at'] as String) 
          : null,
      isDeleted: json['is_deleted'] as bool? ?? false,
      mediaUrl: json['media_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'conversation_id': conversationId,
      'sender_id': senderId,
      'sender_name': senderName,
      'content': content,
      'type': type.toString().split('.').last,
      'created_at': createdAt.toIso8601String(),
      'edited_at': editedAt?.toIso8601String(),
      'is_deleted': isDeleted,
      'media_url': mediaUrl,
    };
  }

  bool get canEdit {
    final now = DateTime.now();
    final difference = now.difference(createdAt);
    return difference.inMinutes <= 15 && !isDeleted;
  }
}

enum MessageType {
  text,
  image,
  file,
}
