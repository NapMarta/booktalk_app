import 'dart:convert';
import 'dart:io';
import 'package:booktalk_app/espressioniResponsive.dart';
import 'package:booktalk_app/widget/header.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async' show Future, runZonedGuarded;
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
      final data = jsonDecode(response.body);
      print(data);
      String testo = data['step'];

      print(testo);
      int indiceInizio = 0;

      if (testo.isEmpty) {
        return step;
      } else {
        testo = testo.replaceAll('|', '');
        print(testo);
        for (int i = 0; testo != "|"; i++) {
          if (testo[i] == '\n') {
            step.add(testo.substring(indiceInizio, i));
            indiceInizio = i + 1; // Ignora il carattere '\n' stesso
          }
        }
        // Aggiungi l'ultima riga
        step.add(testo.substring(indiceInizio + 2));
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
    var mediaQueryData = MediaQuery.of(context);

    return FutureBuilder(
        // initialize flutterfire:
        future: risolviEspressione(widget.exp),
        builder: (context, yourlistofstringresult) {
          // check for errors
          if (yourlistofstringresult.hasError) {
            return Text("Errore. Ti invitiamo a riprovare");
            //AGGIUNGERE BOX CON MESSAGGIO DI ERRORE
          } else if (yourlistofstringresult.connectionState ==
              ConnectionState.done) {
            List<String> data = yourlistofstringresult.data as List<String>;

            if (data.isEmpty) {
              return MaterialApp(
                title: 'Errore Equazione Matematica',
                home: ErrorAlertPage(),
              );
            } else {
              return EspressioniResponsive(step: data);
            }
          } else {
            return SafeArea(
              left: true,
              right: true,
              bottom: false,
              top: true,
              child: Scaffold(
                // ----- HEADER -----
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(kToolbarHeight),
                  child: Header(
                    iconProfile: Image.asset('assets/person-icon.png'),
                    text: "",
                    isHomePage: false,
                    isProfilo: false,
                  ),
                ),
                backgroundColor: Colors.white,
                body: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: mediaQueryData.size.height * 0.15,
                      ),
                      Text(
                        "Calcolo dell'espressione inserita in corso",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: mediaQueryData.size.height * 0.15,
                      ),
                      CircularProgressIndicator(
                        color: Color(0xFF0097b2),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        });
  }
}

//-----------------ERRORE-----------------

class ErrorAlertPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AlertDialog(
          title: Text('Errore'),
          content: Text(
              'Equazione non valida o soluzione non appartenente all\'insieme dei numeri reali. Riprovare!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Torna alla pagina precedente
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}

/* class CustomErrorWidget extends StatelessWidget {
  final String errorMessage =
      "La soluzione non appartiene all'insieme dei numeri reali!";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 50.0,
          ),
          SizedBox(height: 10.0),
          Text(
            'Errore!',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.0),
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // Mostra lo Snackbar con il messaggio di errore
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  "La soluzione non appartiene all'insieme dei numeri reali!"),
              duration: Duration(seconds: 3), // Durata del messaggio
              action: SnackBarAction(
                label: 'OK',
                onPressed: () {
                  ScaffoldMessenger.of(context)
                      .hideCurrentSnackBar(); // Nasconde lo Snackbar
                },
              ),
            ),
          );
        },
        child: Text('Mostra messaggio di errore'),
      ),
    );
  }
}
 */