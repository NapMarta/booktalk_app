// ignore_for_file: prefer_const_constructors
import 'package:booktalk_app/espressioni-matematiche.dart';
import 'package:booktalk_app/profilo.dart';
import 'package:booktalk_app/supporto-al-learning.dart';
import 'package:flutter/material.dart';
import 'libreria.dart';
import 'espressioni-matematiche.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final Libreria _libreriaPage = Libreria();
  final panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/sfondo.png"),
                  fit: BoxFit.cover,
                ),
                //color: Colors.white,
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 10.0, top: 0),
                              child: Text(
                                'Bentornata Maria!',
                                style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          shadows: [
                            Shadow(
                              blurRadius: 8,
                              color: Colors.white,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                              ),
                            ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ProfilePage(),
                                  ),
                              ); 
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 190.0, top: 0),
                              child: Image.asset("assets/person-icon.png", width: 32),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.transparent,
                            width: 2.0,
                          ),
                          color: Colors.transparent,
                          /*boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 112, 112, 112),
                              offset: Offset(0, 2),
                              blurRadius: 6,
                              spreadRadius: 0,
                            ),
                          ],*/
                        ),
                        child: Image.asset(
                          "assets/BookTalk-noScritta.png",
                          width: 120,
                        ),
                      ),
                      /*Text(
                        'Bentornata Maria!',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 4,
                              color: Color.fromARGB(255, 112, 112, 112),
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                      ),*/
                      Container(
                        width: 220,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white, // Colore dell'ombra (bianco in questo caso)
                              spreadRadius: 3, // Estensione dell'ombra
                              blurRadius: 25, // Intensità dell'ombra
                              offset: Offset(0, 0), // Spostamento dell'ombra in orizzontale e verticale
                            ),
                          ],
                        ),
                        child: Image.asset("assets/BookTalk-scritta.png", width: 220),
                      ),                      SizedBox(height: 20),
                      _buildFeatureCard(
                        "assets/1.png",
                        "Espressioni Matematiche",
                        "Scansiona o inserisci l'espressione matematica e BookTalk ti aiuterà nella risoluzione.",
                        () {
                          /*Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => RisolviEspressioni(),
                              ),
                          );*/
                        },
                        Color(0xFFf0bc5e),
                        "Esegui",
                      ),
                      SizedBox(height: 20),
                      _buildFeatureCard(
                        "assets/2.jpeg",
                        "Opere Letterarie e Analisi",
                        "Seleziona un libro dalla tua libreria, poi scansiona il testo di interesse per ricevere analisi approfondite.",
                        () {
                          // Azioni per il secondo riquadro
                        },
                        Color(0xFF05a8ba),
                        "Inizia",
                      ),
                      SizedBox(height: 20),
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
                        "Esplora",
                      ),
                      SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
            SlidingUpPanel(
              minHeight: 65.0,
              maxHeight: 800.0,
              panel: Center(child: _libreriaPage),
              backdropEnabled: true,
              slideDirection: SlideDirection.UP,
              collapsed: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF0099b5),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.0),
                    topRight: Radius.circular(24.0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/linea.png", width: 70,),
                    //Text("^", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30)),
                    SizedBox(height: 15),
                    //Image.asset("assets/library.gif", width: 70,),
                    Text(
                      'Libreria',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22
                      ),
                    ),
                    SizedBox(height: 10),

                  ],
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
    );
  }  
}



 Widget _buildFeatureCard(String iconPath, String title, String description, Function onPressed, Color buttonColor, String buttonText) {
  return Container(
    width: 350,
    height: 168,
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
        // Immagine a sinistra del testo
        Padding(
          padding: const EdgeInsets.all(10), // Aggiunge spazio attorno all'immagine
          child: Image.asset(
            iconPath,
            height: 50,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center, // Centro il pulsante
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 112, 112, 112),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Container(
                  height: 1.0,
                  width: 280.0,
                  color: Color.fromARGB(255, 112, 112, 112),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.center, // Centro il pulsante
                  child: ElevatedButton(
                    onPressed: () {
                      onPressed();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(buttonColor),
                      textStyle: MaterialStateProperty.all(
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    child: Text(buttonText),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}