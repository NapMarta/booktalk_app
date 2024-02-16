import 'dart:async';
import 'dart:typed_data';
import 'package:booktalk_app/caricamentoResponsive.dart';
import 'package:booktalk_app/opereLetterarieResponsive.dart';
import 'package:booktalk_app/storage/libro.dart';
import 'package:booktalk_app/widget/ErrorAlertPageISBN.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:image/image.dart' as Img;
import 'package:http/http.dart' as http;
import 'package:booktalk_app/chat/chatPDF.dart';

Future<List<String>> loadPdf(Libro libro, String imageString) async {
  final apiUrl = Uri.parse('http://130.61.22.178:9000/text_detection');
  //const secondsToDelay = 3;

  //await Future.delayed(Duration(seconds: secondsToDelay));
  
  Uint8List bytes = base64Decode(imageString);
  Img.Image image = Img.decodeImage(bytes)!;
  Uint8List imageBytes = Uint8List.fromList(Img.encodePng(image));

  String extractedText = "";
  ChatPDF chatPDF = ChatPDF();
  List<String> list = [];
  String analisi = "", autore = "";

  try {
    var request = http.MultipartRequest('POST', apiUrl)
      ..files.add(http.MultipartFile.fromBytes(
        'image',
        imageBytes,
        filename: 'temp.png',
      ));
    final response = await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      extractedText = response.body;
    } else {
      print('Errore nella richiesta API: ${response.statusCode}');
    }
  } catch (e) {
    print('Errore: $e');
    return [];
  }

  final apiEndpoint = 'http://130.61.22.178:9000/convertToPDF';
  try {
    final response = await http.post(
      Uri.parse(apiEndpoint),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'poesia': extractedText}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
    } else {
      return [];
    }
  } catch (e) {
    print('Error: $e');
    return [];
  }

  await chatPDF.uploadPDFOpera();

  analisi = await chatPDF.askChatPDF2("Fammi un riassunto");
  list.add(analisi);

  if(((analisi.contains("L'infinito") || analisi.contains("\"L'infinito\"")) && libro.isbn == '9788866565062') || ((analisi.contains("A Zacinto") || analisi.contains("\"A Zacinto\"") || analisi.contains("Alla sera") || analisi.contains("\"Alla sera\"")) && libro.isbn == '9788728429044') ){
    autore = await chatPDF.askChatPDF2("Dammi informazioni sull'autore");
    list.add(autore);
    return list;
  }

  return [];
}

class Opera extends StatefulWidget {
  final String imageString;
  final Libro libro;
  const Opera({Key? key,  required this.libro, required this.imageString}) : super(key: key);

  @override
  _OperaState createState() => _OperaState();
}

class _OperaState extends State<Opera> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: loadPdf(widget.libro, widget.imageString), 
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return CaricamentoResponsive(text: "Analisi dell'opera in corso...");
        } else if (snapshot.connectionState == ConnectionState.done) {
          List<String> list = snapshot.data as List<String>;

          if(list.isEmpty){
            Navigator.of(context).pop;
            return MaterialApp(
              title: 'Opera letteraria ed analisi',
              home: ErrorAlertPageIsbn(
                text: 'Errore! L\'opera non è presente nel libro selezionato!',
              ),
            );
          } else {
            return OpereLetterarieResponsive(lista: list, libro: widget.libro);
          }
        } else {
          Navigator.of(context).pop;
          return MaterialApp(
            title: 'Opera letteraria ed analisi',
            home: ErrorAlertPageIsbn(
              text: 'Errore! L\'opera non è presente nel libro selezionato!',
            ),
          );
        }
      }
    );
  }
}
