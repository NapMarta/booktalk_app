import 'package:booktalk_app/camera.dart';
import 'package:booktalk_app/header.dart';
import 'package:booktalk_app/libreriaResponsive.dart';
import 'package:booktalk_app/supporto-al-learning.dart';
import 'package:booktalk_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:auto_size_text/auto_size_text.dart';

class HomepageResponsitive extends StatefulWidget {
  const HomepageResponsitive({Key? key}) : super(key: key);

  @override
  _HomepageResponsitiveState createState() => _HomepageResponsitiveState();
}

class _HomepageResponsitiveState extends State<HomepageResponsitive> {
  
  @override
  Widget build(BuildContext context) {
    // variabile che indica le informazioni correnti del dispositivo
    var mediaQueryData = MediaQuery.of(context);

    // varaiabile per lo slide-up
    final panelController = PanelController();
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
                  
                  // logo dell'app
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/logo_noSfondo.png",
                      height: mediaQueryData.size.height * 0.15,
                    ),
                  ),
                  
                  // spazio sotto al logo
                  SizedBox(height: mediaQueryData.size.height * 0.03,),

                  // i pulsanti con le tre funzionalità
                  _buildFeatureCard(
                    "assets/1.png",
                    "Espressioni Matematiche",
                    "Scansiona o inserisci l'espressione matematica e BookTalk ti aiuterà nella risoluzione.",
                    () {
                      Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Camera(),
                          ),
                      );
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
                    () => panelController.open(),
                    Color(0xFF05a8ba),
                    mediaQueryData.size.height,
                    mediaQueryData.size.width
                  ),

                  // spazio tra i pulsanti
                  SizedBox(height: mediaQueryData.size.height * 0.02,),

                  _buildFeatureCard(
                    "assets/funzionalità3.jpg",
                    "Supporto al learning",
                    "Specifica la parte di libro da studiare e BookTalk ti ascolterà durante la ripetizione dell’argomento.",
                    () {
                      Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SupportoAlLearningScreen(),
                          ),
                      ); 
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
                minHeight: mediaQueryData.size.height * 0.25,
                maxHeight: mediaQueryData.size.height * 0.965,
                // panel
                panel: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.0),
                      topRight: Radius.circular(24.0),
                    ),
                  ),
                  
                  child: LibreriaResponsive(),
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
              ),

            ],
          ),
        ),
      ),
    );
  }
}


Widget _buildFeatureCard(String iconPath, String title, String description, VoidCallback onPressed, Color titleColor, double height, double width) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      width: width * 0.85,
      height: height * 0.13,
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
              padding: const EdgeInsets.all(10),
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
                            fontSize: size(width, height, 16),
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
                      fontSize: size(width, height, 13),
                      color: Color.fromARGB(255, 112, 112, 112),
                    ),
                    textAlign: TextAlign.center,
                    minFontSize: 12,
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