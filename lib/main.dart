//import 'package:camera/camera.dart'
import 'dart:convert';

import 'package:booktalk_app/business_logic/monitoraggioStatistiche.dart';
import 'package:booktalk_app/homepageResponsive.dart';
import 'package:booktalk_app/loginResponsive.dart';
import 'package:booktalk_app/registrazioneResponsive.dart';
import 'package:booktalk_app/storage/utente.dart';
import 'package:booktalk_app/storage/utenteDAO.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info/device_info.dart';
import 'dart:ui';
import 'utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  var physicalWidth = window.physicalSize.width;
  var screenWidth = physicalWidth / window.devicePixelRatio;

  if (screenWidth >= 600) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitDown
    ]);
  } else {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  // final view = WidgetsBinding.instance.platformDispatcher.views.first;
  /*
  // --- Settaggio Orientamento per smartphone e tablet
  if(view.physicalSize.width < 700 && view.physicalSize.height < 700){
    
  }else{
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitDown
    ]);
  }*/

  //await initializeApp(context as BuildContext); // Chiamata alla funzione di inizializzazione

  /*runApp(MaterialApp(
    home: BookTalkApp(),
  ));*/
  runApp(MaterialApp(
    home: await initializeApp(), // Chiamata alla funzione di inizializzazione
  ));

  //extract_text();
}

Future<Widget> initializeApp() async {
  // Ottieni le SharedPreferences
  SharedPreferences preferences = await SharedPreferences.getInstance();

  // Controlla se c'è un utente memorizzato nelle SharedPreferences
  String? utenteJson = preferences.getString('utente');

  if (utenteJson != null && utenteJson.isNotEmpty) {
    print("L'utente è già autenticato");
    Map<String, dynamic> utenteMap = json.decode(utenteJson);

    MonitoraggioStatistiche monitoraggio = MonitoraggioStatistiche.instance;
    UtenteDao dao = UtenteDao('http://130.61.22.178:9000');
    Utente? utente = await dao.getUtenteByEmail(utenteMap['EMAIL']);
    if (utente != null)
      monitoraggio.setUtente(utente);
    else
      print("ERRORE");

    if (utenteMap['ULTFUNZ1'] != null)
      monitoraggio.setFunz1(double.parse(utenteMap['ULTFUNZ1']));
    if (utenteMap['ULTFUNZ2'] != null)
      monitoraggio.setFunz2(double.parse(utenteMap['ULTFUNZ2']));
    if (utenteMap['ULTFUNZ3'] != null)
      monitoraggio.setFunz3(double.parse(utenteMap['ULTFUNZ3']));

    return HomepageResponsitive();
  } else {
    print('Nessun utente memorizzato');
    return BookTalkApp();
  }
}

class BookTalkApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    print(mediaQueryData.size);
    // print(mediaQueryData.size);
    return WillPopScope(
      onWillPop: () async {
        // Restituisci 'false' per impedire la navigazione indietro.
        return false;
      },
      child: MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // ------ LOGO ------
                Image.asset('assets/logo_noSfondo.png',
                    height: logoSize(mediaQueryData.size.width,
                        mediaQueryData.size.height, 0.2)),
                SizedBox(height: isTabletOrizzontale(mediaQueryData) ? 10 : 40),

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
                    fixedSize: MaterialStateProperty.all(Size(
                        buttonWidth(mediaQueryData.size.width,
                            mediaQueryData.size.height),
                        55)),
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xFF1B536E)),
                    textStyle: MaterialStateProperty.all(TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    )),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            20), // Adjust the value as needed
                      ),
                    ),
                  ),
                  child:
                      Text('Registrati', style: TextStyle(color: Colors.white)),
                ),

                SizedBox(
                    height: mediaQueryData.size.height *
                        0.02), // Spazio tra i pulsanti

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
                    fixedSize: MaterialStateProperty.all(Size(
                        buttonWidth(mediaQueryData.size.width,
                            mediaQueryData.size.height),
                        55)),
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xFF0097B2)),
                    textStyle: MaterialStateProperty.all(TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    )),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            20), // Adjust the value as needed
                      ),
                    ),
                  ),
                  child: Text('Login', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
