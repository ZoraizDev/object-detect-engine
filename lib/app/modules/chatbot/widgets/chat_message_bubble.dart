import 'package:chat_bubbles/bubbles/bubble_special_two.dart';
import 'package:flutter/material.dart';

class ChatMessageBubble extends StatelessWidget {
  final String text;
  final String time;
  final bool isUser;
  final Color senderColor;
  final Color receiverColor;

  const ChatMessageBubble({
    super.key,
    required this.text,
    required this.time,
    required this.isUser,
    required this.senderColor,
    required this.receiverColor,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          BubbleSpecialTwo(
            isSender: isUser,
            color: isUser ? senderColor : receiverColor,
            text:text,
            tail: true,
            seen: true,
            textStyle: const TextStyle(
              
              color: Colors.black,
              fontSize: 14,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 20),
            child: Text(
              time,
              style: const TextStyle(
                fontSize: 10,
                color: Color(0xFF808080),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
