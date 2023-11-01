import 'package:flutter/material.dart';

class ProfileManagementPage extends StatefulWidget {
  @override
  _ProfileManagementPageState createState() => _ProfileManagementPageState();
}

class _ProfileManagementPageState extends State<ProfileManagementPage> {
  String firstName = 'John';
  String lastName = 'Doe';
  String email = 'johndoe@example.com';
  String password = '********';

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    firstNameController.text = firstName;
    lastNameController.text = lastName;
    emailController.text = email;
    passwordController.text = password;
    super.initState();
  }

  void saveChanges() {
    setState(() {
      firstName = firstNameController.text;
      lastName = lastNameController.text;
      email = emailController.text;
      password = passwordController.text;
    });

    // Salva i dati aggiornati nel tuo database o esegui altre azioni necessarie
  }

  void logout() {
    // Esegui l'operazione di logout, ad esempio, pulendo le informazioni di autenticazione.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // ------ HEADER ------
      appBar: AppBar(
        leading: BackButton(color: Color(0xFF0099b5)), // freccia indietro
        title: Text('Profilo', style: TextStyle(color: Color(0xFF0099b5))),
        backgroundColor: Color(0xFFbee2ee),
        elevation: 0.1,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Color(0xFF0099b5)), //MODIFICARE ICONA
            onPressed: () {
              logout();
              Navigator.of(context).pop(); // Torna alla schermata precedente
            },
          ),
        ],
      ),


      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Nome:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: firstNameController,
              decoration: InputDecoration(
                hintText: 'Inserisci il tuo nome',
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Cognome:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: lastNameController,
              decoration: InputDecoration(
                hintText: 'Inserisci il tuo cognome',
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Email:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Inserisci la tua email',
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Password:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: 'Inserisci la tua password',
              ),
            ),


            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                saveChanges();
                // Puoi aggiungere qui una funzione per salvare le modifiche nel tuo database o backend.
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF0099b5),
              ),
              child: Text('Salva'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ProfileManagementPage(),
  ));
}
