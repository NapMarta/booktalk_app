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

        // SFONDO
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/sfondo.JPEG'),
              fit: BoxFit.cover,
            ),
          ),

          // NOME APP
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 250,),
                Text(
                  'BookTalk',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 30),

                // PULSANTE 1
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Azioni per il primo pulsante
                      },
                      style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(Size(280, 50)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40), // Imposta i bordi ovali
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(Color(0xFF0087b5).withOpacity(0.6)),
                      textStyle: MaterialStateProperty.all(TextStyle(fontSize: 16, fontWeight: FontWeight.bold,)),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 10),
                          Image.asset("assets/1.png", height: 40,),
                          SizedBox(width: 8), // Spazio tra l'immagine e il testo
                          Text("Risolvi espressione", style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                // PULSANTE 2
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Azioni per il primo pulsante
                      },
                      style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(Size(280, 50)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40), // Imposta i bordi ovali
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(Color(0xFF0087b5).withOpacity(0.6)),
                      textStyle: MaterialStateProperty.all(TextStyle(fontSize: 16, fontWeight: FontWeight.bold,)),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 10),
                          Image.asset("assets/2.png", height: 40,),
                          SizedBox(width: 8), // Spazio tra l'immagine e il testo
                          Text("Analizza testo", style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                //PULSANTE 3
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Azioni per il primo pulsante
                      },
                      style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(Size(280, 50)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40), // Imposta i bordi ovali
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(Color(0xFF0087b5).withOpacity(0.6)),
                      textStyle: MaterialStateProperty.all(TextStyle(fontSize: 16, fontWeight: FontWeight.bold,)),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 10),
                          Image.asset("assets/3.png", height: 40,),
                          SizedBox(width: 8), // Spazio tra l'immagine e il testo
                          Text("Studia argomento", style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                

                // PULSANTE LIBRERIA
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Libreria()));
                  },
                  child: Image.asset('assets/library.gif', width: 200,),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
