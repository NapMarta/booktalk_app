import 'package:booktalk_app/loginResponsive.dart';
import 'package:booktalk_app/widget/PasswordField.dart';
import 'package:booktalk_app/utils.dart';
import 'business_logic/registrazioneService.dart';
import 'business_logic/registrazione.dart';
import 'storage/utente.dart';
import 'package:flutter/material.dart';

class RegistrazioneResponsive extends StatefulWidget {
  const RegistrazioneResponsive({Key? key}) : super(key: key);

  @override
  _RegistrazioneResponsiveState createState() => _RegistrazioneResponsiveState();
}

class _RegistrazioneResponsiveState extends State<RegistrazioneResponsive> {
  final RegistrazioneService registrazione = Registrazione('http://130.61.22.178:9000');

  TextEditingController nomeController = TextEditingController();
  TextEditingController cognomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confermaPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FocusNode email = FocusNode();

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      //mostraErrore(context, 'Inserisci una password');
      return 'Inserisci una password';
    } else if (value.length < 6) {
      //mostraErrore(context, 'La password deve essere lunga almeno 6 caratteri');
      return 'La password deve essere lunga almeno 6 caratteri';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      //mostraErrore(context, 'Inserisci un indirizzo email');
      return 'Inserisci un indirizzo email';
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(value)) {
      //mostraErrore(context, 'Inserisci un indirizzo email valido');
      return 'Inserisci un indirizzo email valido';
    }
    return null;
  }

  String? validateNome(String? value) {
    if (value == null || value.isEmpty) {
      //mostraErrore(context, 'Inserisci un nome');
      return 'Inserisci un nome';
    }
    return null;
  }

  String? validateCognome(String? value) {
    if (value == null || value.isEmpty) {
      //mostraErrore(context, 'Inserisci un cognome');
      return 'Inserisci un cognome';
    }
    return null;
  }

  String? validateConfermaPassword(String? value) {
    if (value == null || value.isEmpty) {
      //mostraErrore(context, 'Conferma la password');
      return 'Conferma la password';
    } else if (value != passwordController.text) {
      //mostraErrore(context, 'Le password inserite non corrispondono');
      return 'Le password inserite non corrispondono';
    }
    return null;
  }

  
  void mostraErrore(BuildContext context, String messaggio) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.red, // Colore dell'icona
          ),
          SizedBox(width: 8), // Spazio tra l'icona e il testo
          Expanded(
            child: Text(
              messaggio,
              style: TextStyle(
                color: Colors.red, // Colore del testo
                fontWeight: FontWeight.bold, // Grassetto
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white, // Colore di sfondo
      duration: Duration(seconds: 3), // Durata del messaggio
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void registrazioneOK(BuildContext context, String messaggio) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(
            Icons.verified,
            color: Colors.green, // Colore dell'icona
          ),
          SizedBox(width: 8), // Spazio tra l'icona e il testo
          Expanded(
            child: Text(
              messaggio,
              style: TextStyle(
                color: Colors.green, // Colore del testo
                fontWeight: FontWeight.bold, // Grassetto
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white, // Colore di sfondo
      duration: Duration(seconds: 3), // Durata del messaggio
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Transform.scale(
          scale: 0.8,
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Color(0xFF0097b2),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        title: Text(
          "Registrazione",
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 18,
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
        padding: EdgeInsets.only(
          left: textFieldPadding(mediaQueryData.size.width, mediaQueryData.size.height),
          right: textFieldPadding(mediaQueryData.size.width, mediaQueryData.size.height),
          top: mediaQueryData.size.height * 0.02,
          bottom: mediaQueryData.size.height * 0.05,
        ),
        child: Form( 
          key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/logo_noSfondo.png', height: logoSize(mediaQueryData.size.width, mediaQueryData.size.height, 0.2)),
            SizedBox(height: isTabletOrizzontale(mediaQueryData) ? 10 : 30),
            TextFormField(
              controller: nomeController,
              restorationId: 'nome_field',
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                fillColor: Colors.white,
                labelText: 'Nome',
                labelStyle: TextStyle(fontSize: 16, color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1.5,
                  ),
                ),
                filled: true,
                prefixIcon: Icon(Icons.person, color: Colors.grey),
              ),
              keyboardType: TextInputType.name,
              validator: validateNome,
            ),
            SizedBox(height: 20,),
            TextFormField(
              controller: cognomeController,
              restorationId: 'cognome_field',
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                fillColor: Colors.white,
                labelText: 'Cognome',
                labelStyle: TextStyle(fontSize: 16, color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1.5,
                  ),
                ),
                filled: true,
                prefixIcon: Icon(Icons.person, color: Colors.grey),
              ),
              keyboardType: TextInputType.name,
              validator: validateCognome,
            ),
            SizedBox(height: 20,),
            TextFormField(
              controller: emailController,
              restorationId: 'email_field',
              textInputAction: TextInputAction.next,
              focusNode: email,
              decoration: InputDecoration(
                fillColor: Colors.white,
                labelText: 'Email',
                labelStyle: TextStyle(fontSize: 16, color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1.5,
                  ),
                ),
                filled: true,
                prefixIcon: Icon(Icons.email, color: email.hasFocus ? Color(0xFF0097b2) : Colors.grey),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: validateEmail,
            ),
            SizedBox(height: 20,),
            PasswordField(
              controller: passwordController,
              restorationId: 'password_field',
              textInputAction: TextInputAction.next,
              width: mediaQueryData.size.width,
              height: mediaQueryData.size.height,
              text: "Password",
              validator: validatePassword,
            ),
            SizedBox(height: 20,),
            PasswordField(
              controller: confermaPasswordController,
              restorationId: 'ripeti_password_field',
              textInputAction: TextInputAction.next,
              width: mediaQueryData.size.width,
              height: mediaQueryData.size.height,
              text: "Conferma Password",
              validator: validateConfermaPassword,
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()){
                  final validationError = registrazione.validateParameters(
                    Utente(
                      nome: nomeController.text,
                      cognome: cognomeController.text,
                      email: emailController.text,
                      password: passwordController.text,
                    ),
                    confermaPasswordController.text,
                  );

                  if (validationError.isNotEmpty) {
                    mostraErrore(context, validationError['error']);
                    print(validationError['error']);
                    return;
                  }

                  // Effettua la registrazione
                  final risultato = await registrazione.registrati(
                    Utente(
                      nome: nomeController.text,
                      cognome: cognomeController.text,
                      email: emailController.text,
                      password: passwordController.text,
                    ),
                    confermaPasswordController.text
                  );


                  if (risultato.containsKey('success')) {
                    // Se la registrazione è avvenuta con successo
                    registrazioneOK(context, risultato['success']);
                    Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => LoginResponsive(),
                        ),
                    ); 
                  } else if (risultato.containsKey('error')) {
                    // Se c'è stato un errore durante la registrazione
                    mostraErrore(context, risultato['error']);
                  }
                  print(risultato);
                }
              },
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(Size(buttonWidth(mediaQueryData.size.width, mediaQueryData.size.height), 55)),
                backgroundColor: MaterialStateProperty.all(Color(0xFF1B536E)),
                textStyle: MaterialStateProperty.all(TextStyle(fontSize: 15, fontWeight: FontWeight.bold,)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              child: Text('Registrati', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
        ),
      ),
    );
  }
}
