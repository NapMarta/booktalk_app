import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatPDF {
  String sourceId = '';
  
  ChatPDF(){
    uploadPDF();
  }

  Future<void> uploadPDF() async {
    
    final apiEndpoint = 'http://130.61.22.178:9000/uploadPDF/./Aforismi-novelle-e-profezie.pdf';
    final response = await http.post(      
      Uri.parse(apiEndpoint),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      sourceId = data['source_id'];
    } else {
      throw Exception('Failed to upload PDF');
    }
  }

  Future<String> askChatPDF(String userQuestion, List<int> pages) async {
    final apiEndpoint = 'http://130.61.22.178:9000/askChatPDFwithPages';
    final response = await http.post(
      Uri.parse(apiEndpoint),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'source_id': sourceId, 'user_question': userQuestion, 'pages': pages}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['chatpdf_response'];
    } else {
      return 'Caricamento fallito';
    }
  }
}

  