import 'dart:convert';
import 'dart:io';
import 'package:booktalk_app/espressioniResponsive.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';

Future<List<String>> risolviEspressione(String value) async {
  WidgetsFlutterBinding.ensureInitialized();

  List<String> step = [];
  String sourceId = '';

  try {
    final apiUrl =
        Uri.parse('http://130.61.22.178:9000/wolframalpha/show_step');

    final response = await http.post(apiUrl,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'query': value}));

    //var request = http.MultipartRequest('POST', apiUrl)
    //  ..fields['query'] = value;
    /*
  var body = {'query': value};

  // Invio della richiesta POST al server con l'attributo aggiunto
  http.post(apiUrl, body: body).then((response) {
    // Gestione della risposta dal server
    if (response.statusCode == 200) {
      print('Richiesta inviata con successo');
      print('Risposta: ${response.body}');

      print("aaa");
      final Map<String, dynamic> data = json.decode(response.body);
       v

      print(testo);

      if (data['text'] ==
          "La soluzione non appartiene all'insieme dei numeri reali!") {
        extractedText = data['text'];
      } else {
        for (int i = 0; i < testo.length; i++) {
          if (testo[i] == '\n') {
            step.add(testo.substring(indiceInizio, i));
            indiceInizio = i + 1; // Ignora il carattere '\n' stesso
          }
        }
        // Aggiungi l'ultima riga
        step.add(testo.substring(indiceInizio));
        // Stampa le righe
        print(step);
      }
    } else {
      print('Errore durante l\'invio della richiesta.');
      print('Codice di stato: ${response.statusCode}');
    }
  }).catchError((error) {
    print('Errore durante l\'invio della richiesta: $error');
  });

    // Crea una richiesta multipart per inviare l'immagine
    //var request = http.MultipartRequest('GET', apiUrl);

    //Aggiunta dell'espressione come parametro
    //request.fields['query'] = value;
    */

    print(response.headers);

    // Gestisci la risposta
    if (response.statusCode == 200) {
      print("aaa");
      final data = jsonDecode(response.body);
      print(data);
      String testo = data['step'];
      String vuoto;

      print(testo);
      int indiceInizio = 0;
      //String testo = data['text'];

      if (testo.isEmpty) {
        vuoto = "La soluzione non appartiene all'insieme dei numeri reali!";
      } else {
        testo = testo.replaceAll('|', '');
        print(testo);
        for (int i = 0; i < testo.length; i++) {
          if (testo[i] == '\n') {
            step.add(testo.substring(indiceInizio, i));
            indiceInizio = i + 1; // Ignora il carattere '\n' stesso
          }
        }
        // Aggiungi l'ultima riga
        step.add(testo.substring(indiceInizio));
        // Stampa le righe
        print(step);
      }
    } else {
      print('Errore nella richiesta API: ${response.statusCode}');
    }
  } catch (e) {
    print('Errore: $e');
  }

  return step;
}

class GetExpression extends StatefulWidget {
  final String exp;

  const GetExpression({Key? key, required this.exp}) : super(key: key);

  @override
  _GetExpression createState() => _GetExpression();
}

class _GetExpression extends State<GetExpression> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        // initialize flutterfire:
        future: risolviEspressione(widget.exp),
        builder: (context, yourlistofstringresult) {
          // check for errors
          if (yourlistofstringresult.hasError) {
            return Text("something is wrong!");
          } else if (yourlistofstringresult.connectionState ==
              ConnectionState.done) {
            List<String> data = yourlistofstringresult.data as List<String>; //
            return EspressioniResponsive(step: data);
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
