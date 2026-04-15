import 'package:flutter/material.dart';
import 'package:laundry_app/features/chat/domain/models/message.dart';
import 'package:laundry_app/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:laundry_app/core/services/api_services.dart';

class ChatProvider with ChangeNotifier {
  final ChatRepositoryImpl _repository;

  List<Message> _messages = [];
  bool _isLoading = false;

  List<Message> get messages => _messages;
  bool get isLoading => _isLoading;

  ChatProvider()
      : _repository = ChatRepositoryImpl(apiService: MockApiService()) {
    // Auto load
  }

  Future<void> loadMessages(String chatId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _messages = await _repository.getMessages(chatId);
    } catch (e) {
      _messages = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> sendMessage(String chatId, String content) async {
    final message = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      chatId: chatId,
      senderId: 'user1',
      content: content,
      type: MessageType.text,
      sentAt: DateTime.now(),
    );

    await _repository.sendMessage(message);
    _messages.add(message);
    notifyListeners();
  }

  void clearMessages() {
    _messages.clear();
    notifyListeners();
  }
}
