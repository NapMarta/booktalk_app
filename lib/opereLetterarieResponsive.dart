import 'dart:typed_data';

import 'package:booktalk_app/business_logic/monitoraggioStatistiche.dart';
import 'package:booktalk_app/storage/libro.dart';
import 'package:booktalk_app/utils.dart';
//import 'package:booktalk_app/widget/ErrorAlertPageOpera.dart';
import 'package:booktalk_app/widget/header.dart';
import 'package:flutter/material.dart';
//import 'package:image/image.dart' as Img;
//import 'package:http/http.dart' as http;


    
class OpereLetterarieResponsive extends StatefulWidget {
  // final File selectedImageOpera;
  final Libro libro; 
  final List<String> lista;

  const OpereLetterarieResponsive({
    Key? key,
    
    //required this.selectedImageOpera,
    required this.libro, 
    required this.lista,
  }) : super(key: key);

  @override
  _OpereLetterarieResponsiveState createState() => _OpereLetterarieResponsiveState();
}


class _OpereLetterarieResponsiveState extends State<OpereLetterarieResponsive> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  
  MonitoraggioStatistiche monitoraggioStatistiche = MonitoraggioStatistiche.instance;
  late Uint8List imageBytes;
  //bool isOperainLibro = false;

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


  

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var mediaQueryData = MediaQuery.of(context);

    //var stepSoluzioni = List.generate(10);

    return SafeArea(
      left: true,
      right: true,
      bottom: false,
      top: true,
      child:
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
            Expanded(
              child: SingleChildScrollView(
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
                      "L\'opera è contenuta nel seguente libro", 
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

                    

                    Column(
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
                                widget.lista[0],
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
                                widget.lista[1],
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
                    ),
                    SizedBox(height: 30,),
                  ],
                ),
              ),
            ),
            ),
            ],
            ),
          ),
    );
  }
}