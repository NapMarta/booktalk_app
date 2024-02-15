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
import 'package:shared_preferences/shared_preferences.dart';



Future<List<String>> loadPdf(Libro libro) async {

  // ESTRAZIONE TESTO DA IMMAGINE
  final apiUrl = Uri.parse('http://130.61.22.178:9000/text_detection');
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? imageString = preferences.getString('imageOpera');

  if (imageString == null) {
    return [];
  }

  Uint8List bytes = base64Decode(imageString);
  Img.Image image = Img.decodeImage(bytes)!;
  Uint8List imageBytes = Uint8List.fromList(Img.encodePng(image));

  String extractedText = "";
  ChatPDF chatPDF = ChatPDF();
  List<String> list = [];
  String analisi = "", autore = "";

  try{
    var request = http.MultipartRequest('POST', apiUrl)
      ..files.add(http.MultipartFile.fromBytes(
        'image',
        imageBytes,
        filename: 'temp.png',
      ));
    final response = await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      //final Map<String, dynamic> data = json.decode(response.body);
      //print(response.body);
      //extractedText = data['detected_text'];
      extractedText = response.body;
      //print(extractedText);
    } else {
      //print(response.body);
      print('Errore nella richiesta API: ${response.statusCode}');
    }
  } catch (e) {
    print('Errore: $e');
    /*Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => ErrorAlertPageOpera(text: "Errore. L'opera scannerizzata non è contenuta nel libro selezionato"),
    )
  );*/
  //mostraErrore(context, "Errore. L'opera scannerizzata non è contenuta nel libro selezionato");
  //isOperainLibro = false;
    return [];
  }

  // CONVERSIONE in PDF
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
        /*Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ErrorAlertPageOpera(text: "Errore. L'opera scannerizzata non è contenuta nel libro selezionato"),
          )
        );*/
        //mostraErrore(context, "Errore. L'opera scannerizzata non è contenuta nel libro selezionato");
        //isOperainLibro=false;
        return [];
    }
  } catch (e) {
    print('Error: $e');
    /*Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ErrorAlertPageOpera(text: "Errore. L'opera scannerizzata non è contenuta nel libro selezionato"),
      )
    );*/
    //mostraErrore(context, "Errore. L'opera scannerizzata non è contenuta nel libro selezionato");
    //isOperainLibro = false;
    return [];
  }

  //CARICAMENTO PDF
  await chatPDF.uploadPDFOpera();
  //await chatPDF.uploadPDF("Infinito/1.pdf");

  // ANALISI DELL'OPERA
  analisi = await chatPDF.askChatPDF2("Fammi un riassunto");
  
  list.add(analisi);
  //print("ISBN " + widget.libro.isbn);
  print(analisi);

if(((analisi.contains("L'infinito") || analisi.contains("\"L'infinito\"")) && libro.isbn == '9788866565062') || ((analisi.contains("A Zacinto") || analisi.contains("\"A Zacinto\"") || analisi.contains("Alla sera") || analisi.contains("\"Alla sera\"")) && libro.isbn == '9788728429044') ){
  /* List<String> sentences = analisi.split('. ');
  if (analisi.isNotEmpty && analisi[0].startsWith('Mi dispiace')) {
      sentences.removeAt(0);
      sentences.remove(1);
  }
  analisi = sentences.join('. '); */
  /* analisi.replaceAll('Certo', '');
  analisi.replaceAll('Certo, ', '');
  analisi.replaceAll('Certamente, ', '');
  analisi.replaceAll('Certamente', '');
  analisi.replaceAll('Certamente! ', '');
  analisi.replaceAll('PDF', 'opera');
  analisi.replaceAll('PDF.', 'opera');
  analisi.replaceAll('nel PDF.', 'nell\'opera.'); */

  print("L'opera letteraria è nel libro");
  
  //INFO AUTORE
  autore = await chatPDF.askChatPDF2("Dammi informazioni sull'autore");
  print(autore);
  /* sentences = autore.split('. ');

  if (autore.isNotEmpty && autore[0].startsWith('Mi dispiace')) {
      sentences.removeAt(0);
      sentences.remove(1);
  }
  autore = sentences.join('. '); */
  /* autore.replaceAll('Certo', '');
  autore.replaceAll('Certo, ', '');
  autore.replaceAll('Certamente, ', '');
  autore.replaceAll('Certamente', '');
  autore.replaceAll('Certamente! ', '');
  autore.replaceAll('PDF', 'opera');
  autore.replaceAll('PDF.', 'opera');
  autore.replaceAll('nel PDF.', 'nell\'opera.'); */
  list.add(autore);
  //isOperainLibro = true;
  return list;
}

  //isOperainLibro = false;
  print("L'opera letteraria NON è nel libro");
  /*Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => ErrorAlertPageOpera(text: "Errore. L'opera scannerizzata non è contenuta nel libro selezionato"),
    )
  );*/
  //mostraErrore(context, "Errore. L'opera scannerizzata non è contenuta nel libro selezionato");
  //isOperainLibro=false;
  return [];
}




class Opera extends StatefulWidget {
  //final File? selectedImageOpera;
  final Libro libro;
  const Opera({Key? key,  required this.libro}) : super(key: key);

  @override
  _OperaState createState() => _OperaState();
}

class _OperaState extends State<Opera> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: loadPdf(widget.libro), 
      builder: (context, snapshot) {
      //if (isOperainLibro){

        if (snapshot.connectionState == ConnectionState.done) {
          List<String> list = snapshot.data as List<String>;

          if(list.isEmpty){
            Navigator.of(context).pop;
              return MaterialApp(
              title: 'Opera letteraria ed analisi',
              home: ErrorAlertPageIsbn(
                text:
                    'Errore! L\'opera non è presente nel libro selezionato!',
              ),
            );
          }else {
              return OpereLetterarieResponsive(lista: list, libro: widget.libro);
            }
          } else {
            return CaricamentoResponsive(text: "Analisi dell'opera in corso...");
          }
        
      }
    );
  }
}