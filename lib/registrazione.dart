import 'package:booktalk_app/homepageResponsive.dart';
import 'package:flutter/material.dart';


class RegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ------ HEADER ------
      /*appBar: AppBar(
        leading: BackButton(color: Color(0xFF0099b5)), // freccia indietro
        title: Text('Registrati', style: TextStyle(color: Color(0xFF0099b5), fontWeight: FontWeight.bold,),),
        backgroundColor: Color(0xFFbee2ee),
        elevation: 0.1,
      ),*/

      // ------ HEADER ------
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF0097b2),), // Icona personalizzata
            onPressed: () {
              Navigator.of(context).pop(); // Torna indietro alla schermata precedente
            },
          ), 
          title: Text(
            'Registrati',
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
          elevation: 0,
        ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 80, right: 20, left: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Image.asset('assets/person-icon.png', width: 150, height: 150),
            SizedBox(height: 20),
            
            // ------ NOME ------
            TextField(
              decoration: InputDecoration(labelText: 'Nome', border: OutlineInputBorder(), prefixIcon: Icon(Icons.person)),
            ),
            SizedBox(height: 10),

            // ------ COGNOME ------
            TextField(
              decoration: InputDecoration(labelText: 'Cognome', border: OutlineInputBorder(), prefixIcon: Icon(Icons.person)),
            ),
            SizedBox(height: 10),

            // ------ EMAIL ------
            TextField(
              decoration: InputDecoration(labelText: 'Email', border: OutlineInputBorder(), prefixIcon: Icon(Icons.email)),
            ),
            SizedBox(height: 10),

            // ------ PASSWORD ------
            TextField(
              decoration: InputDecoration(labelText: 'Password', border: OutlineInputBorder(), prefixIcon: Icon(Icons.lock)),
              obscureText: true, // Per nascondere la password
            ),
            SizedBox(height: 10),

            // ------ CONFERMA PASSWORD ------
            TextField(
              decoration: InputDecoration(labelText: 'Conferma Password', border: OutlineInputBorder(), prefixIcon: Icon(Icons.lock)),
              obscureText: true, // Per nascondere la password
            ),
            SizedBox(height: 20),

            // ------ Pulsante "Registrati" ------
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HomepageResponsitive(),
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

          ],
        ),
      ),

    );
  }
}
