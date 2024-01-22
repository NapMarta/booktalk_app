import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';


Future<Uint8List> loadImage() async {
  final ByteData data = await rootBundle.load('assets/libro3.jpg');
  return data.buffer.asUint8List();
}

String? extractISBN(String input) {
  final RegExp regex = RegExp(r'(\bISBN\b\s*)?(\d{3})\s*[-]?\s*(\d{1,5})\s*[-]?\s*(\d{1,7})\s*[-]?\s*(\d{1,7})\s*[-]?\s*(\d{1,7})\s*[-]?\s*(\d{1,7})\s*[-]?\s*(\d{1,7})\b');

  final Iterable<Match> matches = regex.allMatches(input);
  if (matches.isNotEmpty) {
    final Match match = matches.first;
    String? isbn = match.group(0);

    // Trova la posizione dell'ultimo trattino nella stringa
    int lastHyphenIndex = isbn?.lastIndexOf('-') ?? -1;

    // Taglia la stringa solo prima dell'ultimo trattino
    if (lastHyphenIndex != -1) {
      isbn = isbn?.substring(0, lastHyphenIndex+2);
    }

    return isbn;
  } else {
    return 'ISBN non trovato';
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    final apiUrl = Uri.parse('http://130.61.22.178:9000/extract_text');
    final imageBytes = await loadImage();

    // Crea una richiesta multipart per inviare l'immagine
    var request = http.MultipartRequest('POST', apiUrl)
      ..files.add(http.MultipartFile.fromBytes(
        'image',
        imageBytes,
        filename: 'image.png',
      ));

    // Invia la richiesta
    var response = await http.Response.fromStream(await request.send());


    // Gestisci la risposta
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      print('Testo estratto: ${data['text']}');
      String extractedText = data['text'];
      String? isbnCode = extractISBN(extractedText);

      print(isbnCode);
    } else {
      print('Errore nella richiesta API: ${response.statusCode}');
    }
  } catch (e) {
    print('Errore: $e');
  }

}
