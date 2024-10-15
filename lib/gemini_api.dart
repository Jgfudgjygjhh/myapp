import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<String>> generateQuestions(String text, String apiKey) async {
  final url = Uri.parse('https://api.gemini.google.com/v1/generateQuestions');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $apiKey',
  };
  final body = jsonEncode({'text': text});

  try {
    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final questions = jsonResponse['questions'] as List<dynamic>;
      return questions.map((e) => e.toString()).toList();
    } else {
      print('Request failed with status: ${response.statusCode}.');
      print('Response body: ${response.body}');
      return [];
    }
  } catch (e) {
    print('Error: $e');
    return [];
  }
}
