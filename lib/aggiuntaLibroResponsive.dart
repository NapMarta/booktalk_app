
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:booktalk_app/homepageResponsive.dart';
import 'package:booktalk_app/utils.dart';
import 'package:booktalk_app/widget/header.dart';
import 'package:flutter/material.dart';

import 'package:image/image.dart' as Img;
import 'package:http/http.dart' as http;
    
class AggiuntaLibroResponsive extends StatefulWidget {

  final File? selectedImageAddLibro;
  const AggiuntaLibroResponsive({Key? key, this.selectedImageAddLibro}) : super(key: key);

  @override
  _AggiuntaLibroResponsiveState createState() => _AggiuntaLibroResponsiveState();
}

class _AggiuntaLibroResponsiveState extends State<AggiuntaLibroResponsive> {

  late String? isbn;

  @override
  void initState() {
    super.initState();
    loadISBN();
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

  Future<void> loadISBN() async {

    // ESTRAZIONE TESTO DA IMMAGINE
    final apiUrl = Uri.parse('http://130.61.22.178:9000/text_detection');
    Img.Image image = Img.decodeImage(await widget.selectedImageAddLibro!.readAsBytes())!;
    Uint8List imageBytes = Uint8List.fromList(Img.encodePng(image)!);
    String extractedText = "";

    try{
      var request = http.MultipartRequest('POST', apiUrl)
        ..files.add(http.MultipartFile.fromBytes(
          'image',
          imageBytes,
          filename: 'temp.png',
        ));
      final response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print(response.body);
        //extractedText = data['detected_text'];
        extractedText = response.body;
        //print(extractedText);
        isbn = extractISBN(extractedText);
        print(isbn);
      } else {
        print(response.body);
        print('Errore nella richiesta API: ${response.statusCode}');
      }
    } catch (e) {
      print('Errore: $e');
    }
    setState(() {});
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
                  padding: EdgeInsets.only(top: isTabletOrizzontale(mediaQueryData)
                                                ? 0
                                                : mediaQueryData.size.height * 0.05),
                  child: Row(
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
                ),

                Padding(
                  padding: EdgeInsets.only(top: isTabletOrizzontale(mediaQueryData)
                                                ? mediaQueryData.size.height * 0.04
                                                : mediaQueryData.size.height * 0.1),
                  child: Text(
                    "Inserisci il coupon del tuo libro", 
                    style: TextStyle(fontSize: 18, 
                                      fontWeight: FontWeight.bold,), 
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
                      labelStyle: TextStyle(fontSize:  16, 
                                            color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1.5,
                        )
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1.5,
                        ),
                      ),
                      filled: true,
                      prefixIcon: Icon(Icons.book_outlined,),
                    ),
                    keyboardType: TextInputType.name,
                    autofocus: true,                    
                    onFieldSubmitted: (value) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => HomepageResponsitive(),
                        )
                      );
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