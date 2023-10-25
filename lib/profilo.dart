import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // ------ HEADER ------
      appBar: AppBar(
        leading: BackButton(color: Color(0xFF0099b5)), // freccia indietro
        title: Image.asset('assets/BookTalk-scritta.png', width: 150),
        backgroundColor: Color(0xFFbee2ee),
        elevation: 0.1,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Color(0xFF0099b5), size: 30,),
            onPressed: () {
              // Eseguire il logout
            },
          ),
        ],
      ),


      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[

          // ------ SALUTO ------
          Container(
            padding: EdgeInsets.only(top: 100.0, bottom: 100),
            child: Center(
              child: Text(
                'Ciao Nome e Cognome',
                style: TextStyle(fontSize: 30, color: Color(0xFF0099b5)),
              ),
            ),
          ),


          // ------ LIBRERIA ------
          Container(
            padding: EdgeInsets.only(bottom: 20),
            child: Center(
              child: Text(
                'Libreria',
                style: TextStyle(fontSize: 25, color: Color(0xFF0099b5)),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                ListTile(title: Text('Libro 1')),
                ListTile(title: Text('Libro 2')),
                // Aggiungi qui gli altri elementi della lista
              ],
            ),
          ),


          // ------ FOOTER ------
          Container(
            color: Color(0xFFbee2ee),
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                // ------ FUNZIONALITA' 1 ------
                GestureDetector(
                  onTap: () {
                    // Azione da eseguire quando si fa clic sull'icona 1
                  },
                  child: Image.asset("assets/icona-1.png", width: 50, height: 50,),
                ),

                // ------ FUNZIONALITA' 2 ------
                GestureDetector(
                  onTap: () {
                    // Azione da eseguire quando si fa clic sull'icona 2
                  },
                  child: Image.asset("assets/icona-2.png", width: 50, height: 50,),
                ),

                // ------ FUNZIONALITA' 3 ------
                GestureDetector(
                  onTap: () {
                    // Azione da eseguire quando si fa clic sull'icona 3
                  },
                  child: Image.asset("assets/icona-3.png", width: 50, height: 50,),
                ),


              ],
            ),
          ),

        ],
      ),
    );
  }
}
