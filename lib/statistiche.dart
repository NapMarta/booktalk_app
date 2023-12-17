import 'package:flutter/material.dart';

import 'utils.dart';
    
class Statistiche extends StatefulWidget {
  const Statistiche({Key? key}) : super(key: key);

  @override
  _StatisticheState createState() => _StatisticheState();
}

class _StatisticheState extends State<Statistiche> {
  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(mediaQueryData.size.height * 0.07),

        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFF0097b2),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: mediaQueryData.size.height * 0.006),
              Image.asset("assets/linea.png", width: mediaQueryData.size.width * 0.1,),
              SizedBox(height: mediaQueryData.size.height * 0.015),
              Text(
                'Statistiche',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: size(mediaQueryData.size.width, mediaQueryData.size.height, 16),
                ),
              ),
              //SizedBox(height: 2),
            ],
          ),
        ),
      ),

      //backgroundColor: Colors.white,
      body: ListView(
        children: [
          SizedBox(height: 10,),
          Text(
            "Utilizzo dell'app", 
            style: TextStyle(fontSize: size(mediaQueryData.size.width, mediaQueryData.size.height, 18), fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ), 
          
          SizedBox(height: 20,), 
          Image.asset("assets/grafico1.png", width: 350,),
          SizedBox(height: 80,), 
          Text(
            "Percentuale di utilizzo delle funzionalità", 
            style: TextStyle(fontSize: size(mediaQueryData.size.width, mediaQueryData.size.height, 18), fontWeight: FontWeight.bold,), 
            textAlign: TextAlign.center,
          ), 
          
          SizedBox(height: 20,), 
          Image.asset("assets/grafico2.png", width: 350,),
          SizedBox(height: 20,),
        ],
      ),
    );
  }
}