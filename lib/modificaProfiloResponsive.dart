import 'dart:convert';

import 'package:booktalk_app/business_logic/autenticazione.dart';
import 'package:booktalk_app/business_logic/autenticazioneService.dart';
import 'package:booktalk_app/business_logic/registrazione.dart';
import 'package:booktalk_app/business_logic/registrazioneService.dart';
import 'package:booktalk_app/caricamentoResponsive.dart';
import 'package:booktalk_app/profiloResponsive.dart';
import 'package:booktalk_app/storage/utente.dart';
import 'package:booktalk_app/storage/utenteDAO.dart';
import 'package:booktalk_app/utils.dart';
import 'package:booktalk_app/widget/PasswordField.dart';
import 'package:booktalk_app/widget/header.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
    
class ModificaProfiloResponsive extends StatefulWidget {
  const ModificaProfiloResponsive({Key? key}) : super(key: key);

  @override
  _ModificaProfiloResponsiveState createState() => _ModificaProfiloResponsiveState();
}

class _ModificaProfiloResponsiveState extends State<ModificaProfiloResponsive> {

  String firstName = '';
  String lastName = '';
  String email = '';
  String password = '';
  late SharedPreferences _preferences;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final RegistrazioneService registrazione = Registrazione('http://130.61.22.178:9000');
  final AutenticazioneService autenticazione = Autenticazione('http://130.61.22.178:9000');
  late Future<Utente?> utente;


  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordNuovaController =  TextEditingController();
  TextEditingController passwordAttualeController =  TextEditingController();
  //TextEditingController passwordController= TextEditingController();

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Inserisci una password';
    } else if (value.length < 6) {
      //mostraErrore(context, 'La password deve essere lunga almeno 6 caratteri');
      return 'La password deve essere lunga almeno 6 caratteri';
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


  void modificaOK(BuildContext context, String messaggio) {
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
  void initState() {
    _loadUserData();
    super.initState();
  }

    // Funzione per caricare i dati dell'utente dalle SharedPreferences
  Future<void> _loadUserData() async {
    print("Loading user data...");
    _preferences = await SharedPreferences.getInstance();
    String utenteJson = _preferences.getString('utente') ?? '';
    if (utenteJson.isNotEmpty) {
      Map<String, dynamic> utenteMap = json.decode(utenteJson);
      firstName = utenteMap['NOME'] ?? '';
      lastName = utenteMap['COGNOME'] ?? '';
      firstNameController.text = firstName;
      lastNameController.text = lastName;
      UtenteDao dao = UtenteDao('http://130.61.22.178:9000');
      print(utenteMap);
      utente = dao.getUtenteByEmail(utenteMap['EMAIL']);
      utente.then((value) => print(value.toString()));
      setState(() {});
    }
  }

  void saveChanges() {
    setState(() {
      firstName = firstNameController.text;
      lastName = lastNameController.text;
      //password = passwordController.text;
    });

    // Salvare i dati aggiornati nel db
  }


  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      left: true,
      right: true,
      bottom: false,
      top: true,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/sfondo2.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Scaffold(
          // ----- HEADER -----
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: Header(
                iconProfile: Image.asset('assets/person-icon.png'), 
                text: "Modifica i tuoi dati",
                isHomePage: false,
                isProfilo: false,
              ),
            ),
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Container(
              padding: EdgeInsets.only(left: textFieldPadding(mediaQueryData.size.width, mediaQueryData.size.height), 
                                      right: textFieldPadding(mediaQueryData.size.width, mediaQueryData.size.height),
                                      top: mediaQueryData.size.height * 0.02,
                                      bottom: MediaQuery.of(context).viewInsets.bottom,),
              child: Form (
                key: _formKey,
                
                child: Column(
                  children: <Widget>[
                    SizedBox(height: isTabletOrizzontale(mediaQueryData) ? 10 : 80,),
                    // ----- NOME -----
                    TextFormField(
                      controller: firstNameController,
                      restorationId: 'nome_field',
                      textInputAction: TextInputAction.next,
                      focusNode: FocusNode(),
                      decoration: InputDecoration(
                        fillColor: const Color.fromARGB(123, 255, 255, 255),
                        // focusColor: Color(0xFF0097b2),
                        labelText: 'Nome', 
                        labelStyle: TextStyle(fontSize: 16, 
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
                        prefixIcon: Icon(Icons.person, color: Colors.grey,),
                        /* hintText: localizations.demoTextFieldYourEmailAddress,
                        labelText: localizations.demoTextFieldEmail, */
                      ),
                      keyboardType: TextInputType.name,
                      validator: validateNome,
                      
                    ),

                    SizedBox(height: 20,),

                    // ----- COGNOME -----
                    TextFormField(
                      controller: lastNameController,
                      restorationId: 'cognome_field',
                      textInputAction: TextInputAction.next,
                      focusNode: FocusNode(),
                      decoration: InputDecoration(
                        fillColor: const Color.fromARGB(123, 255, 255, 255),
                        // focusColor: Color(0xFF0097b2),
                        labelText: 'Cognome', 
                        labelStyle: TextStyle(fontSize: 16, 
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
                        prefixIcon: Icon(Icons.person, color: Colors.grey,),
                        /* hintText: localizations.demoTextFieldYourEmailAddress,
                        labelText: localizations.demoTextFieldEmail, */
                      ),
                      keyboardType: TextInputType.name,
                      validator: validateCognome,
                      
                    ),

                    SizedBox(height: 20,),

                    // --- L'EMAIL NON E' MODIFICABILE ---

                    // ----- PASSWORD ATTUALE----- 
                    PasswordField(
                      restorationId: 'password_attuale_field',
                      controller: passwordAttualeController,
                      textInputAction: TextInputAction.next,
                      focusNode: FocusNode(),
                      width: mediaQueryData.size.width,
                      height: mediaQueryData.size.height,
                      text: "Password attuale",
                      validator: validatePassword,
                    ),

                    SizedBox(height: 20,),

                    // ----- NUOVA PASSWORD ----- 
                    PasswordField(
                      restorationId: 'nuova_password_field',
                      controller: passwordNuovaController,
                      textInputAction: TextInputAction.next,
                      focusNode: FocusNode(),
                      width: mediaQueryData.size.width,
                      height: mediaQueryData.size.height,
                      text: "Nuova Password",
                      validator: validatePassword,
                    ),

                    SizedBox(height: 20,),

                    // ----- CONFERMA -----
                    ElevatedButton(
                        onPressed: () async{
                          if (_formKey.currentState!.validate()){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CaricamentoResponsive(text: "Aggiornamento dei dati in corso...")),
                            );

                            String passwordAttuale = passwordAttualeController.text;
                            String passwordNuova = passwordNuovaController.text;
                          
                            utente.then((utente) async {
                              final validationError = registrazione.validateParametersModifica(
                                utente!, firstNameController.text, lastNameController.text, passwordAttuale, passwordNuova,
                              );

                              if (validationError.isNotEmpty) {
                                Navigator.pop(context); 
                                mostraErrore(context, validationError['error']);
                                print(validationError['error']);
                                return;
                              }

                              // Effettua la modifica
                              utente.nome= firstNameController.text;
                              utente.cognome = lastNameController.text;
                              utente.password= passwordNuova;
                              final risultato = await registrazione.modificaUtente(
                                utente);

                              if (risultato.containsKey('success')) {
                                
                                // Se la modifica è avvenuta con successo
                                modificaOK(context, risultato['success']);
                                Navigator.pop(context); 
                                Navigator.of(context).popUntil((route) => route.isFirst);
                                    
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => ProfiloResponsitive(),
                                  )
                                ); 
                              } else if (risultato.containsKey('error')) {
                                // Se c'è stato un errore durante la modifica
                                Navigator.pop(context); 
                                mostraErrore(context, risultato['error']);
                              }
                              print(risultato);    
                            });
                          }
                        },
                        
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(Size(buttonWidth(mediaQueryData.size.width, mediaQueryData.size.height), 55)),
                          backgroundColor: MaterialStateProperty.all(Color(0xFF0097b2)),
                          textStyle: MaterialStateProperty.all(TextStyle(fontSize: 15, fontWeight: FontWeight.bold,)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20), // Adjust the value as needed
                            ),
                          ),
                        ),
                        child: Text('Conferma', style: TextStyle(color: Colors.white)),
                      ),

                      SizedBox(height: 30,),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}