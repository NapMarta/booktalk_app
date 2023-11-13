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
      extendBodyBehindAppBar: true,

      // ------ HEADER ------
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF0099b5),), // Icona personalizzata
            onPressed: () {
              Navigator.of(context).pop(); // Torna indietro alla schermata precedente
            },
          ),          
          title: Text(
            'Modifica profilo',
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
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/sfondo.png"),
              fit: BoxFit.cover,
            ),
          ),
        child: Padding(
          padding: EdgeInsets.only(right: 16.0, left: 16.0, top: 40.0, bottom: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(); // Torna alla pagina precedente
                  },
                  child: Row(
                    children: [
                      /*Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black), // Icona della freccia
                      SizedBox(width: 20,),
                      Text(
                        "Modifica Profilo",
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
                      ),*/
                    ],
                  ),
                ),
              Center(
                child: Column(
                  children: [
                    SizedBox(height: 60,),
                    Image.asset('assets/person-icon.png', width: 120),
                    SizedBox(height: 10),
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
                  prefixIcon: Icon(Icons.person),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8),
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
                  prefixIcon: Icon(Icons.person),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8)
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
                  prefixIcon: Icon(Icons.email),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8)
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
                decoration: InputDecoration(hintText: 'Password', border: OutlineInputBorder(), prefixIcon: Icon(Icons.lock), filled: true,
                  fillColor: Colors.white.withOpacity(0.8)),
                obscureText: true, // Per nascondere la password
                
              ),
              SizedBox(height: 10),

              // ------ PASSWORD NUOVA ------
              Text(
                'Nuova password:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextField(
                decoration: InputDecoration(hintText: 'Password', border: OutlineInputBorder(), prefixIcon: Icon(Icons.lock), filled: true,
                  fillColor: Colors.white.withOpacity(0.8)),
                obscureText: true, // Per nascondere la password
              ),
              SizedBox(height: 10),

              // ------ CONFERMA PASSWORD ------
              Text(
                'Conferma password:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextField(
                decoration: InputDecoration(hintText: 'Password', border: OutlineInputBorder(), prefixIcon: Icon(Icons.lock), filled: true,
                  fillColor: Colors.white.withOpacity(0.8)),
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
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ProfileManagementPage(),
  ));
}
