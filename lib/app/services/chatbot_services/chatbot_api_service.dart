import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../core/exceptions/app_exceptions.dart';
import '../../resources/api_url/api_url_constants.dart';

class ChatbotApiService {
  static String apiKey = ApiUrlConstants.apiKey;
  static String baseUrl = ApiUrlConstants.baseUrl;

  static Future<String> getApiResponse(String message) async {
    final url = Uri.parse("$baseUrl$apiKey");

    try {
      final response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              "contents": [
                {
                  "parts": [
                    {"text": message},
                  ],
                },
              ],
            }),
          )
          .timeout(const Duration(seconds: 60));
      switch (response.statusCode) {
        case 200:
          final data = jsonDecode(response.body);

          if (data["candidates"] != null && data["candidates"].isNotEmpty) {
            var firstCandidate = data["candidates"][0];

            if (firstCandidate["content"] != null &&
                firstCandidate["content"]["parts"] != null &&
                firstCandidate["content"]["parts"].isNotEmpty) {
              return firstCandidate["content"]["parts"][0]["text"] ??
                  "AI response was empty.";
            }
          }
          return "AI did not return any content.";

        case 400:
        case 404:
          throw InvalidUrlException("Invalid URL or API endpoint!");

        case 500:
        case 503:
          throw ServerException("Server error occurred!");

        default:
          throw FetchDataException("Unexpected error: ${response.statusCode}");
      }
    } on SocketException {
      throw InternetException("Please check your internet connection!");
    } on TimeoutException {
      throw RequestTimeOut("API did not respond in time!");
    } catch (e) {
      throw FetchDataException("Error: $e");
    }
  }
}
