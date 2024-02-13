import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:booktalk_app/business_logic/monitoraggioStatistiche.dart';
import 'package:booktalk_app/chat/chatPDF.dart';
import 'package:booktalk_app/storage/libro.dart';
import 'package:booktalk_app/utils.dart';
//import 'package:booktalk_app/widget/ErrorAlertPageOpera.dart';
import 'package:booktalk_app/widget/header.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as Img;
import 'package:http/http.dart' as http;


    
class OpereLetterarieResponsive extends StatefulWidget {
  final File selectedImageOpera;
  final Libro libro;

  const OpereLetterarieResponsive({
    Key? key,
    required this.selectedImageOpera,
    required this.libro,
  }) : super(key: key);

  @override
  _OpereLetterarieResponsiveState createState() => _OpereLetterarieResponsiveState();
}


class _OpereLetterarieResponsiveState extends State<OpereLetterarieResponsive> {

  String analisi = "", autore = "";
  MonitoraggioStatistiche monitoraggioStatistiche = MonitoraggioStatistiche.instance;
  late Uint8List imageBytes;
  bool isOperainLibro = false;

  @override
  void initState() {
    super.initState();
    monitoraggioStatistiche.incrementaFunz2();
    monitoraggioStatistiche.aggiungiClickLibro(widget.libro.isbn);
    imageBytes = Uint8List.fromList(widget.libro.copertina!);
    //loadPdf();
  }

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


