import 'package:booktalk_app/profiloResponsive.dart';
import 'package:booktalk_app/utils.dart';
import 'package:booktalk_app/widget/PasswordField.dart';
import 'package:booktalk_app/widget/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
    
class ModificaProfiloResponsive extends StatefulWidget {
  const ModificaProfiloResponsive({Key? key}) : super(key: key);

  @override
  _ModificaProfiloResponsiveState createState() => _ModificaProfiloResponsiveState();
}

class _ModificaProfiloResponsiveState extends State<ModificaProfiloResponsive> {

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


  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    FocusNode email = FocusNode();

    return SafeArea(
      left: true,
      right: true,
      bottom: false,
      top: true,
      child: Scaffold(
        resizeToAvoidBottomInset: false, 
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/sfondo2.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              // ----- Header -----
              PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight),
                child: Header(
                  iconProfile: Image.asset('assets/person-icon.png'), 
                  text: "Modifica i tuoi dati",
                  isHomePage: false,
                  isProfilo: true,
                ),
              ),
              
              // ----- Campi contenenti i dati -----
              SingleChildScrollView(
                child: Container(
                padding: EdgeInsets.only(left: textFieldPadding(mediaQueryData.size.width, mediaQueryData.size.height), 
                                        right: textFieldPadding(mediaQueryData.size.width, mediaQueryData.size.height),
                                        top: mediaQueryData.size.height * 0.02,
                                        bottom: MediaQuery.of(context).viewInsets.bottom,),
                
                child: Column(
                children: <Widget>[
                  SizedBox(height: 80,),
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
                      labelStyle: TextStyle(fontSize: size(mediaQueryData.size.width, mediaQueryData.size.height, 16), 
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
                      labelStyle: TextStyle(fontSize: size(mediaQueryData.size.width, mediaQueryData.size.height, 16), 
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
                    
                  ),

                  SizedBox(height: 20,),

                  // ----- EMAIL -----
                  TextFormField(
                    controller: emailController,
                    restorationId: 'email_field',
                    textInputAction: TextInputAction.next,
                    focusNode: email,
                    decoration: InputDecoration(
                      fillColor: const Color.fromARGB(123, 255, 255, 255),
                      // focusColor: Color(0xFF0097b2),
                      labelText: 'Email', 
                      labelStyle: TextStyle(fontSize: size(mediaQueryData.size.width, mediaQueryData.size.height, 16), 
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
                      prefixIcon: Icon(Icons.email, color: email.hasFocus ? Color(0xFF0097b2) : Colors.grey,),
                      /* hintText: localizations.demoTextFieldYourEmailAddress,
                      labelText: localizations.demoTextFieldEmail, */
                    ),
                    keyboardType: TextInputType.emailAddress,
                    
                  ),

                  SizedBox(height: 20,),

                  // ----- PASSWORD ----- 
                  PasswordField(
                    restorationId: 'password_field',
                    textInputAction: TextInputAction.next,
                    focusNode: FocusNode(),
                    width: mediaQueryData.size.width,
                    height: mediaQueryData.size.height,
                    text: "Password",
                  ),

                  SizedBox(height: 20,),

                  // ----- RIPETI PASSWORD ----- 
                  PasswordField(
                    restorationId: 'ripeti_password_field',
                    textInputAction: TextInputAction.next,
                    focusNode: FocusNode(),
                    width: mediaQueryData.size.width,
                    height: mediaQueryData.size.height,
                    text: "Conferma Password"
                  ),

                  SizedBox(height: 20,),

                  // ----- CONFERMA -----
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProfiloResponsitive(),
                          ),
                        );
                      },
                      
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(Size(buttonWidth(mediaQueryData.size.width, mediaQueryData.size.height), 55)),
                        backgroundColor: MaterialStateProperty.all(Color(0xFF0097b2)),
                        textStyle: MaterialStateProperty.all(TextStyle(fontSize: size(mediaQueryData.size.width, mediaQueryData.size.height, 16), fontWeight: FontWeight.bold,)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20), // Adjust the value as needed
                          ),
                        ),
                      ),
                      child: Text('Conferma'),
                    ),
                ],
                ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}