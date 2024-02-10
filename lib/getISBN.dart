import 'dart:io';

import 'package:booktalk_app/aggiuntaLibroResponsive.dart';
import 'package:booktalk_app/caricamentoResponsive.dart';
import 'package:booktalk_app/widget/ErrorAlertPage.dart';
import 'package:booktalk_app/widget/ErrorAlertPageOpera.dart';
import 'package:flutter/material.dart';

import 'package:image/image.dart' as Img;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';



String? extractISBN(String input) {
  final RegExp regex = RegExp(
    r'((\bISBN\b\s*)?(\d{3})\s*[-]?\s*(\d{1,5})\s*[-]?\s*(\d{1,7})\s*[-]?\s*(\d{1,7})\s*[-]?\s*(\d{1,7})\s*[-]?\s*(\d{1,7})\s*[-]?\s*(\d{1,7})\b)|^\d{10}|\d{13}$');


  final Iterable<Match> matches = regex.allMatches(input);
  if (matches.isNotEmpty) {
    final Match match = matches.first;
    String? isbn = match.group(0);

    // Trova la posizione dell'ultimo trattino nella stringa
    int lastHyphenIndex = isbn?.lastIndexOf('-') ?? -1;

    // Taglia la stringa solo prima dell'ultimo trattino
    if (lastHyphenIndex != -1) {
      isbn = isbn?.substring(0, lastHyphenIndex + 2);
    }
    print(isbn);
    return isbn;
  } else {
    return 'ISBN non trovato';
  }
}

Future<String?> loadISBN(File? foto) async {
  // ESTRAZIONE TESTO DA IMMAGINE
  final apiUrl = Uri.parse('http://130.61.22.178:9000/text_detection');
  Img.Image image =
      Img.decodeImage(await foto!.readAsBytes())!;
  Uint8List imageBytes = Uint8List.fromList(Img.encodePng(image)!);
  String extractedText = "";

  try {
    var request = http.MultipartRequest('POST', apiUrl)
      ..files.add(http.MultipartFile.fromBytes(
        'image',
        imageBytes,
        filename: 'temp.png',
      ));
    final response = await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      //extractedText = data['detected_text'];
      extractedText = response.body;
      print("TESTO RILEVATO: $extractedText");
      //print(extractedText);

      return extractISBN(extractedText);
    } else {
      print(response.body);
      print('Errore nella richiesta API: ${response.statusCode}');
    }
  } catch (e) {
    print('Errore: $e');
  }
  return null;
}

    
class GetIsbn extends StatefulWidget {
  final File? foto;
  const GetIsbn({Key? key, required this.foto}) : super(key: key);

  @override
  _GetIsbnState createState() => _GetIsbnState();
}

class _GetIsbnState extends State<GetIsbn> {

  late Future<String?> _isbnFuture;

  @override
  void initState() {
    super.initState();
    //_isbnFuture = widget.foto != null ? loadISBN(widget.foto!) : Future.value(null);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: loadISBN(widget.foto!), 
      builder: (context, isbn) {
        if(isbn.hasError){
          return ErrorAlertPageOpera(text: "Errore. Ti invitiamo a riprovare");
        }else if (isbn.connectionState == ConnectionState.done){
          if (isbn.data == null)
            return ErrorAlertPageOpera(text: "Errore. ISBN non inserito");
          else{
            if(isbn.data == "8806134965" || isbn.data == "8886113277" || isbn.data == "9788866565062" || isbn.data == "9781070658773" || isbn.data == "8879835629" || isbn.data == "8811584043")
              return AggiuntaLibroResponsive(isbn: isbn.data as String);
            else
              return ErrorAlertPageOpera(text: "L'ISBN inserito non è valido.");

            /*
            LibroDao dao = LibroDao('http://130.61.22.178:9000');
            Future<bool> isIsbnInDB = dao.searchISBN(isbn.data!);            
            return FutureBuilder<bool>(
              future: isIsbnInDB,
              builder: (context, dbSnapshot) {
                if(dbSnapshot.hasError) {
                  return Text("Errore. Ti invitiamo a riprovare");
                } else if (dbSnapshot.connectionState == ConnectionState.done) {
                  if (dbSnapshot.data == true)
                    return AggiuntaLibroResponsive(isbn: isbn.data as String);
                  else
                    return Text("Errore. L'ISBN non è nel DB");
                } else {
                  return CaricamentoResponsive(text: "Ricerca dell'ISBN in corso...");
                }
              },
            );
            */
          }

        }else {
          return CaricamentoResponsive(text: "Ricerca dell'ISBN in corso...");
        }
      },
    );
  }
}