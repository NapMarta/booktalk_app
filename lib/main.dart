import 'package:flutter/material.dart';
import 'registrazione.dart';
import 'login.dart';

void main() {
  runApp(MaterialApp(
    home: BookTalkApp(),
  ));
}


class BookTalkApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(

        // ------ HEADER ------
        appBar: AppBar(
          title: Image.asset('assets/BookTalk-scritta.png', width: 150),
          backgroundColor: Color(0xFFbee2ee),
          elevation: 0.1,
        ),


        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              // ------ LOGO ------
              Image.asset('assets/BookTalk-logo-noSfondo.png', width: 200, height: 200),
              SizedBox(height: 40), 

              // ------ Pulsante "Registrati" ------
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => RegistrationPage(),
                    ),
                  );
                },
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(Size(200, 50)),
                  backgroundColor: MaterialStateProperty.all(Color(0xFF0099b5)),
                  textStyle: MaterialStateProperty.all(TextStyle(fontSize: 16, fontWeight: FontWeight.bold,)),
                ),
                child: Text('Registrati'),
              ),

              SizedBox(height: 20), // Spazio tra i pulsanti

              // ------ Pulsante "Accedi" ------
              ElevatedButton(
                onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                  ); 
                },
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(Size(200, 50)),
                  backgroundColor: MaterialStateProperty.all(Color(0xFF087B69)),
                  textStyle: MaterialStateProperty.all(TextStyle(fontSize: 16, fontWeight: FontWeight.bold,)),
                ),
                child: Text('Accedi'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}