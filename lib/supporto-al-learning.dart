// Importa i pacchetti necessari
/*
import 'package:booktalk_app/libreria-secondafunz.dart';
import 'package:flutter/material.dart';

// Funzione principale dell'app Flutter
void main() => runApp(MyApp());

// Widget principale dell'app
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supporto al Learning',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SupportoAlLearningScreen(),
    );
  }
}

// Widget per la schermata di supporto al learning
class SupportoAlLearningScreen extends StatefulWidget {
  @override
  State createState() => SupportoAlLearningScreenState();
}

// Stato della schermata di supporto al learning
class SupportoAlLearningScreenState extends State<SupportoAlLearningScreen> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       // ------ HEADER ------
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF0097b2),), // Icona personalizzata
            onPressed: () {
              Navigator.of(context).pop(); // Torna indietro alla schermata precedente
            },
          ),  

          title: Text(
            'Supporto al Learning',
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
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: IconButton(
                icon: Image.asset('assets/person-icon.png'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                    ),
                  ); 
                },
              ),
            ),
          ],
        ),
        extendBodyBehindAppBar: true,

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/sfondo.png'), // Sostituisci con il percorso della tua immagine
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 30,),
            // Barra superiore con freccia indietro e titolo
            Row(
              /*mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(); // Torna alla pagina precedente
                    },
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black), // Icona della freccia
                        SizedBox(width: 20,),
                        Text(
                          "Supporto al learning",
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
                      ],
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(),
                        ),
                      ); 
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20, top: 0),
                      child: Image.asset("assets/person-icon.png", width: 32),
                    ),
                  ),
                ],*/
              ),

            // Area di chat
            Expanded(
              child: Container(
                // Implementa la visualizzazione dei messaggi qui
                child: ListView(
                  children: [
                    // Esempio di messaggio in arrivo
                    ChatMessage(
                      message: 'Ciao! Come posso aiutarti oggi?',
                      isSentByMe: false,
                    ),
                    // Esempio di messaggio inviato
                    ChatMessage(
                      message: 'Ciao! Sto avendo un problema con la lezione 3.',
                      isSentByMe: true,
                    ),
                    // Altri messaggi...
                  ],
                ),
              ),
            ),

            // Area con icona del microfono e testo "Parla con BookTalk"
            Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: Color(0xFF0097b2),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.mic),
                      onPressed: () {
                        // Implementa la logica di registrazione vocale qui
                        print('Registrazione vocale...');
                      },
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Parla con BookTalk',
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
                ],
              ),
            ),

            // Area di input del messaggio
            Container(
              padding: EdgeInsets.all(10.0),
              color: Colors.white.withOpacity(0.9),
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LibreriaFunzionzlita(),
                      ),
                  ); 
                      print('Icona del libro premuta!');
                    },
                    child: Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: Color(0xFF0097b2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.menu_book,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Scrivi un messaggio...',
                        prefixIcon: Icon(Icons.keyboard),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      // Implementa la logica di invio
                      print('Invio messaggio...');
                      // Aggiungi il messaggio alla lista dei messaggi
                      // Aggiorna lo stato per riflettere il nuovo messaggio
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget per rappresentare un messaggio nella chat
class ChatMessage extends StatelessWidget {
  final String message;
  final bool isSentByMe;

  ChatMessage({required this.message, required this.isSentByMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          color: isSentByMe ? Color(0xFF0097b2) : Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: EdgeInsets.all(10.0),
        child: Text(
          message,
          style: TextStyle(
            color: isSentByMe ? Colors.white : Colors.black,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
*/