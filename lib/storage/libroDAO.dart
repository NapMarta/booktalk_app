import 'dart:convert';
import 'package:http/http.dart' as http;
import 'libro.dart';

class LibroDao {
  final String baseUrl; // URL di base per la chiamata API

  LibroDao(this.baseUrl);

  Future<List<Libro>> getAllLibri() async {
  try {
    final response = await http.get(Uri.parse('$baseUrl/selectLibro'));

    if (response.statusCode == 200) {
      List<dynamic> resultList = json.decode(response.body) ?? [];

      List<Libro> libriList =
          resultList.map((libroData) => Libro.fromJson(libroData)).toList();
      return libriList;
    } else {
      print('Errore nella chiamata API select: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    print('Errore durante la chiamata API select: $e');
    return [];
  }
}


  Future<Map<String, dynamic>> insertLibro(Libro libro) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/insertLibro'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'isbn': libro.isbn,
          'titolo': libro.titolo,
          'autori': libro.autori,
          'materia': libro.materia,
          'edizione': libro.edizione,
          'num_Pagine': libro.numPagine,
        }),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Errore nella chiamata API: ${response.statusCode}');
        return {'error': 'Errore nella chiamata API'};
      }
    } catch (e) {
      print('Errore durante la chiamata API: $e');
      return {'error': 'Errore durante la chiamata API'};
    }
  }

  Future<Map<String, dynamic>> updateLibro(Libro libro) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/updateLibro'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'isbn': libro.isbn,
          'titolo': libro.titolo,
          'autori': libro.autori,
          'materia': libro.materia,
          'edizione': libro.edizione,
          'num_Pagine': libro.numPagine,
        }),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Errore nella chiamata API: ${response.statusCode}');
        return {'error': 'Errore nella chiamata API'};
      }
    } catch (e) {
      print('Errore durante la chiamata API: $e');
      return {'error': 'Errore durante la chiamata API'};
    }
  }
}
