import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatPDF {
  String sourceId = '';
  
  ChatPDF(){}

  Future<bool> uploadPDF(String path) async {
    
    final apiEndpoint = 'http://130.61.22.178:9000/uploadPDF/./libri/$path';
    final response = await http.post(      
      Uri.parse(apiEndpoint),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      sourceId = data['source_id'];
      return true;
    } else {
      //throw Exception('Failed to upload PDF');
      return false;
    }
  }

  Future<bool> uploadPDFOpera() async {
    
    final apiEndpoint = 'http://130.61.22.178:9000/uploadPDF/./output.pdf';
    final response = await http.post(      
      Uri.parse(apiEndpoint),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      sourceId = data['source_id'];
      return true;
    } else {
      //throw Exception('Failed to upload PDF');
      return false;
    }
  }

  Future<String> askChatPDF(String userQuestion) async {
    final apiEndpoint = 'http://130.61.22.178:9000/askChatPDFwithPages';
    final response = await http.post(
      Uri.parse(apiEndpoint),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'source_id': sourceId, 'user_question': userQuestion}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['chatpdf_response'];
    } else {
      return 'Caricamento fallito';
    }
  }

  Future<String> askChatPDF2(String userQuestion) async {
    final apiEndpoint = 'http://130.61.22.178:9000/askChatPDF';
    final response = await http.post(
      Uri.parse(apiEndpoint),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'source_id': sourceId, 'user_question': userQuestion}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);      
      //return data;
      return data['chatpdf_response'];
    } else {
      return 'Caricamento fallito';
    }
  }
}

  