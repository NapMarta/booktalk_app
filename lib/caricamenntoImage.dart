import 'dart:convert';
import 'dart:io';

import 'package:booktalk_app/opera.dart';
import 'package:booktalk_app/storage/libro.dart';
import 'package:booktalk_app/widget/header.dart';
import 'package:flutter/material.dart';

class CaricamentoImage extends StatefulWidget {
  final String text;
  final File? image;
  final Libro libro;

  const CaricamentoImage({Key? key, required this.text, this.image, required this.libro}) : super(key: key);

  @override
  _CaricamentoImageState createState() => _CaricamentoImageState();
}

class _CaricamentoImageState extends State<CaricamentoImage> {

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
              child: Header(
                iconProfile: Image.asset('assets/person-icon.png'),
                text: "",
                isHomePage: false,
                isProfilo: false,
              ),
            ),
            FutureBuilder<void>(
              future: _processImage(),
              builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
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
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Errore durante il caricamento'));
                } else {
                  return Opera(libro: widget.libro, imageString: _imageToBase64(widget.image!),);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  String _imageToBase64(File image) {
    List<int> imageBytes = image.readAsBytesSync();
    return base64Encode(imageBytes);
  }

  Future<void> _processImage() async {
    // Simula un'elaborazione asincrona dell'immagine
    await Future.delayed(Duration(seconds: 3));
    // Esegui qui eventuali operazioni sull'immagine, ad esempio caricamento su server
  }
}
