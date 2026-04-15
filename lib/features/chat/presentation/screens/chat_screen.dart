import 'package:flutter/material.dart';
import 'package:laundry_app/core/constants/app_colors.dart';
import 'package:laundry_app/features/chat/presentation/widgets/chat_bubble.dart';
import 'package:laundry_app/features/chat/presentation/widgets/message_input.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [
    ChatMessage(
      id: '1',
      text: 'Hello! How can I help you with your laundry?',
      isSentByMe: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
      senderName: 'Laundry Support',
    ),
    ChatMessage(
      id: '2',
      text: 'Hi! I wanted to check the status of my order #LAU-2024-00123',
      isSentByMe: true,
      timestamp: DateTime.now().subtract(const Duration(minutes: 9)),
    ),
    ChatMessage(
      id: '3',
      text: 'Your order is currently being processed. It should be ready for pickup by 5 PM today.',
      isSentByMe: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 8)),
      senderName: 'Laundry Support',
    ),
    ChatMessage(
      id: '4',
      text: 'Great! Can I get it delivered instead?',
      isSentByMe: true,
      timestamp: DateTime.now().subtract(const Duration(minutes: 7)),
    ),
    ChatMessage(
      id: '5',
      text: 'Sure! We can arrange delivery for an additional \$2.99. Would you like to proceed?',
      isSentByMe: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 6)),
      senderName: 'Laundry Support',
    ),
  ];
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    // Simulate typing indicator
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isTyping = true;
        });
      }
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            _isTyping = false;
            _messages.add(
              ChatMessage(
                id: '6',
                text: 'Yes, please arrange delivery. Thank you!',
                isSentByMe: false,
                timestamp: DateTime.now(),
                senderName: 'Laundry Support',
              ),
            );
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: AppColors.lightPrimary,
              child: Icon(
                Icons.store,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Laundry Pro Support',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Online',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.green,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          // Order Info Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.lightPrimary.withOpacity(0.1),
              border: Border(
                bottom: BorderSide(
                  color: AppColors.lightPrimary.withOpacity(0.2),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order #LAU-2024-00123',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Text(
                      'Status: Processing',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.lightTextSecondary,
                          ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    // View order details
                  },
                  child: const Text('View Details'),
                ),
              ],
            ),
          ),
          // Chat Messages
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.1),
                    Colors.white.withOpacity(0.05),
                  ],
                ),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                reverse: true,
                itemCount: _messages.length + (_isTyping ? 1 : 0),
                itemBuilder: (context, index) {
                  if (_isTyping && index == 0) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.lightSurface,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      AppColors.lightPrimary,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text('typing...'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  final messageIndex = _isTyping ? index - 1 : index;
                  final message = _messages.reversed.toList()[messageIndex];
                  final showAvatar = messageIndex == _messages.length - 1 ||
                      _messages.reversed.toList()[messageIndex].isSentByMe !=
                          message.isSentByMe;

                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: messageIndex < _messages.length - 1 &&
                              _messages.reversed.toList()[messageIndex + 1].isSentByMe ==
                                  message.isSentByMe
                          ? 4
                          : 16,
                    ),
                    child: ChatBubble(
                      message: message,
                      showAvatar: showAvatar,
                    ),
                  );
                },
              ),
            ),
          ),
          // Message Input
          MessageInput(
            controller: _messageController,
            onSend: _sendMessage,
            onAttachment: _addAttachment,
          ),
        ],
      ),
    );
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add(
        ChatMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: text,
          isSentByMe: true,
          timestamp: DateTime.now(),
        ),
      );
    });

    _messageController.clear();

    // Simulate reply
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _messages.add(
            ChatMessage(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              text: 'Thank you for your message. We\'ll get back to you shortly.',
              isSentByMe: false,
              timestamp: DateTime.now(),
              senderName: 'Laundry Support',
            ),
          );
        });
      }
    });
  }

  void _addAttachment() {
    // Implement attachment functionality
  }
}

class ChatMessage {
  final String id;
  final String text;
  final bool isSentByMe;
  final DateTime timestamp;
  final String? senderName;

  ChatMessage({
    required this.id,
    required this.text,
    required this.isSentByMe,
    required this.timestamp,
    this.senderName,
  });
}