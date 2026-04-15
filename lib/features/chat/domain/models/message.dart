import 'package:equatable/equatable.dart';

enum MessageType { text, image }

class Message extends Equatable {
  final String id;
  final String chatId;
  final String senderId;
  final String content;
  final MessageType type;
  final DateTime sentAt;
  final bool isRead;

  const Message({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.content,
    required this.type,
    required this.sentAt,
    this.isRead = false,
  });

  factory Message.empty() {
    return Message(
      id: '',
      chatId: '',
      senderId: '',
      content: '',
      type: MessageType.text,
      sentAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chatId': chatId,
      'senderId': senderId,
      'content': content,
      'type': type.name,
      'sentAt': sentAt.toIso8601String(),
      'isRead': isRead,
    };
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] ?? '',
      chatId: json['chatId'] ?? '',
      senderId: json['senderId'] ?? '',
      content: json['content'] ?? '',
      type: MessageType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => MessageType.text,
      ),
      sentAt: DateTime.parse(json['sentAt'] ?? ''),
      isRead: json['isRead'] ?? false,
    );
  }

  @override
  List<Object?> get props =>
      [id, chatId, senderId, content, type, sentAt, isRead];
}
