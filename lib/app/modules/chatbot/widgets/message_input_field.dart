import 'package:flutter/material.dart';

class MessageInputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final Color focusedBorderColor;

  const MessageInputField({
    super.key,
    required this.controller,
    required this.onSend,
    required this.focusedBorderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: "Type a message...",
              filled: true,
              fillColor: Colors.white,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: focusedBorderColor, width: 2),
              ),
              suffixIcon: Icon(Icons.emoji_emotions_outlined),
            ),
          ),
        ),
        const SizedBox(width: 10),
        FloatingActionButton(
          heroTag: "send_button",
          onPressed: onSend,
          child: const Icon(Icons.send),
        )
      ],
    );
  }
}
