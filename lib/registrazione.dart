import 'package:flutter/material.dart';
import 'homepage.dart';

class RegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // ------ HEADER ------
      appBar: AppBar(
        leading: BackButton(color: Color(0xFF0099b5)), // freccia indietro
        title: Text('Registrati', style: TextStyle(color: Color(0xFF0099b5), fontWeight: FontWeight.bold,),),
        backgroundColor: Color(0xFFbee2ee),
        elevation: 0.1,
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
                      builder: (context) => Homepage(),
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

          ],
        ),
      ),

    );
  }
}
