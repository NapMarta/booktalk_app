import 'dart:io';

import 'package:booktalk_app/modificaProfiloResponsive.dart';
import 'package:booktalk_app/widget/header.dart';
import 'package:booktalk_app/statistiche.dart';
import 'package:booktalk_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
    
class ProfiloResponsitive extends StatefulWidget {
  const ProfiloResponsitive({Key? key}) : super(key: key);

  @override
  _ProfiloResponsitiveState createState() => _ProfiloResponsitiveState();
}

class _ProfiloResponsitiveState extends State<ProfiloResponsitive> {
  File ? _selectedImage;

  @override
  Widget build(BuildContext context) {
    // variabile che indica le informazioni correnti del dispositivo
    var mediaQueryData = MediaQuery.of(context);

    // varaiabile per lo slide-up
    final panelController = PanelController();

    return SafeArea(
      // settaggio dei bordi da considerare del telefono
      left: true,
      right: true,
      bottom: false,
      top: true,
      child: Scaffold(
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
                  text: "",
                  isHomePage: false,
                  isProfilo: true,
                ),
              ),
              
              // ----- foto profilo con fotocamera per la modifica -----
              Align(
                alignment: Alignment.topCenter,
                child: Stack(
                  children: [
                    // --- FOTO PROFILO ---
                    Padding(
                      padding: EdgeInsets.only(top: mediaQueryData.size.height * 0.07, bottom: 40),
                      child: InkWell(
                        onTap: () {
                          // Azione da eseguire quando la foto profilo viene premuta
                        },
                        child: _selectedImage != null 
                        ? // se l'immagine è stata selezionata
                          // Crea un contenitore con lo sfondo nero e adatta la foto in altezza
                          Container(                            
                            height: mediaQueryData.size.height * 0.20,
                            decoration:  BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.fitHeight,
                                image: FileImage(
                                  _selectedImage!,
                                ),
                                )
                              )
                          )
                        : // se l'immagine non è stata selezionata
                          Image.asset(
                            "assets/person-icon.png",
                            height: mediaQueryData.size.height * 0.20,
                          ),
                      ),
                    ),

                    // --- Modifica Foto ---
                    Positioned(
                      bottom: mediaQueryData.size.height * 0.04,
                      right: 0,
                      left: mediaQueryData.size.height * 0.12,
                      child: InkWell(
                        onTap: () {
                          // Azione da eseguire quando l'icona della fotocamera viene premuta
                          getImageFromGallery();
                        },
                        child: Container(
                          //width: mediaQueryData.size. * 0.04,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            color: Color(0xFF0097b2), // Puoi impostare il colore desiderato
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ----- Visualizzazione dati dell'utente -----
              Positioned(
                top: mediaQueryData.size.height * 0.32, // Regola la posizione verticale del riquadro
                // left: mediaQueryData.size.width , // Regola la posizione orizzontale del riquadro
                child: Container(
                  width: mediaQueryData.size.width * 0.8,
                  //height: mediaQueryData.size.height * 0.,
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(mediaQueryData.size.width * 0.10, 0.0, mediaQueryData.size.width * 0.10, 0.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, 2),
                        blurRadius: 6,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15, left: 20, right: 20, top: 12),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween, // aggiunge lo spazio tra gli elementi
                          children: [
                            Text(
                              "I tuoi dati" ,
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0097b2)),
                            ),
                                          
                            //SizedBox(width: 170,),
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => ModificaProfiloResponsive(),
                                      ),
                                  ); 
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Color(0xFF0097b2),
                                  
                                ),
                                iconSize: 25,
                                padding: EdgeInsets.all(0),
                                color: Color(0xFF0097b2),
                              ),
                            ),
                          ],
                        ),
                        _buildProfileCard(
                            mediaQueryData.size.width, mediaQueryData.size.height, 'Nome', Icons.account_circle, 'Maria'),
                        SizedBox(height: 10),
                        _buildProfileCard(
                            mediaQueryData.size.width, mediaQueryData.size.height, 'Cognome', Icons.account_circle, 'Rossi'),
                        SizedBox(height: 10),
                        _buildProfileCard(
                            mediaQueryData.size.width, mediaQueryData.size.height, 'Email', Icons.email, 'mariarossi@email.com'),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),

              // SLIDE UP - Statistiche
              SlidingUpPanel(
                // making false it does 
                // not render outside
                renderPanelSheet: false,
                controller: panelController,
                minHeight: mediaQueryData.size.height * 0.25,
                maxHeight: mediaQueryData.size.height * 0.955,
                // panel
                panel: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.0),
                      topRight: Radius.circular(24.0),
                    ),
                  ),
                  
                  child: Statistiche(),
                ),
                        // collapsed 
                collapsed: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.0),
                      topRight: Radius.circular(24.0),
                    ),
                  ),
                ),
                
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Funzione che apre la galleria e restituisce l'immagine
  Future getImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if(image == null) return;
    setState(() {
      _selectedImage = File(image!.path);
    });
  }
}


Widget _buildProfileCard(
    double width, double height, String label, IconData iconData, String text) {
      TextEditingController _controller = TextEditingController(text: text);
  return Align(
    alignment: Alignment.center,
    child: Row(
      // center della riga
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(iconData),
        SizedBox(width: 10),
        SizedBox(
          width: width * 0.60,
          child: TextField(
            controller: _controller,
            readOnly: true,
            enabled: false,
            style: TextStyle(
              color: Colors.black,
              fontSize: size(width, height, 14),
            ),
            enableInteractiveSelection: false,
            focusNode: FocusNode(),
            decoration: InputDecoration(
              labelText: label,
            ),
          ),
        ),
      ],
    )
  );
}