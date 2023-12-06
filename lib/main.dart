//import 'package:camera/camera.dart'
import 'package:booktalk_app/libreria.dart';
import 'package:flutter/material.dart';
import 'registrazione.dart';
import 'login.dart';
import 'utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    home: BookTalkApp(),
  ));
}


class BookTalkApp extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);

    return MaterialApp(
      home: Scaffold(
      backgroundColor: Colors.white,

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              // ------ LOGO ------
              Image.asset('assets/logo_noSfondo.png', height: logoSize(mediaQueryData.size.width, mediaQueryData.size.height, 0.2)),
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
                  fixedSize: MaterialStateProperty.all(Size(mediaQueryData.size.width * 0.45, mediaQueryData.size.height * 0.07)),
                  backgroundColor: MaterialStateProperty.all(Color(0xFF1B536E)),
                  textStyle: MaterialStateProperty.all(TextStyle(fontSize: textSize(mediaQueryData.size.width, mediaQueryData.size.height, 0.025), fontWeight: FontWeight.bold,)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(mediaQueryData.size.width * 0.02), // Adjust the value as needed
                    ),
                  ),
                ),
                child: Text('Registrati'),
              ),

              SizedBox(height: mediaQueryData.size.height * 0.02), // Spazio tra i pulsanti

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
                  fixedSize: MaterialStateProperty.all(Size(mediaQueryData.size.width * 0.45, mediaQueryData.size.height * 0.07)),
                  backgroundColor: MaterialStateProperty.all(Color(0xFF0097B2)),
                  textStyle: MaterialStateProperty.all(TextStyle(fontSize: textSize(mediaQueryData.size.width, mediaQueryData.size.height, 0.025), fontWeight: FontWeight.bold,)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(mediaQueryData.size.width * 0.02), // Adjust the value as needed
                    ),
                  ),
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