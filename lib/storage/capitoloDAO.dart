import 'dart:convert';
import 'package:http/http.dart' as http;
import 'capitolo.dart';

class CapitoloDao {
  final String baseUrl; // Base URL for API calls

  CapitoloDao(this.baseUrl);

  Future<Capitolo?> getCapitoloByNumeroLibro(int numero, String libro) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/selectCapitolo'));

      if (response.statusCode == 200) {
        List<dynamic> resultList = json.decode(response.body) ?? [];

        if (resultList.isNotEmpty) {
            Capitolo capitolo = Capitolo.fromJson(resultList[0]);
            if (capitolo.numero == numero && capitolo.libro == libro) return capitolo;
          
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

  Future<Map<String, dynamic>> insertCapitolo(Capitolo capitolo) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/insertCapitolo'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(capitolo.toJson()),
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

  Future<Map<String, dynamic>> updateCapitolo(Capitolo capitolo) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/updateCapitolo'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'numero': capitolo.numero,
          'libro': capitolo.libro,
          'titolo': capitolo.titolo,
        }),
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
