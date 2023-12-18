import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenAIGPTService {
  final String apiKey;
  final String endpoint;

  OpenAIGPTService(this.apiKey, this.endpoint);

  Future<String> generateResponse(String prompt) async {
    final response = await http.post(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'messages': [
          {'role': 'user', 'content': prompt}
        ],
        "model": "gpt-3.5-turbo",
      }),
    );
    if (response.statusCode == 200) {
      final responseBody = json.decode(utf8.decode(response.bodyBytes));

      final choices = responseBody['choices'] as List<dynamic>;

      if (choices.isNotEmpty) {
        final messageObj = choices[0]['message'] as Map<String, dynamic>;

        if (messageObj['content'] != null) {
          final generatedMessage = messageObj['content'].toString();
          return generatedMessage;
        }
      }
    }

    throw Exception(
        'Failed to generate response: ${response.statusCode} \n${response.body}');
  }
}
