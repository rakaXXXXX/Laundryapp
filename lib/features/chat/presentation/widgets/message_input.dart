import 'package:flutter/material.dart';
import 'package:laundry_app/core/constants/app_colors.dart';

class MessageInput extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onSend;
  final VoidCallback onAttachment;
  final Function()? onEmoji;
  final Function()? onVoice;

  const MessageInput({
    super.key,
    required this.controller,
    required this.onSend,
    required this.onAttachment,
    this.onEmoji,
    this.onVoice,
  });

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _hasText = widget.controller.text.trim().isNotEmpty;
    });
  }

  void _handleSend() {
    final text = widget.controller.text.trim();
    if (text.isNotEmpty) {
      widget.onSend(text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.darkSurface : Colors.white,
        border: Border(
          top: BorderSide(
            color: isDarkMode
                ? AppColors.darkTextSecondary.withOpacity(0.1)
                : AppColors.lightTextSecondary.withOpacity(0.1),
          ),
        ),
      ),
      child: Row(
        children: [
          // Attachment Button
          IconButton(
            onPressed: widget.onAttachment,
            icon: Icon(
              Icons.attach_file,
              color: isDarkMode
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
            ),
          ),
          // Emoji Button
          IconButton(
            onPressed: widget.onEmoji,
            icon: Icon(
              Icons.emoji_emotions_outlined,
              color: isDarkMode
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
            ),
          ),
          // Text Field
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? AppColors.darkBackground
                    : AppColors.lightBackground,
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextField(
                controller: widget.controller,
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: isDarkMode
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
                ),
                onSubmitted: (value) => _handleSend(),
                maxLines: 5,
                minLines: 1,
              ),
            ),
          ),
          // Send/Voice Button
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: _hasText
                ? IconButton(
                    onPressed: _handleSend,
                    icon: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: AppColors.primaryGradient,
                      ),
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  )
                : IconButton(
                    onPressed: widget.onVoice,
                    icon: Icon(
                      Icons.mic,
                      color: isDarkMode
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}