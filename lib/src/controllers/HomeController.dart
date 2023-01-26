import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rx_notifier/rx_notifier.dart';

class HomeController {
  final conversation = RxList([]);
  var apiUrl = Uri.https("api.openai.com", "/v1/completions");
  static const chatGptSecretKey = 'XXXXXX';

  Future<void> sendQuestion(String question) async {
    try {
      final response = await http.post(
        apiUrl,
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer $chatGptSecretKey"
        },
        body: json.encode({
          "model": "text-davinci-003",
          "prompt": question,
          'temperature': 0,
          'max_tokens': 2000,
          'top_p': 1,
          'frequency_penalty': 0.0,
          'presence_penalty': 0.0,
        }),
      );

      Map answer = json.decode(utf8.decode(response.bodyBytes));

      conversation.add({
        'question': question,
        'answer': answer['choices'][0]['text']
      });
    } catch (error) {
      // print(error); Todo: colocar aqui uma snack bar
    }
  }
}