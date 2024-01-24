import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';

Future<Uint8List> loadImage() async {
  final ByteData data = await rootBundle.load('assets/libro3.jpg');
  return data.buffer.asUint8List();
}

void expRecognition(File? file) async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    final apiUrl =
        Uri.parse('http://130.61.22.178:9000/expression_recognition');
    final Uint8List? imageBytes = await file?.readAsBytes();

    // Crea una richiesta multipart per inviare l'immagine
    var request = http.MultipartRequest('POST', apiUrl)
      ..files.add(http.MultipartFile.fromBytes(
        'image',
        imageBytes!,
        filename: 'image.png',
      ));

    // Invia la richiesta
    var response = await http.Response.fromStream(await request.send());

    // Gestisci la risposta
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      print('Testo estratto: ${data['text']}');
      String extractedText = data['text'];
      print(extractedText);
    } else {
      print('Errore nella richiesta API: ${response.statusCode}');
    }
  } catch (e) {
    print('Errore: $e');
  }
}