  Future<bool> loadPdf() async {

    // ESTRAZIONE TESTO DA IMMAGINE
    final apiUrl = Uri.parse('http://130.61.22.178:9000/text_detection');
    Img.Image image = Img.decodeImage(await widget.selectedImageOpera.readAsBytes())!;
    Uint8List imageBytes = Uint8List.fromList(Img.encodePng(image));
    String extractedText = "";
    ChatPDF chatPDF = ChatPDF();

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
    mostraErrore(context, "Errore. L'opera scannerizzata non è contenuta nel libro selezionato");
    isOperainLibro = false;
    return false;
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
          mostraErrore(context, "Errore. L'opera scannerizzata non è contenuta nel libro selezionato");
          isOperainLibro=false;
          return false;
      }
    } catch (e) {
      print('Error: $e');
      /*Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ErrorAlertPageOpera(text: "Errore. L'opera scannerizzata non è contenuta nel libro selezionato"),
        )
      );*/
      mostraErrore(context, "Errore. L'opera scannerizzata non è contenuta nel libro selezionato");
      isOperainLibro = false;
      return false;
    }

    //CARICAMENTO PDF
    await chatPDF.uploadPDFOpera();
    //await chatPDF.uploadPDF("Infinito/1.pdf");

    // ANALISI DELL'OPERA
    analisi = await chatPDF.askChatPDF2("Fammi un riassunto");
    print(analisi);
  
  if(((analisi.contains("L'infinito") || analisi.contains("\"L'infinito\"")) && widget.libro.isbn == '9788866565062') || ((analisi.contains("A Zacinto") || analisi.contains("\"A Zacinto\"") || analisi.contains("Alla sera") || analisi.contains("\"Alla sera\"")) && widget.libro.isbn == '9788728429044') ){
    List<String> sentences = analisi.split('. ');
    if (analisi.isNotEmpty && analisi[0].startsWith('Mi dispiace')) {
        sentences.removeAt(0);
        sentences.remove(1);
    }
    analisi = sentences.join('. ');
    analisi.replaceAll('Certo', '');
    analisi.replaceAll('Certo, ', '');
    analisi.replaceAll('Certamente, ', '');
    analisi.replaceAll('Certamente', '');
    analisi.replaceAll('Certamente! ', '');
    analisi.replaceAll('PDF', 'opera');
    analisi.replaceAll('PDF.', 'opera');
    analisi.replaceAll('nel PDF.', 'nell\'opera.');

    print("L'opera letteraria è nel libro");
    
    //INFO AUTORE
    autore = await chatPDF.askChatPDF2("Dammi informazioni sull'autore");
    print(autore);
    sentences = autore.split('. ');

    if (autore.isNotEmpty && autore[0].startsWith('Mi dispiace')) {
        sentences.removeAt(0);
        sentences.remove(1);
    }
    autore = sentences.join('. ');
    autore.replaceAll('Certo', '');
    autore.replaceAll('Certo, ', '');
    autore.replaceAll('Certamente, ', '');
    autore.replaceAll('Certamente', '');
    autore.replaceAll('Certamente! ', '');
    autore.replaceAll('PDF', 'opera');
    autore.replaceAll('PDF.', 'opera');
    autore.replaceAll('nel PDF.', 'nell\'opera.');
    
    isOperainLibro = true;
    return true;
  }

    isOperainLibro = false;
    print("L'opera letteraria NON è nel libro");
    /*Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ErrorAlertPageOpera(text: "Errore. L'opera scannerizzata non è contenuta nel libro selezionato"),
      )
    );*/
    mostraErrore(context, "Errore. L'opera scannerizzata non è contenuta nel libro selezionato");
    isOperainLibro=false;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);

    //var stepSoluzioni = List.generate(10);

    return SafeArea(
      left: true,
      right: true,
      bottom: false,
      top: true,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Scaffold(
            
            backgroundColor: Colors.white,
            body: Column (
            children: [
              // ----- HEADER -----
            PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: Header(
                iconProfile: Image.asset('assets/person-icon.png'),
                text: "Analisi Opera Letteraria",
                isHomePage: false,
                isProfilo: false,
              ),
            ),
            SingleChildScrollView(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                    top: 15, 
                    left: isTabletOrizzontale(mediaQueryData) 
                      ? mediaQueryData.size.width * 0.15
                      : mediaQueryData.size.width * 0.08,
                    right: isTabletOrizzontale(mediaQueryData) 
                      ? mediaQueryData.size.width * 0.15
                      : mediaQueryData.size.width * 0.08,
                      bottom: 25,
                  ),
                child: Column(
                  children: [

                    /*
                    IMMAGINE DA ANALIZZARE
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        if (widget.selectedImageOpera != null)
                          Image.file(widget.selectedImageOpera!),
                        SizedBox(height: 20),
                        Text(
                          'Altre informazioni o widget qui...',
                        ),
                      ],
                    ),*/
                    
                    Text(
                      "Libro selezionato", 
                      style: TextStyle(fontSize: 18, 
                                        fontWeight: FontWeight.bold,), 
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 15,),
                    

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6.0),
                          child: Image.memory(
                            imageBytes,
                            width: isTabletOrizzontale(mediaQueryData)
                                ? 45
                                : 60,
                          ),
                        ),

                        SizedBox(width: 30,),

                        Text(
                          widget.libro.titolo, 
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,), 
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),

                    Container(
                      alignment: Alignment.center,
                      height: 1,
                      width: mediaQueryData.size.width * 0.8,
                      color: Colors.grey, // Colore della linea grigia
                    ),

                    SizedBox(height: 30,),

                    FutureBuilder(
                      future: loadPdf(), 
                      builder: (context, snapshot) {
                      //if (isOperainLibro){

                        if (snapshot.connectionState == ConnectionState.done) {
                            return Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  //mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10, bottom: 5),
                                        child: Text(
                                          "Analisi dell'opera",
                                          style: TextStyle(
                                            color: Color(0xFF05a8ba),
                                            fontSize: 16, 
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 0),
                                      child: Text( 
                                        analisi,
                                        //"\"L'Infinito\" di Giacomo Leopardi è una poesia composta nel 1819 che esplora il contrasto tra il desiderio umano di comprendere l\'infinito e la consapevolezza della propria finitezza. La struttura metrica regolare e il ritmo uniforme creano un senso di riflessione continua. Leopardi utilizza simboli come l\'orizzonte, il mare e la selva oscura per rappresentare l\'infinito e sottolinea la difficoltà umana nell\'esplorare questo concetto. La poesia riflette l\'atmosfera romantica del XIX secolo e mostra un profondo senso di malinconia e nostalgia per un'esperienza irraggiungibile. La chiusura con l\'immagine dell\'alba suggerisce una sorta di speranza nonostante la limitatezza umana.",
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15,),

                                Container(
                                  alignment: Alignment.center,
                                  height: 1,
                                  width: mediaQueryData.size.width * 0.8,
                                  color: Colors.grey, // Colore della linea grigia
                                ),

                                SizedBox(height: 30,),

                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    //mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 10, bottom: 5),
                                          child: Text(
                                            "Informazioni sull'autore",
                                            style: TextStyle(
                                              color: Color(0xFF05a8ba),
                                              fontSize: 16, 
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 0),
                                      child: Text(
                                        autore,
                                        //"Giacomo Leopardi (1798-1837) è stato un poeta, filosofo e scrittore italiano, considerato uno dei più grandi intellettuali del periodo romantico. Nato a Recanati, nelle Marche, Leopardi ha trascorso gran parte della sua vita in isolamento a causa di una salute precaria e di una famiglia oppressiva. \n La sua produzione poetica è notevole e include opere come \"L\'Infinito,\" \"A Silvia,\" e \"Il Sabato del Villaggio.\" Leopardi è spesso associato al pessimismo e al malinconico senso della vita, riflessi nelle sue opere. \n Oltre alla poesia, Leopardi ha scritto saggi filosofici, tra cui \"Operette morali\" e \"Zibaldone,\" un ampio diario di pensieri e riflessioni. La sua produzione riflette profondità intellettuale, critica sociale e una visione profondamente critica della condizione umana. Leopardi è riconosciuto come una figura chiave nella letteratura italiana e europea.",
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              

                                SizedBox(height: 15,),

                                Container(
                                  alignment: Alignment.center,
                                  height: 1,
                                  //width: mediaQueryData.size.width * 0.8,
                                  color: Colors.grey, // Colore della linea grigia
                                ),
                              ],
                            );
                          //}
                        } else if(snapshot.connectionState == ConnectionState.waiting){
                          return CircularProgressIndicator(color: Color(0xFF0097b2),);
                        }else {
                          return Text('Errore: ${snapshot.error}');
                        } 
                      
                      /*}
                      else{
                        return Column(
                          children: []
                        );
                      }*/
                      }
                    ),

                    
                  ],
                ),
              ),
            ),
            ],
            ),
          ),
        ],
      ),
    );
  }
}