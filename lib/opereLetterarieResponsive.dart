import 'package:booktalk_app/utils.dart';
import 'package:booktalk_app/widget/header.dart';
import 'package:flutter/material.dart';
    
class OpereLetterarieResponsive extends StatefulWidget {
  const OpereLetterarieResponsive({Key? key}) : super(key: key);

  @override
  _OpereLetterarieResponsiveState createState() => _OpereLetterarieResponsiveState();
}

class _OpereLetterarieResponsiveState extends State<OpereLetterarieResponsive> {
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
            // ----- HEADER -----
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: Header(
                iconProfile: Image.asset('assets/person-icon.png'),
                text: "Analisi Opera Letteraria",
                isHomePage: false,
                isProfilo: false,
              ),
            ),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
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
                    
                    Text(
                      "L'opera \"L'Infinito\" è contenuta nel seguente libro", 
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
                          child: Image.asset(
                            "assets/libro1.jpg",
                            width: isTabletOrizzontale(mediaQueryData)
                                ? 45
                                : 60,
                          ),
                        ),

                        SizedBox(width: 30,),

                        Text(
                          "Titolo libro", 
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
                            "\"L'Infinito\" di Giacomo Leopardi è una poesia composta nel 1819 che esplora il contrasto tra il desiderio umano di comprendere l\'infinito e la consapevolezza della propria finitezza. La struttura metrica regolare e il ritmo uniforme creano un senso di riflessione continua. Leopardi utilizza simboli come l\'orizzonte, il mare e la selva oscura per rappresentare l\'infinito e sottolinea la difficoltà umana nell\'esplorare questo concetto. La poesia riflette l\'atmosfera romantica del XIX secolo e mostra un profondo senso di malinconia e nostalgia per un'esperienza irraggiungibile. La chiusura con l\'immagine dell\'alba suggerisce una sorta di speranza nonostante la limitatezza umana.",
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
                            "Giacomo Leopardi (1798-1837) è stato un poeta, filosofo e scrittore italiano, considerato uno dei più grandi intellettuali del periodo romantico. Nato a Recanati, nelle Marche, Leopardi ha trascorso gran parte della sua vita in isolamento a causa di una salute precaria e di una famiglia oppressiva. \n La sua produzione poetica è notevole e include opere come \"L\'Infinito,\" \"A Silvia,\" e \"Il Sabato del Villaggio.\" Leopardi è spesso associato al pessimismo e al malinconico senso della vita, riflessi nelle sue opere. \n Oltre alla poesia, Leopardi ha scritto saggi filosofici, tra cui \"Operette morali\" e \"Zibaldone,\" un ampio diario di pensieri e riflessioni. La sua produzione riflette profondità intellettuale, critica sociale e una visione profondamente critica della condizione umana. Leopardi è riconosciuto come una figura chiave nella letteratura italiana e europea.",
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}