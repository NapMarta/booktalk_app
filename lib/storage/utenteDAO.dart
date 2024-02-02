import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'utente.dart';

class UtenteDao {
  final String baseUrl; // URL di base per la chiamata API

  UtenteDao(this.baseUrl);

  String hashPassword(String password) {
    var bytes = utf8.encode(password); // encode the password
    var hashed = sha256.convert(bytes); // hash the password
    return hashed.toString();
  }

  Future<Utente?> getUtenteById(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/selectUtente'));

      if (response.statusCode == 200) {
        Map<String, dynamic> resultData =
            json.decode(response.body) as Map<String, dynamic>;
        List<dynamic> resultList = resultData['result_set'] ?? [];

        if (resultList.isNotEmpty) {
          for (Map<String, dynamic> utente in resultList) {
            Utente u = Utente.fromJson(utente);
            if (u.id == id) return u;
          }
          return null;
        } else {
          print('Nessun risultato disponibile.');
          return null;
        }
      } else {
        print('Errore nella chiamata API: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Errore durante la chiamata API: $e');
      return null;
    }
  }

  Future<Utente?> getUtenteByEmailPassword(String email, String password) async {
  try {
    final response = await http.get(Uri.parse('$baseUrl/selectUtente'));

    if (response.statusCode == 200) {
      Map<String, dynamic> resultData =
          json.decode(response.body) as Map<String, dynamic>;
      List<dynamic> resultList = resultData['result_set'] ?? [];

      if (resultList.isNotEmpty) {
        for (Map<String, dynamic> utente in resultList) {
          Utente u = Utente.fromJson(utente);

          // Hash the provided password
          String hashedPassword = hashPassword(password);

          // Compare hashed password with stored hashed password
          if (u.password == hashedPassword && u.email == email) {
            return u;
          }
        }
        return null;
      } else {
        print('Nessun risultato disponibile.');
        return null;
      }
    } else {
      print('Errore nella chiamata API: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Errore durante la chiamata API: $e');
    return null;
  }
}

  Future<List<Utente>> getAllUtenti() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/selectUtente'));

      if (response.statusCode == 200) {
        Map<String, dynamic> resultData =
            json.decode(response.body) as Map<String, dynamic>;
        List<dynamic> resultList = resultData['result_set'] ?? [];

        List<Utente> utentiList =
            resultList.map((userData) => Utente.fromJson(userData)).toList();
        return utentiList;
      } else {
        print('Errore nella chiamata API: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Errore durante la chiamata API: $e');
      return [];
    }
  }

  Future<Map<String, dynamic>> insertUtente(Utente utente) async {
  try {
    // Fetch all users to determine the maximum ID
    final usersResponse = await http.get(Uri.parse('$baseUrl/selectUtente'));

    if (usersResponse.statusCode == 200) {
      // Hash the password before sending it
      String hashedPassword = hashPassword(utente.password);

      // Insert the new user with the calculated ID
      final response = await http.post(
        Uri.parse('$baseUrl/insertUtente'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'nome': utente.nome,
          'cognome': utente.cognome,
          'email': utente.email,
          'password': hashedPassword,
          'foto': utente.foto,
          'ultfunz1': utente.ultfunz1,
          'ultfunz2': utente.ultfunz2,
          'ultfunz3': utente.ultfunz3,
        }),
      );

      if (response.statusCode == 200) {
        print("ok");
        return json.decode(response.body);
      } else {
        print('Errore nella chiamata API: ${response.statusCode}');
        return {'error': 'Errore nella chiamata API'};
      }
    } else {
      print('Errore nella chiamata API: ${usersResponse.statusCode}');
      return {'error': 'Errore nella chiamata API'};
    }
  } catch (e) {
    print('Errore durante la chiamata API: $e');
    return {'error': 'Errore durante la chiamata API'};
  }
}

  Future<Map<String, dynamic>> updateUtente(Utente utente) async {
  try {
    // Hash the new password before sending it
    String hashedPassword = hashPassword(utente.password);

    final response = await http.put(
      Uri.parse('$baseUrl/updateUtente'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'nome': utente.nome,
        'cognome': utente.cognome,
        'email': utente.email,
        'password': hashedPassword,
        'foto': utente.foto,
        'ultfunz1': utente.ultfunz1,
        'ultfunz2': utente.ultfunz2,
        'ultfunz3': utente.ultfunz3,
        'id': utente.id
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print('Errore nella chiamata API: ${response.statusCode}');
      print('Dettagli errore: ${response.body}');
      return {'error': 'Errore nella chiamata API'};
    }
  } catch (e) {
    print('Errore durante la chiamata API: $e');
    return {'error': 'Errore durante la chiamata API'};
  }
}

}