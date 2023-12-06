// ignore_for_file: prefer_const_constructors
import 'package:booktalk_app/camera.dart';
import 'package:booktalk_app/libreria-secondafunz.dart';
import 'package:booktalk_app/profilo.dart';
import 'package:booktalk_app/supporto-al-learning.dart';
import 'package:flutter/material.dart';
import 'libreria.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';


class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final Libreria _libreriaPage = Libreria();
  final panelController = PanelController();
  bool isFirstTime = true; // Aggiungi questa variabile di stato

  @override
  void initState (){
    WidgetsBinding.instance.addPostFrameCallback((_) {
        panelController.open();
        double newPosition = 80 * (800.0 - 80.0)*0.58; // Aggiusta qui secondo necessità
        panelController.animatePanelToPosition(newPosition, duration: Duration(milliseconds: 0), curve: Curves.linear);
        isFirstTime=false;
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        

        // ------ HEADER ------
        appBar: AppBar(
          
          title: Text(
            'Ciao Maria!',
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
          backgroundColor: Color.fromARGB(0, 255, 255, 255),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: IconButton(
                icon: Image.asset('assets/person-icon.png'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                    ),
                  ); 
                },
              ),
            ),
          ],
          elevation: 0,
        ),

        extendBodyBehindAppBar: true,
        body: Expanded(
          child:Center(
            child: Stack(
            children: [
              Container(
                // margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + kToolbarHeight),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/sfondo.png"),
                    fit: BoxFit.cover,
                  ),
                  //color: Colors.white,
                ),
                child: Align(
                  //alignment: Alignment.topLeft,
                  child: SingleChildScrollView(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                          Image.asset(
                            "assets/logo_noSfondo.png",
                            width: 150,
                          ),
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
                          
                        ),                      SizedBox(height: 20),
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
                        ),
                        SizedBox(height: 20),
                        _buildFeatureCard(
                          "assets/2.jpeg",
                          "Opere Letterarie e Analisi",
                          "Seleziona un libro dalla tua libreria, poi scansiona il testo di interesse per ricevere analisi approfondite.",
                          () {
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => LibreriaFunzionzlita(),
                                ),
                            );
                          },
                          Color(0xFF05a8ba),
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
                        ),
                        SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
              ),
              SlidingUpPanel(
                minHeight: 80.0,
                maxHeight: 800.0,
                controller: panelController,
                onPanelSlide: (double pos) {
                if(isFirstTime){
                  double newPosition = pos * (800.0 - 80.0) * 0.58;
                  panelController.animatePanelToPosition(newPosition, duration: Duration(milliseconds: 0), curve: Curves.linear);
                  isFirstTime=false;
                }
                else if (pos<=65.0){
                  double newPosition = 80.0 * (800.0 - 80.0) * 0.58;
                  panelController.animatePanelToPosition(newPosition, duration: Duration(milliseconds: 0), curve: Curves.linear);
                }},
                panel: Center(child: _libreriaPage),
                backdropEnabled: false,
                slideDirection: SlideDirection.UP,
                //color: Colors.transparent,
                
                collapsed: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
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
        ),
      ),
    );
  }  
}



 Widget _buildFeatureCard(String iconPath, String title, String description, VoidCallback onPressed, Color titleColor) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      width: 350,
      height: 110,
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
                    alignment: Alignment.center,
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: titleColor,
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
                  /*Container(
                    height: 1.0,
                    width: 280.0,
                    color: Color.fromARGB(255, 112, 112, 112),
                  ),
                  SizedBox(height: 10),*/
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
