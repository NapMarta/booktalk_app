import 'package:booktalk_app/main.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';

class ProfileManagementPage extends StatefulWidget {
  @override
  _ProfileManagementPageState createState() => _ProfileManagementPageState();
}

class _ProfileManagementPageState extends State<ProfileManagementPage> {
  String firstName = 'Maria';
  String lastName = 'Rossi';
  String email = 'email@example.com';
  String password = 'password';

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

    // Salvare i dati aggiornati nel db
  }

  void logout() {
    // Eseguire l'operazione di logout.
    Navigator.of(context).push(
      MaterialPageRoute(
      builder: (context) => BookTalkApp(),
      ),
    ); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // ------ HEADER ------
      appBar: AppBar(
        leading: IconButton(
              icon: Icon(Icons.home, color: Color(0xFF0099b5)),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Homepage(),
                    ),
                ); 
              },
            ),  
        title: Text('Modifica profilo', style: TextStyle(color: Color(0xFF0099b5), fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFFbee2ee),
        elevation: 0.1,
        actions: <Widget>[
          TextButton(
            onPressed: () {
              logout();
            },
            child: Row(
              children: [
                Text('Logout', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF0099b5))),
                Icon(Icons.logout)  
              ],
            ),
          )
        ],
      ),


      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(right: 16.0, left: 16.0, top: 60.0, bottom: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Column(
                  children: [
                    Image.asset('assets/person-icon.png', width: 150, height: 150),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              
              // ------ NOME ------
              Text(
                'Nome:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: firstNameController,
                decoration: InputDecoration(
                  hintText: 'Inserisci il tuo nome',
                  border: OutlineInputBorder(), 
                  prefixIcon: Icon(Icons.person)
                ),
              ),
              SizedBox(height: 16.0),

              // ------ COGNOME ------
              Text(
                'Cognome:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: lastNameController,
                decoration: InputDecoration(
                  hintText: 'Inserisci il tuo cognome',
                  border: OutlineInputBorder(), 
                  prefixIcon: Icon(Icons.person)
                ),
              ),

              // ------ EMAIL ------
              SizedBox(height: 16.0),
              Text(
                'Email:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Inserisci la tua email',
                  border: OutlineInputBorder(), 
                  prefixIcon: Icon(Icons.email)
                ),
              ),
              SizedBox(height: 16.0),

              // ------ PASSWORD ATTUALE ------
              Text(
                'Password attuale:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(hintText: 'Password', border: OutlineInputBorder(), prefixIcon: Icon(Icons.lock)),
                obscureText: true, // Per nascondere la password
              ),
              SizedBox(height: 10),

              // ------ PASSWORD NUOVA ------
              Text(
                'Nuova password:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextField(
                decoration: InputDecoration(hintText: 'Password', border: OutlineInputBorder(), prefixIcon: Icon(Icons.lock)),
                obscureText: true, // Per nascondere la password
              ),
              SizedBox(height: 10),

              // ------ CONFERMA PASSWORD ------
              Text(
                'Conferma password:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextField(
                decoration: InputDecoration(hintText: 'Password', border: OutlineInputBorder(), prefixIcon: Icon(Icons.lock)),
                obscureText: true, // Per nascondere la password
              ),
              SizedBox(height: 10),

              Center(
                child: Column(
                  children: [
                    SizedBox(height: 32.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center, // Centra i bottoni orizzontalmente
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            saveChanges();
                            // Salvare le modifiche nel database
                          },
                          style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all(Size(150, 50)),
                            backgroundColor: MaterialStateProperty.all(Color(0xFF0099b5)),
                            textStyle: MaterialStateProperty.all(TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                          child: Text('Ripristina'),
                        ),
                        SizedBox(width: 30.0),
                        ElevatedButton(
                          onPressed: () {
                            // Ripristinare
                          },
                          style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all(Size(150, 50)),
                            backgroundColor: MaterialStateProperty.all(Color(0xFF087B69)),
                            textStyle: MaterialStateProperty.all(TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                          child: Text('Salva'),
                        ),
                      ],
                    ),
                  ],
                ),
              )

            ],
          ),
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
