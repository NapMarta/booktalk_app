import 'package:booktalk_app/business_logic/autenticazione.dart';
import 'package:booktalk_app/business_logic/autenticazioneService.dart';
import 'package:booktalk_app/main.dart';
import 'package:booktalk_app/storage/utenteDAO.dart';
import 'package:booktalk_app/widget/PasswordField.dart';
import 'package:booktalk_app/homepageResponsive.dart';
import 'package:booktalk_app/registrazioneResponsive.dart';
import 'package:booktalk_app/utils.dart';
import 'package:flutter/material.dart';
    
class LoginResponsive extends StatefulWidget {
  const LoginResponsive({Key? key}) : super(key: key);

  @override
  _LoginResponsiveState createState() => _LoginResponsiveState();
}

class _LoginResponsiveState extends State<LoginResponsive> {
    FocusNode email = FocusNode();
    final AutenticazioneService autenticazione = Autenticazione('http://130.61.22.178:9000');
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

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

    void autenticazioneOK(BuildContext context, String messaggio) {
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
    return WillPopScope(
      onWillPop: () async {
        // Restituisci 'false' per impedire la navigazione indietro.
        return false;
      },
    child: Scaffold(
      backgroundColor: Colors.white,

      // ----- HEADER -----
      appBar: AppBar(
        
        leading: Transform.scale(
          scale: 0.8,
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF0097b2),), // Icona personalizzata
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BookTalkApp(),
                ),
              ); 
            },
            //iconSize: 25,
            // iconSize: iconSize(mediaQueryData.size.width, mediaQueryData.size.height, 0.005),
          ),
        ),
        
        title: Text(
          "Login",
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
        
        // per non impostare lo sfondo di default
        backgroundColor: Color.fromARGB(0, 255, 255, 255),
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: textFieldPadding(mediaQueryData.size.width, mediaQueryData.size.height), 
                                right: textFieldPadding(mediaQueryData.size.width, mediaQueryData.size.height),
                                top: mediaQueryData.size.height * 0.10,
                                bottom: mediaQueryData.size.height * 0.05),
        child: Form( 
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              // ----- LOGO -----
              Image.asset('assets/logo_noSfondo.png', height: logoSize(mediaQueryData.size.width, mediaQueryData.size.height, 0.15)),
              SizedBox(height: isTabletOrizzontale(mediaQueryData) ? 6 : 40),

              // ----- EMAIL -----
              TextFormField(
                controller: emailController,
                validator: validateEmail,
                restorationId: 'email_field',
                textInputAction: TextInputAction.next,
                focusNode: email,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  // focusColor: Color(0xFF0097b2),
                  labelText: 'Email', 
                  labelStyle: TextStyle(fontSize:  16, 
                                        color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.5,
                    )
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.5,
                    ),
                  ),
                  filled: true,
                  prefixIcon: Icon(Icons.email, color: Colors.grey,),
                  /* hintText: localizations.demoTextFieldYourEmailAddress,
                  labelText: localizations.demoTextFieldEmail, */
                ),
                keyboardType: TextInputType.emailAddress,
                
              ),

              SizedBox(height: 20,),

              // ----- PASSWORD ----- 
              PasswordField(
                controller: passwordController,
                validator: validatePassword,
                restorationId: 'password_field',
                textInputAction: TextInputAction.next,
                //focusNode: FocusNode(),
                width: mediaQueryData.size.width,
                height: mediaQueryData.size.height,
                text: "Password",
              ),

              SizedBox(height: 20,),

              // ----- ACCEDI -----
              ElevatedButton(
                  onPressed: () async{
                    if (_formKey.currentState!.validate()){
                      final validationError = autenticazione.validateParameters(
                        emailController.text, passwordController.text
                      );

                      if (validationError.isNotEmpty) {
                        mostraErrore(context, validationError['error']);
                        print(validationError['error']);
                        return;
                      }

                      // Effettua il login
                      final risultato = await autenticazione.login(
                        emailController.text, passwordController.text
                      );


                      if (risultato.containsKey('success')) {
                        // Se il login è avvenutocon successo
                        autenticazioneOK(context, risultato['success']);
                        Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => HomepageResponsitive(),
                            ),
                        ); 
                      } else if (risultato.containsKey('error')) {
                        // Se c'è stato un errore durante il login
                        mostraErrore(context, risultato['error']);
                      }
                      print(risultato);
                    }
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
                  child: Text('Accedi', style: TextStyle(color: Colors.white)),
                ),

              SizedBox(height: mediaQueryData.size.height * 0.05,),
              
              // ----- Registrati -----
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RegistrazioneResponsive(),
                    ));
                  },
                  child: RichText(
                    text: TextSpan(
                      text: 'Non sei ancora registrato? ',
                      style: TextStyle(color: Colors.black,
                                      fontSize: 14),
                      children: [
                        TextSpan(
                          text: 'Registrati ora',
                          style: TextStyle(
                            color: Color(0xFF0097b2),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            ]
          ),
        ),
      ),
    ),
    );
  }
}