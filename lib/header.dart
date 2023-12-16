import 'package:auto_size_text/auto_size_text.dart';
import 'package:booktalk_app/profilo.dart';
import 'package:flutter/material.dart';
import 'utils.dart';
    
class Header extends StatefulWidget {
  const Header({Key? key, 
  required this.text, 
  required this.iconProfile,
  required this.isHomePage}) : super(key: key);

  final String text;
  final Image iconProfile;  // passsare la foto del profilo dell'utente
  final bool isHomePage;


  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    
    return AppBar(
      forceMaterialTransparency: true,

      leading: widget.isHomePage 
      ? null 
      : IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF0097b2),), // Icona personalizzata
          onPressed: () {
            Navigator.of(context).pop(); // Torna indietro alla schermata precedente
          },
        ),

      automaticallyImplyLeading: !widget.isHomePage, // toglie lo spazio occupoato dall'elemento
      title: Text(
        widget.text,
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: size(mediaQueryData.size.width, mediaQueryData.size.height, 18),
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
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: IconButton(
            icon: widget.iconProfile,
            iconSize: iconSize(mediaQueryData.size.width, mediaQueryData.size.height, 0.005),
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
      elevation: 0,
    );
  }
}