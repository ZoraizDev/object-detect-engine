import 'dart:async';

import 'package:detectai/app/modules/chatbot/controllers/chatbot_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../resources/colors/app_colors.dart';
import '../widgets/chat_message_bubble.dart';
import '../widgets/message_input_field.dart';
import '../widgets/typing_indicator.dart';
class ChatbotView extends StatefulWidget {
  const ChatbotView({super.key});

  @override
  State<ChatbotView> createState() => _ChatbotViewState();
}

class _ChatbotViewState extends State<ChatbotView> {
  final TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final chatbotController = Get.find<ChatbotController>();
    late final StreamSubscription _msgSubscription;
  @override
  void initState() {
    super.initState();

    _msgSubscription =chatbotController.messages.listen((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    });
  }
@override
void dispose() {
  _msgSubscription.cancel();
  _scrollController.dispose();
  messageController.dispose();
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: AppBar(
          title: const Text("Chatbot"),
          centerTitle: true,
          backgroundColor: AppColor.whiteColor,
        ),
        body: Column(
          children: [
            Expanded(
              child: Obx(
                () => ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: chatbotController.messages.length,
                  itemBuilder: (_, index) {
                    final msg = chatbotController.messages[index];
                    return ChatMessageBubble(
                      text: msg['text'],
                      time: msg['time'],
                      isUser: msg['isUser'],
                      senderColor: AppColor.primaryColor,
                      receiverColor: AppColor.textformFieldColor,
                    );
                  },
                ),
              ),
            ),
            Obx(() => chatbotController.isTypeing.value
                ? TypingIndicator(text: chatbotController.responseText.value)
                : const SizedBox()),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: MessageInputField(
                controller: messageController,
                focusedBorderColor: AppColor.primaryColor,
                onSend: () {
                  if (messageController.text.isNotEmpty) {
                    chatbotController.sendMessage(messageController.text.trim());
                    messageController.clear();
                  }
                },
              ),
            ),
      
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
