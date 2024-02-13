import 'dart:ui';

import 'package:booktalk_app/gestioneCoupon.dart';
import 'package:booktalk_app/homepageResponsive.dart';
import 'package:booktalk_app/utils.dart';
import 'package:booktalk_app/widget/header.dart';
import 'package:flutter/material.dart';

class AggiuntaLibroResponsive extends StatefulWidget {
  final String isbn;
  const AggiuntaLibroResponsive({
    Key? key,
    required this.isbn,
  }) : super(key: key);

  @override
  _AggiuntaLibroResponsiveState createState() =>
      _AggiuntaLibroResponsiveState();
}

class _AggiuntaLibroResponsiveState extends State<AggiuntaLibroResponsive> {
  @override
  void initState() {
    super.initState();
  }

  String loadCopertina(String isbn) {
    if (isbn == '9781070658773') {
      return "assets/copertina1.jpg";
    } else if (isbn == '8806134965') {
      return "assets/copertina2.jpg";
    } else if (isbn == '8886113277') {
      return "assets/copertina3.jpg";
    } else if (isbn == '8879835629') {
      return "assets/copertina4.jpg";
    } else if (isbn == '8811584043') {
      return "assets/copertina5.jpg";
    } else if (isbn == '9788866565062') {
      return "assets/copertina6.jpg";
    } else if (isbn == '9788817107488') {
      return "assets/copertina5Maggio.jpg";
    } else {
      return "assets/image_not_found.jpg";
    }
  }

  String loadTitolo(String isbn) {
    if (isbn == '9781070658773') {
      return "Aforismi, novelle e profezie";
    } else if (isbn == '8806134965') {
      return "I libri della famiglia";
    } else if (isbn == '8886113277') {
      return "La fabbrica";
    } else if (isbn == '8879835629') {
      return "Novelle per un anno";
    } else if (isbn == '8811584043') {
      return "Senso e Nuove Storielle Vane";
    } else if (isbn == '9788866565062') {
      return "L'infinito";
    } else if (isbn == '9788817107488') {
      return "Il Cinque Maggio";
    } else {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    // variabile che indica le informazioni correnti del dispositivo
    var mediaQueryData = MediaQuery.of(context);

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
                text: "Aggiunta libro",
                isHomePage: false,
                isProfilo: false,
              ),
            ),
            backgroundColor: Colors.white,
            body: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: isTabletOrizzontale(mediaQueryData)
                          ? 0
                          : mediaQueryData.size.height * 0.05),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: Image.asset(
                          loadCopertina(widget.isbn),
                          width: isTabletOrizzontale(mediaQueryData) ? 45 : 60,
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        //"Titolo",
                        loadTitolo(widget.isbn),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: isTabletOrizzontale(mediaQueryData)
                          ? mediaQueryData.size.height * 0.04
                          : mediaQueryData.size.height * 0.1),
                  child: Text(
                    "Inserisci il coupon del tuo libro",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: isTabletOrizzontale(mediaQueryData)
                          ? mediaQueryData.size.height * 0.03
                          : mediaQueryData.size.height * 0.05,
                      left: isTabletOrizzontale(mediaQueryData)
                          ? mediaQueryData.size.width * 0.20
                          : 20,
                      right: isTabletOrizzontale(mediaQueryData)
                          ? mediaQueryData.size.width * 0.20
                          : 20),
                  child: TextFormField(
                    restorationId: 'coupon_field',
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      // focusColor: Color(0xFF0097b2),
                      labelText: 'Coupon',
                      labelStyle: TextStyle(fontSize: 16, color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.5,
                          )),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1.5,
                        ),
                      ),
                      filled: true,
                      prefixIcon: Icon(
                        Icons.book_outlined,
                      ),
                    ),
                    keyboardType: TextInputType.name,
                    autofocus: true,
                    onFieldSubmitted: (coupon) async {
                      //Future<String> s =
                      verificaCoupon(widget.isbn, coupon, context)
                          .then((value) {
                        //Navigator.of(context).pop();
                        //modificaOK(context, value);
                        if (value == "OK") {
                          modificaOK(context,
                              'Il libro è supportato e il codice coupon è valido.');
                        } else if (value == "No coupon") {
                          mostraErrore(context,
                              'Libro attualmente non supportato o codice coupon non valido.');
                        }
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => HomepageResponsitive(),
                          ),
                        );
                      });
                      /*
                      FutureBuilder<String>(
                        future: verificaCoupon(widget.isbn, value, context),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }else if(snapshot.connectionState == ConnectionState.done){
                            modificaOK(context, snapshot.data!);
                            return HomepageResponsitive();
                            
                            /*Navigator.of(context).popUntil((route) => route.isFirst);

                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => HomepageResponsitive(),
                              ),
                            ); */
                          }else{
                            return ErrorAlertPageIsbn(text: "Errore! Prova a reinserire l'ISBN.");
                          }
                        }, 
                      );
                      */

                      /*
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CaricamentoResponsive(text: "Aggiornamento dei dati in corso...")),
                      );

                      verificaCoupon(widget.isbn, value, context);

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomepageResponsitive())
                      );
                      */
                    },
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
