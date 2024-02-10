import 'package:booktalk_app/main.dart';
import 'package:booktalk_app/widget/header.dart';
import 'package:flutter/material.dart';
    
class Loading extends StatefulWidget {
  final String text;

  const Loading({Key? key, required this.text}) : super(key: key);

  @override
  _Loading createState() => _Loading();
}

class _Loading extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      left: true,
      right: true,
      bottom: false,
      top: true,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            // ----- HEADER -----
            PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: AppBar(
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
            ),
            Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: mediaQueryData.size.height * 0.15,
              ),
              Text(
                widget.text,
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: mediaQueryData.size.height * 0.15,
              ),
              CircularProgressIndicator(
                color: Color(0xFF0097b2),
              ),
            ],
          ),
          ],
        ),
      ),
    );
  }
}