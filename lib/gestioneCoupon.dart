import 'dart:convert';
import 'package:booktalk_app/business_logic/gestioneAutorizzazioni.dart';
import 'package:booktalk_app/business_logic/gestioneAutorizzazioniService.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async' show Future;

import 'package:shared_preferences/shared_preferences.dart';

void mostraErrore(BuildContext context, String messaggio) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.red, // Colore dell'icona
          ),
          SizedBox(width: 8), // Spazio tra l'icona e il testo
          Expanded(
            child: Text(
              messaggio,
              style: TextStyle(
                color: Colors.red, // Colore del testo
                fontWeight: FontWeight.bold, // Grassetto
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white, // Colore di sfondo
      duration: Duration(seconds: 3), // Durata del messaggio
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


  void modificaOK(BuildContext context, String messaggio) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(
            Icons.verified,
            color: Colors.green, // Colore dell'icona
          ),
          SizedBox(width: 8), // Spazio tra l'icona e il testo
          Expanded(
            child: Text(
              messaggio,
              style: TextStyle(
                color: Colors.green, // Colore del testo
                fontWeight: FontWeight.bold, // Grassetto
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white, // Colore di sfondo
      duration: Duration(seconds: 3), // Durata del messaggio
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

Future<void> verificaCoupon(String isbn, String coupon, BuildContext context) async {
  WidgetsFlutterBinding.ensureInitialized();
  int idUtente = 0;

  //Prendere i parametri isbn e coupon da quelli che ha inserito l'utente
  //String isbn = '8806134965';
  //String coupon = 'A45DF3';

  final url = 'http://130.61.22.178:9000/verificaCoupon';

  final response = await http.post(Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'isbn': isbn, 'coupon': coupon}));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    if (data['result']) {
      print('Il libro è supportato e il codice coupon è valido.');

      SharedPreferences _preferences = await SharedPreferences.getInstance();
      String utenteJson = _preferences.getString('utente') ?? '';
      if (utenteJson.isNotEmpty) {
        Map<String, dynamic> utenteMap = json.decode(utenteJson);
        idUtente = utenteMap['ID'];
        GestioneAutorizzazioniService service = GestioneAutorizzazioni();
        service.addAutorizzazione(isbn, idUtente);
      }
      else{
        print("ERRORE: utente non trovato");
        mostraErrore(context, 'ERRORE: utente non trovato');
      }
      
      modificaOK(context, 'Il libro è supportato e il codice coupon è valido.');

    } else {
      print('Libro attualmente non supportato o codice coupon non valido.');
      mostraErrore(context, 'Libro attualmente non supportato o codice coupon non valido.');
    }
  } else {
    //throw Exception('Errore durante la richiesta HTTP');
    mostraErrore(context, 'ERRORE: impossibile inoltrare la richiesta');
  }
}
