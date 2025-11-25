import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../core/exceptions/app_exceptions.dart';
import '../../../services/chatbot_services/chatbot_api_service.dart';

class ChatbotController extends GetxController {
  var responseText = "".obs;
  var decResponseText = "".obs;
  var messages = <Map<String, dynamic>>[].obs;
  var isTypeing = false.obs;

  Future<void> sendMessage(String message) async {
    messages.add({
      'text': message,
      'isUser': true,
      'time': DateFormat('hh:mm a').format(DateTime.now())
    });
    responseText.value = "Thinking...";
    isTypeing.value = true;
    update();

    try {
      String reply = await ChatbotApiService.getApiResponse(message);
      responseText.value = reply;
      messages.add({
        'text': reply,
        'isUser': false,
        'time': DateFormat('hh:mm a').format(DateTime.now())
      });
    }
    on InternetException catch (e) {
      _handleError(e.toString());
    }

    on RequestTimeOut {
      _handleError("The server took too long to respond.");
    }

    on ServerException {
      _handleError("Server is currently unavailable. Try again later.");
    }

    on InvalidUrlException {
      _handleError("API configuration error. Check your API URL.");
    }

    on FetchDataException {
      _handleError("Something went wrong, please try again.");
    }
    catch (e) {
      _handleError("Unexpected Error: $e");
    }

    finally {
      isTypeing.value = false;
      update();
    }
  }

  Future<String> sendDetectorMessage(String descriptionMessage) async {
  try {
    isTypeing.value = true;
    update();

    String reply = await ChatbotApiService.getApiResponse(descriptionMessage);
    decResponseText.value = reply;

    return reply;
  }
  catch (e) {
    decResponseText.value = "$e";
    return responseText.value;
  }
  finally {
    isTypeing.value = false;
    update();
  }
}

  void _handleError(String errorMessage) {
    responseText.value = errorMessage;
    messages.add({
      'text': errorMessage,
      'isUser': false,
      'time': DateFormat('hh:mm a').format(DateTime.now())
    });
  }
}
