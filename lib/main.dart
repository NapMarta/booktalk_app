//import 'package:camera/camera.dart'
import 'package:booktalk_app/libreria.dart';
import 'package:flutter/material.dart';
import 'registrazione.dart';
import 'login.dart';

//late List<CameraDescription> _cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //_cameras = await availableCameras();
  //final firstCamera = _cameras.first;

  runApp(MaterialApp(
    home: BookTalkApp(),
  ));
}


class BookTalkApp extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
      backgroundColor: Colors.white,

        // ------ HEADER ------
        /*appBar: AppBar(
          title: Image.asset('assets/BookTalk-scritta.png', width: 150),
          backgroundColor: Color(0xFFbee2ee),
          elevation: 0.1,
        ),*/

        // ------ HEADER ------
        /*appBar: AppBar(
          title: Image.asset('assets/scritta_noSfondo.png', width: 150),
          backgroundColor: Color.fromARGB(0, 255, 255, 255),
          elevation: 0,
        ),*/


        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              // ------ LOGO ------
              Image.asset('assets/logo_noSfondo.png', width: 200, height: 200),
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
                  backgroundColor: MaterialStateProperty.all(Color(0xFF1B536E)),
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
                  backgroundColor: MaterialStateProperty.all(Color(0xFF0097B2)),
                  textStyle: MaterialStateProperty.all(TextStyle(fontSize: 16, fontWeight: FontWeight.bold,)),
                ),
                child: Text('Accedi'),
              ),


              /*ElevatedButton(
                onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Libreria(),
                      ),
                  ); 
                },
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(Size(200, 50)),
                  backgroundColor: MaterialStateProperty.all(Color(0xFF087B69)),
                  textStyle: MaterialStateProperty.all(TextStyle(fontSize: 16, fontWeight: FontWeight.bold,)),
                ),
                child: Text('Libreria'),
              ),*/

            ],
          ),
        ),
      ),
    );
  }
}