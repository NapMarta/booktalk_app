import 'dart:convert';
import 'package:http/http.dart' as http;
import 'libreria.dart';

class LibreriaDao {
  final String baseUrl;

  LibreriaDao(this.baseUrl);

  Future<void> insertLibreria(Libreria libreria) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/insertLibreria'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'utente': libreria.utente,
          'numLibri': libreria.numLibri,
          'materia1': libreria.materia1,
          'materia2': libreria.materia2,
          'materia3': libreria.materia3,
        }),
      );

      if (response.statusCode == 200) {
        print('Libreria inserita con successo');
      } else {
        print('Errore nella chiamata API: ${response.statusCode}');
      }
    } catch (e) {
      print('Errore durante la chiamata API: $e');
    }
  }

  Future<List<Libreria>> getLibreriaByUtente(int utenteId) async {
  try {
    final response = await http.get(Uri.parse('$baseUrl/selectLibreria'));

    if (response.statusCode == 200) {
      List<dynamic> resultList = json.decode(response.body) as List<dynamic>;

      List<Libreria> libreriaList = [];
      for (Map<String, dynamic> libreriaData in resultList) {
        Libreria libreria = Libreria.fromJson(libreriaData);
        if (libreria.utente == utenteId) {
          libreriaList.add(libreria);
        }
      }
      return libreriaList;
    } else {
      print('Errore nella chiamata API: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    print('Errore durante la chiamata API: $e');
    return [];
  }
}

  Future<void> updateLibreria(Libreria libreria) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/updateLibreria'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'utente': libreria.utente,
          'numLibri': libreria.numLibri,
          'materia1': libreria.materia1,
          'materia2': libreria.materia2,
          'materia3': libreria.materia3,
        }),
      );

      if (response.statusCode == 200) {
        print('Libreria aggiornata con successo');
      } else {
        print('Errore nella chiamata API: ${response.statusCode}');
      }
    } catch (e) {
      print('Errore durante la chiamata API: $e');
    }
  }
}
