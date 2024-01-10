import 'dart:convert';
import 'package:http/http.dart' as http;
import 'opera_letteraria.dart';

class OperaLetterariaDao {
  final String baseUrl; // Base URL for API calls

  OperaLetterariaDao(this.baseUrl);

  Future<OperaLetteraria?> getOperaByTitoloCapitoloLibro(String titolo, int capitolo, String libro) async {
      try {
        final response = await http.get(Uri.parse('$baseUrl/selectOperaLetteraria'));

        if (response.statusCode == 200) {
          List<dynamic> resultList = json.decode(response.body) ?? [];

          if (resultList.isNotEmpty) {
            for (Map<String, dynamic> operaData in resultList) {
              OperaLetteraria opera = OperaLetteraria.fromJson(operaData);
              if (opera.titolo == titolo && opera.capitolo == capitolo && opera.libro == libro) {
                return opera;
              }
            }
            return null;
          } else {
            print('No results available.');
            return null;
          }
        } else {
          print('Error in API call: ${response.statusCode}');
          return null;
        }
      } catch (e) {
        print('Error during API call: $e');
        return null;
      }
    }



  Future<Map<String, dynamic>> insertOperaLetteraria(OperaLetteraria opera) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/insertOperaLetteraria'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(opera.toJson()),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Error in API call: ${response.statusCode}');
        return {'error': 'Error in API call'};
      }
    } catch (e) {
      print('Error during API call: $e');
      return {'error': 'Error during API call'};
    }
  }

  Future<Map<String, dynamic>> updateOperaLetteraria(OperaLetteraria opera) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/updateOperaLetteraria'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(opera.toJson()),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Error in API call: ${response.statusCode}');
        return {'error': 'Error in API call'};
      }
    } catch (e) {
      print('Error during API call: $e');
      return {'error': 'Error during API call'};
    }
  }
}