//import 'package:camera/camera.dart'
import 'package:booktalk_app/loginResponsive.dart';
import 'package:booktalk_app/registrazioneResponsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final view = WidgetsBinding.instance.platformDispatcher.views.first;
  /*
  // --- Settaggio Orientamento per smartphone e tablet
  if(view.physicalSize.width < 700 && view.physicalSize.height < 700){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }else{
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitDown
    ]);
  }*/
  
  runApp(MaterialApp(
    home: BookTalkApp(),
  ));
}


class BookTalkApp extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    print(mediaQueryData.size);
    // print(mediaQueryData.size);
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
                      builder: (context) => RegistrazioneResponsive(),
                    ),
                  );
                },
                
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(Size(buttonWidth(mediaQueryData.size.width, mediaQueryData.size.height), 55)),
                  backgroundColor: MaterialStateProperty.all(Color(0xFF1B536E)),
                  textStyle: MaterialStateProperty.all(TextStyle(fontSize: 15, fontWeight: FontWeight.bold,)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // Adjust the value as needed
                    ),
                  ),
                ),
                child: Text('Registrati', style: TextStyle(color: Colors.white)),
              ),

              SizedBox(height: mediaQueryData.size.height * 0.02), // Spazio tra i pulsanti

              // ------ Pulsante "Accedi" ------
              ElevatedButton(
                onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LoginResponsive(),
                      ),
                  ); 
                },
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(Size(buttonWidth(mediaQueryData.size.width, mediaQueryData.size.height), 55)),
                  backgroundColor: MaterialStateProperty.all(Color(0xFF0097B2)),
                  textStyle: MaterialStateProperty.all(TextStyle(fontSize: 15, fontWeight: FontWeight.bold,)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // Adjust the value as needed
                    ),
                  ),
                ),
                child: Text('Login', style: TextStyle(color: Colors.white)),
              ),

            ],
          ),
        ),
      ),
    );
  }
}