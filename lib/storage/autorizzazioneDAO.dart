import 'dart:convert';
import 'package:booktalk_app/storage/libro.dart';
import 'package:http/http.dart' as http;
import 'autorizzazione.dart';

class AutorizzazioneDao {
  final String baseUrl; // URL di base per la chiamata API

  AutorizzazioneDao(this.baseUrl);

  Future<Autorizzazione?> getAutorizzazioneById(String isbn, int idUtente) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/selectAutorizzazioneByID'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'id': idUtente,
          'isbn': isbn
        }),
      );
      print('Response from API: ${response.body}');

      Map<String, dynamic> resultData =
            json.decode(response.body) as Map<String, dynamic>;
        List<dynamic> resultList = resultData['result_set'] ?? [];

        if (resultList.isNotEmpty) {
          for (Map<String, dynamic> autorizzazione in resultList) {
            Autorizzazione a = Autorizzazione.fromJson(autorizzazione);
            
            if (a.id == idUtente && a.libro == isbn) {
              return a;
            }
          }
          return null;
        } else {
          print('Nessun risultato disponibile.');
          return null;
        }
    } catch (e) {
      print('Errore durante la chiamata API select by id autorizzazione: $e');
      return null;
    }
  }

  Future<List<Autorizzazione>> getAutorizzazioniByUtente(int utenteId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/selectAutorizzazione'));
      print('Response from API: ${response.body}');

      if (response.statusCode == 200) {
        List<dynamic> resultList = json.decode(response.body) ?? [];

        List<Autorizzazione> autorizzazioniList = [];
        for (Map<String, dynamic> autorizzazioneData in resultList) {
          Autorizzazione autorizzazione = Autorizzazione.fromJson(autorizzazioneData);
          if (autorizzazione.utente == utenteId) {
            autorizzazioniList.add(autorizzazione);
          }
        }
        return autorizzazioniList;
      } else {
        print('Errore nella chiamata API: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Errore durante la chiamata API: $e');
      return [];
    }
  }


  Future<List<Libro>> getTopThree(int utenteId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/selectTop3Libri'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'id': utenteId
        }),
      );

      if (response.statusCode == 200) {
        List<dynamic> resultList = json.decode(response.body) ?? [];

        List<Libro> top3 = [];
        for (Map<String, dynamic> libroData in resultList) {
          Libro libro = Libro.fromJson(libroData);
          top3.add(libro);
        }
        return top3;
      } else {
        print('Errore nella chiamata API: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Errore durante la chiamata API: $e');
      return [];
    }
  }




  Future<Map<String, dynamic>> insertAutorizzazione(Autorizzazione autorizzazione) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/insertAutorizzazione'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'tempo_Utilizzato': autorizzazione.tempoUtilizzato,
          'data_Scadenza': autorizzazione.dataScadenza,
          'utente': autorizzazione.utente,
          'libro': autorizzazione.libro,
          'numClick': autorizzazione.numClick
        }),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Errore nella chiamata API insert: ${response.statusCode}');
        return {'error': 'Errore nella chiamata API'};
      }
    } catch (e) {
      print('Errore durante la chiamata API insert: $e');
      return {'error': 'Errore durante la chiamata API'};
    }
  }

  Future<Map<String, dynamic>> updateAutorizzazione(Autorizzazione autorizzazione) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/updateAutorizzazione'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'id': autorizzazione.id,
          'tempo_Utilizzato': autorizzazione.tempoUtilizzato,
          'data_Scadenza': autorizzazione.dataScadenza,
          'numClick': autorizzazione.numClick
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

  Future<Map<String, dynamic>> updateAutorizzazioneClick(int id, String isbn) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/updateAutorizzazioneClick'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'id': id,
          'isbn': isbn
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
