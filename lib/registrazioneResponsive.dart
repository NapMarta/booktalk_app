import 'package:booktalk_app/widget/PasswordField.dart';
import 'package:booktalk_app/homepageResponsive.dart';
import 'package:booktalk_app/utils.dart';
import 'package:flutter/material.dart';
    
class RegistrazioneResponsive extends StatefulWidget {
  const RegistrazioneResponsive({Key? key}) : super(key: key);

  @override
  _RegistrazioneResponsiveState createState() => _RegistrazioneResponsiveState();
}

class _RegistrazioneResponsiveState extends State<RegistrazioneResponsive> {
  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    FocusNode email = FocusNode();

    return Scaffold(
      backgroundColor: Colors.white,

      // ----- HEADER -----
      appBar: AppBar(
        
        leading: Transform.scale(
          scale: 0.8,
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF0097b2),), // Icona personalizzata
            onPressed: () {
              Navigator.of(context).pop(); // Torna indietro alla schermata precedente
            },
            //iconSize: 25,
            // iconSize: iconSize(mediaQueryData.size.width, mediaQueryData.size.height, 0.005),
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
        
        // per non impostare lo sfondo di default
        backgroundColor: Color.fromARGB(0, 255, 255, 255),
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: textFieldPadding(mediaQueryData.size.width, mediaQueryData.size.height), 
                                right: textFieldPadding(mediaQueryData.size.width, mediaQueryData.size.height),
                                top: mediaQueryData.size.height * 0.02,
                                bottom: mediaQueryData.size.height * 0.05,),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            // ----- LOGO -----
            Image.asset('assets/logo_noSfondo.png', height: logoSize(mediaQueryData.size.width, mediaQueryData.size.height, 0.2)),
            SizedBox(height: isTabletOrizzontale(mediaQueryData) ? 10 : 30),

            // ----- NOME -----
            TextFormField(
              restorationId: 'nome_field',
              textInputAction: TextInputAction.next,
              focusNode: FocusNode(),
              decoration: InputDecoration(
                fillColor: Colors.white,
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
              
            ),

            SizedBox(height: 20,),

            // ----- COGNOME -----
            TextFormField(
              restorationId: 'cognome_field',
              textInputAction: TextInputAction.next,
              focusNode: FocusNode(),
              decoration: InputDecoration(
                fillColor: Colors.white,
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
              
            ),

            SizedBox(height: 20,),

            // ----- EMAIL -----
            TextFormField(
              restorationId: 'email_field',
              textInputAction: TextInputAction.next,
              focusNode: email,
              decoration: InputDecoration(
                fillColor: Colors.white,
                // focusColor: Color(0xFF0097b2),
                labelText: 'Email', 
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

            // ----- REGISTRATI -----
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HomepageResponsitive(),
                    ),
                  );
                },
                
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(Size(buttonWidth(mediaQueryData.size.width, mediaQueryData.size.height), 55)),
                  backgroundColor: MaterialStateProperty.all(Color(0xFF1B536E)),
                  textStyle: MaterialStateProperty.all(TextStyle(fontSize: 15, fontWeight: FontWeight.bold,)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // Adjust the value as needed
                    ),
                  ),
                ),
                child: Text('Registrati', style: TextStyle(color: Colors.white)),
              ),           

          ]
        ),
      ),
    );
  }
}