import 'package:booktalk_app/camera.dart';
import 'package:booktalk_app/header.dart';
import 'package:booktalk_app/libreria-secondafunz.dart';
import 'package:booktalk_app/supporto-al-learning.dart';
import 'package:flutter/material.dart';
import 'utils.dart';

class HomepageResponsitive extends StatefulWidget {
  const HomepageResponsitive({Key? key}) : super(key: key);

  @override
  _HomepageResponsitiveState createState() => _HomepageResponsitiveState();
}

class _HomepageResponsitiveState extends State<HomepageResponsitive> {
  
  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);


    return SafeArea(
      // bordi da considerare del telefono
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
          child: Column(
            children: [
              PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight),
                child: Header(
                  iconProfile: Image.asset('assets/person-icon.png'), 
                  text: "Ciao Maria!",
                  isHomePage: true,
                ),
              ),
              
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/logo_noSfondo.png",
                  height: mediaQueryData.size.height * 0.15,
                ),
              ),
              
              SizedBox(height: mediaQueryData.size.height * 0.05,),
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
              SizedBox(height: mediaQueryData.size.height * 0.03,),
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
                mediaQueryData.size.height,
                mediaQueryData.size.width
              ),
              SizedBox(height: mediaQueryData.size.height * 0.03,),
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
        ),
      ),
    );
  }
}


Widget _buildFeatureCard(String iconPath, String title, String description, VoidCallback onPressed, Color titleColor, var height, var width) {
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
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: textSize(width, height, 0.023),
                        fontWeight: FontWeight.bold,
                        color: titleColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: textSize(width, height, 0.02),
                      color: Color.fromARGB(255, 112, 112, 112),
                    ),
                    textAlign: TextAlign.center,
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


