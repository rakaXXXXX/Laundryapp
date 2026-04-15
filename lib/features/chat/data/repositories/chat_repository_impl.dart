import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:laundry_app/features/chat/domain/models/message.dart';
import 'package:laundry_app/core/services/api_services.dart';

abstract class ChatRepository {
  Future<List<Message>> getMessages(String chatId);
  Future<Message> sendMessage(Message message);
}

class ChatRepositoryImpl implements ChatRepository {
  final ApiService _apiService;
  static const String _messagesKey = 'chat_messages';

  ChatRepositoryImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<List<Message>> getMessages(String chatId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final messagesJson = prefs.getStringList(_messagesKey) ?? [];
      final messages = <Message>[];
      for (final jsonStr in messagesJson) {
        final msgMap = json.decode(jsonStr) as Map<String, dynamic>;
        messages.add(Message.fromJson(msgMap));
      }
      return messages.where((m) => m.chatId == chatId).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<Message> sendMessage(Message message) async {
    final prefs = await SharedPreferences.getInstance();
    final messagesJson = prefs.getStringList(_messagesKey) ?? [];
    messagesJson.add(json.encode(message.toJson()));
    await prefs.setStringList(_messagesKey, messagesJson);

    await _apiService.post('/chat/messages', message.toJson());

    return message;
  }
}
