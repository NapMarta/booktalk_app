import 'package:booktalk_app/main.dart';
import 'package:booktalk_app/profiloResponsive.dart';
import 'package:flutter/material.dart';
import '../utils.dart';
    
class Header extends StatefulWidget {
  const Header({Key? key, 
  required this.text, 
  required this.iconProfile,
  required this.isHomePage,
  required this.isProfilo}) : super(key: key);

  /*
    text - Corrisponde al testo da visuallizzare nell'Header
    iconProfile - Corrisponde all'immage del profilo
    isHomePage - settato a true solo nella homepage, per non visualizzare il pulsante indietro
    isProfilo - settato a true solo nel profilo, per non visualizzare il pulsante profilo ma il logout

    in tutti gli alti casi, entrambi sono true
  */

  final String text;
  final Image iconProfile;  // passsare la foto del profilo dell'utente
  final bool isHomePage, isProfilo;


  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  
  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    
    return AppBar(
      forceMaterialTransparency: true,
      // Pulsante Indietro
      leading:  widget.isHomePage 
        ? null 
        : Transform.scale(
            scale: 0.8,
            child:IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF0097b2),), // Icona personalizzata
              onPressed: () {
                Navigator.of(context).pop(); // Torna indietro alla schermata precedente
              },
              //iconSize: 25,
              // iconSize: iconSize(mediaQueryData.size.width, mediaQueryData.size.height, 0.005),
              
            ),
          ),
      // Testo
      
      automaticallyImplyLeading: !widget.isHomePage, // toglie lo spazio occupoato dall'elemento
      title: Text(
        widget.text,
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: size(mediaQueryData.size.width, mediaQueryData.size.height, 16),
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
      
      // Pulsate Logout/Profilo
      actions: <Widget>[
        Transform.scale(
          scale: 0.6,
          child: Padding(
            padding: EdgeInsets.only(right: 0),
            child:
              widget.isProfilo
              ? 
                // ----- ALLERT CONFERMA LOGOUT -----
                IconButton(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (_) => Dialog(
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Logout',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: size(mediaQueryData.size.width, mediaQueryData.size.height, 20),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              'Sei sicuro di voler fare il logout?',
                              style: TextStyle(fontSize: size(mediaQueryData.size.width, mediaQueryData.size.height, 16)),
                            ),
                            SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Color(0xFF0097b2)),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20), // Adjust the value as needed
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    // Handle logout action
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                      builder: (context) => BookTalkApp(),
                                      ),
                                    ); 
                                  },
                                  child: Text('Logout', style: TextStyle(color: Colors.white)),
                                ),
                                SizedBox(width: 20.0),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); 
                                  },
                                  child: Text('Annulla', style: TextStyle(color: Color(0xFF0097b2))),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ) 
                      ,
                    ),
                  ),
                  icon: Image.asset("assets/logout.png"),
                  iconSize: 0,
                )
              : IconButton(
                icon: widget.iconProfile,
                iconSize: 2,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                    builder: (context) => ProfiloResponsitive(),
                    ),
                  ); 
                },
              ),
          ),
        ),
      ],
      elevation: 0,
    );
  }
}