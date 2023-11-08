import 'package:booktalk_app/libreria.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/sfondo.png"), 
              fit: BoxFit.cover,
            ),
            /*gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.blue, Colors.white], // Colore di partenza e colore di arrivo del gradiente
                    ),*/
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Azioni da eseguire quando viene premuto il bottone
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                        child: Image.asset("assets/person-icon.png", width: 32, height: 32),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white, // Colore del bordo circolare
                      width: 2.0, // Larghezza del bordo circolare
                    ),
                    /*gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.blue, Color.fromARGB(255, 50, 238, 163)], // Colore di partenza e colore di arrivo del gradiente
                    ),*/
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 112, 112, 112),
                        offset: Offset(0, 2), // Spostamento dell'ombra in orizzontale e verticale
                        blurRadius: 6, // Intensità dell'ombra
                        spreadRadius: 0, // Estensione dell'ombra
                      ),
                    ],
                  ),
                  child: Image.asset(
                    "assets/BookTalk-noScritta.png",
                    width: 80,
                  ),
                ),
                SizedBox(height: 20),

                Text(
                  'BookTalk',
                  style: TextStyle(fontFamily: 'Roboto', fontSize: 45, fontWeight: FontWeight.bold, color: Colors.white, shadows: [
                  Shadow(
                    blurRadius: 4,
                    color: Color.fromARGB(255, 112, 112, 112),
                    offset: Offset(2, 2),
                  ),
                ],),
                ),
                SizedBox(height: 20),

                _buildFeatureCard(
                  "assets/1.png",
                  "Risoluzione di Espressioni Matematiche",
                  "Scansiona o inserisci l’espressione matematica e BookTalk ti aiuterà nella risoluzione.",
                  () {
                    // Azioni per il primo riquadro
                  },
                  Color(0xFFf0bc5e), // Colore del pulsante
                  "Esegui"
                ),
                SizedBox(height: 10),
                _buildFeatureCard(
                  "assets/2.jpeg",
                  "Opere Letterarie e Analisi",
                  "Seleziona un libro dalla tua libreria, poi scansiona il testo di interesse per ricevere analisi approfondite.",
                  () {
                    // Azioni per il secondo riquadro
                  },
                  Color(0xFF86d7e5), // Colore del pulsante
                  "Inizia"
                ),
                SizedBox(height: 10),
                _buildFeatureCard(
                  "assets/3.jpeg",
                  "Supporto al learning",
                  "Specifica la parte di libro da studiare e BookTalk ti ascolterà durante la ripetizione dell’argomento.",
                  () {
                    // Azioni per il terzo riquadro
                  },
                  Colors.red, // Colore del pulsante
                  "Esplora"
                ),
                SizedBox(height: 10),
                /*InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Libreria()));
                  },
                  child: Image.asset('assets/library.gif', width: 200),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(String iconPath, String title, String description, Function onPressed, Color buttonColor, String buttonText) {
    return Container(
      width: 350,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
        BoxShadow(
          color: Colors.grey,
          offset: Offset(0, 2), // Spostamento dell'ombra in orizzontale e verticale
          blurRadius: 6, // Intensità dell'ombra
          spreadRadius: 0, // Estensione dell'ombra
        ),
      ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            iconPath,
            height: 50,
          ),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
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
          Center(
          child: Container(
            height: 1.0, // Altezza della linea
            width: 280.0, // Lunghezza della linea
            color: const Color.fromARGB(255, 112, 112, 112), // Colore della linea
          ),
        ),
        SizedBox(height: 10,),
          ElevatedButton(
            onPressed: () {
              onPressed();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(buttonColor),
              textStyle: MaterialStateProperty.all(TextStyle(fontSize: 16, fontWeight: FontWeight.bold,)),
            ),
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }
}
