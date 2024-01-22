import 'dart:io';

import 'package:booktalk_app/widget/header.dart';
import 'package:booktalk_app/libreriaResponsive.dart';
import 'package:booktalk_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async' show Future;

class HomepageResponsitive extends StatefulWidget {
  const HomepageResponsitive({Key? key}) : super(key: key);

  @override
  _HomepageResponsitiveState createState() => _HomepageResponsitiveState();
}


class _HomepageResponsitiveState extends State<HomepageResponsitive> {
  final panelController = PanelController();
  File ? _selectedImage;
  bool is2 = false;
  bool is3 = false;

  @override
  Widget build(BuildContext context) {
    // variabile che indica le informazioni correnti del dispositivo
    var mediaQueryData = MediaQuery.of(context);

    // varaiabile per lo slide-up
    //final panelController = PanelController();
    //var slide = _WidgetSlideUpState(mediaQueryData.size.width, mediaQueryData.size.height, panelController);

    return SafeArea(
      // settaggio dei bordi da considerare del telefono
      left: true,
      right: true,
      bottom: false,
      top: true,
      child: Scaffold(
        // extendBodyBehindAppBar: true,
        body: Container(
          // margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + kToolbarHeight),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/sfondo2.jpg"),
              fit: BoxFit.cover,
            ),
            //color: Colors.white,
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  // Header
                  PreferredSize(
                    preferredSize: Size.fromHeight(kToolbarHeight),
                    child: Header(
                      iconProfile: Image.asset('assets/person-icon.png'), 
                      text: "Ciao Maria!",
                      isHomePage: true,
                      isProfilo: false,
                    ),
                  ),
                  
                  SizedBox(height: isTablet(mediaQueryData) ? 0 : 30,),

                  // logo dell'app
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/logo_noSfondo.png",
                      height: mediaQueryData.size.height * 0.15,
                    ),
                  ),
                  
                  // spazio sotto al logo
                  SizedBox(height: isTabletOrizzontale(mediaQueryData) ? mediaQueryData.size.height * 0.05 : mediaQueryData.size.height * 0.03,),

                  // i pulsanti con le tre funzionalità
                  _buildFeatureCard(
                    "assets/1.png",
                    "Espressioni Matematiche",
                    "Scansiona o inserisci l'espressione matematica e BookTalk ti aiuterà nella risoluzione.",
                    () {
                      getImageFromCamera();
                    },
                    Color(0xFFf0bc5e),
                    mediaQueryData.size.height,
                    mediaQueryData.size.width
                  ),

                  // spazio tra i pulsanti
                  SizedBox(height: mediaQueryData.size.height * 0.02,),
                  
                  _buildFeatureCard(
                    "assets/2.jpeg",
                    "Opere Letterarie e Analisi",
                    "Seleziona un libro dalla tua libreria, poi scansiona il testo di interesse per ricevere analisi approfondite.",
                    () {
                      setFunzionalita(true, false);
                      print(is2);
                      print(is3);
                      panelController.open();

                    },
                    Color(0xFF05a8ba),
                    mediaQueryData.size.height,
                    mediaQueryData.size.width
                  ),

                  // spazio tra i pulsanti
                  SizedBox(height: mediaQueryData.size.height * 0.02,),

                  _buildFeatureCard(
                    "assets/funzionalità3.jpg",
                    "Supporto al learning",
                    "Specifica la parte di libro da studiare e BookTalk crearà domande per ripetere dell’argomento.",
                    () {
                      setFunzionalita(false, true);
                      print(is2);
                      print(is3);
                      panelController.open();
                    },
                    Color(0xFFff3a2a),
                    mediaQueryData.size.height,
                    mediaQueryData.size.width
                  ),
                ],
              ),
              
              // ----- SLIDEUP - Libreria ----
              SlidingUpPanel(
                // making false it does 
                // not render outside
                renderPanelSheet: false,
                controller: panelController,
                minHeight: isTabletOrizzontale(mediaQueryData) ? mediaQueryData.size.height * 0.1 : mediaQueryData.size.height * 0.165,
                maxHeight: isTabletOrizzontale(mediaQueryData) 
                            ? mediaQueryData.size.height * 0.7 
                            : isTabletVerticale(mediaQueryData) 
                              ? mediaQueryData.size.height * 0.75
                              : mediaQueryData.size.height * 0.7, 

                // sfondo sfocato quando è aperto
                backdropEnabled: true,
                backdropOpacity: 0.5,

                // panel
                panel: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.0),
                      topRight: Radius.circular(24.0),
                    ),
                  ),
                  
                  child: LibreriaResponsive(is2: is2, is3: is3),
                ),
                        // collapsed 
                collapsed: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.0),
                      topRight: Radius.circular(24.0),
                    ),
                  ),
                ),
                
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0),
                ),

                onPanelClosed: () => setFunzionalita(false, false),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Future getImageFromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);

    if(image == null) return;
    setState(() {
      _selectedImage = File(image!.path);
    });
    if (_selectedImage != null) {
      await isbnRecognition(_selectedImage!);
    }
  }


  String? extractISBN(String input) {
    final RegExp regex = RegExp(r'(\bISBN\b\s*)?(\d{3})\s*[-]?\s*(\d{1,5})\s*[-]?\s*(\d{1,7})\s*[-]?\s*(\d{1,7})\s*[-]?\s*(\d{1,7})\s*[-]?\s*(\d{1,7})\s*[-]?\s*(\d{1,7})\b');

    final Iterable<Match> matches = regex.allMatches(input);
    if (matches.isNotEmpty) {
      final Match match = matches.first;
      String? isbn = match.group(0);

      int lastHyphenIndex = isbn?.lastIndexOf('-') ?? -1;

      if (lastHyphenIndex != -1) {
        isbn = isbn?.substring(0, lastHyphenIndex+2);
      }

      return isbn;
    } else {
      return 'ISBN non trovato';
    }
  }

  Future<void> isbnRecognition(File imageFile) async {
    try {
      final apiUrl = Uri.parse('http://130.61.22.178:9000/extract_text');
      final imageBytes = await imageFile.readAsBytes();

      // Crea una richiesta multipart per inviare l'immagine
      var request = http.MultipartRequest('POST', apiUrl)
        ..files.add(http.MultipartFile.fromBytes(
          'image',
          imageBytes,
          filename: 'image.png',
        ));

      var response = await http.Response.fromStream(await request.send());

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


  Future setFunzionalita(bool isF2, bool isF3) async {
    setState(() {
      is2 = isF2;
      is3 = isF3;
    });
  }

}




Widget _buildFeatureCard(String iconPath, String title, String description, VoidCallback onPressed, Color titleColor, double height, double width) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      width: width * 0.85,
      height: height * 0.135,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 2),
            blurRadius: 6,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Image.asset(
              iconPath,
              height: height * 0.07,
            ),
          ),
          Expanded(
            child: Padding(
              // modificato da 10 a 15
              padding: const EdgeInsets.only(top: 8, left: 15, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child:  FittedBox(
                      fit: BoxFit.scaleDown,
                      child: 
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: titleColor,
                          ),
                        ),
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  AutoSizeText(
                    description,
                    style: TextStyle(
                      fontSize: 13,
                      color: Color.fromARGB(255, 112, 112, 112),
                    ),
                    textAlign: TextAlign.center,
                    minFontSize: 8,
                    maxLines: 3,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}


/*
class WidgetSlideUp extends StatefulWidget {
  const WidgetSlideUp({Key? key, required this.isLibreria, required this.width, required this.height, required this.panelController}) : super(key: key);

  final bool isLibreria;
  final double width, height;
  final PanelController panelController;


  @override
  _WidgetSlideUpState createState() => _WidgetSlideUpState();
}*/

