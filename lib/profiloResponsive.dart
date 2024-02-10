import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:booktalk_app/business_logic/monitoraggioStatistiche.dart';
import 'package:booktalk_app/business_logic/registrazione.dart';
import 'package:booktalk_app/business_logic/registrazioneService.dart';
import 'package:booktalk_app/homepageResponsive.dart';
import 'package:booktalk_app/modificaProfiloResponsive.dart';
import 'package:booktalk_app/storage/libro.dart';
import 'package:booktalk_app/storage/utente.dart';
import 'package:booktalk_app/storage/utenteDAO.dart';
import 'package:booktalk_app/widget/header.dart';
import 'package:booktalk_app/statistiche.dart';
import 'package:booktalk_app/utils.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ProfiloResponsitive extends StatefulWidget {
  const ProfiloResponsitive({Key? key}) : super(key: key);

  @override
  _ProfiloResponsitiveState createState() => _ProfiloResponsitiveState();
}

class _ProfiloResponsitiveState extends State<ProfiloResponsitive> {
  //File? _selectedImage;
  late SharedPreferences _preferences;
  String nome = '';
  String cognome = '';
  String email = '';
  Future<Uint8List>? foto;
  late Future<Utente?> utente;
  Uint8List? temp;

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
    super.initState();
    _loadUserData();
  }

  // Funzione per caricare i dati dell'utente dalle SharedPreferences
  Future<void> _loadUserData() async {
    print("Loading user data...");
    _preferences = await SharedPreferences.getInstance();
    String utenteJson = _preferences.getString('utente') ?? '';
    if (utenteJson.isNotEmpty) {
      Map<String, dynamic> utenteMap = json.decode(utenteJson);
      UtenteDao dao = UtenteDao('http://130.61.22.178:9000');
      //(utenteMap);
      utente = dao.getUtenteByEmail(utenteMap['EMAIL']);
      setState(() {});
      nome = utenteMap['NOME'] ?? '';
      cognome = utenteMap['COGNOME'] ?? '';
      email = utenteMap['EMAIL'] ?? '';

      setState(() {
        String blobString = utenteMap['FOTO'] ?? '';
        if (blobString.isNotEmpty) {
          temp = base64Decode(blobString);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    final panelController = PanelController();

    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).popUntil((route) => route.isFirst);

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomepageResponsitive(),
          ),
        ); 
        return false;
      },

    child: SafeArea(
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
              PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight),
                child: Header(
                  iconProfile: Image.asset('assets/person-icon.png'),
                  text: "",
                  isHomePage: false,
                  isProfilo: true,
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: mediaQueryData.size.height * 0.07, bottom: 40),
                      child: InkWell(
                        onTap: () {},
                        child: foto != null
                          ? FutureBuilder<Uint8List?>(
                            future: Future.value(foto),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else if (snapshot.hasData && snapshot.data != null) {
                                return Container(
                                  height: mediaQueryData.size.height * 0.20,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.contain,
                                        image: MemoryImage(snapshot.data!),
                                      ),
                                    ),
                                  );
                              } else {
                                return Center(child: Text('No image selected'));
                              }
                            },
                          )
                          : temp != null
                            ? FutureBuilder<Uint8List?>(
                              future: Future.value(temp),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else if (snapshot.hasData && snapshot.data != null) {
                                  return Container(
                                    height: mediaQueryData.size.height * 0.20,
                                    width: mediaQueryData.size.height * 0.20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black,
                                    ),
                                    child: IconButton(
                                      icon: Image.memory(snapshot.data!),
                                      iconSize: mediaQueryData.size.height * 0.20, // Imposta la dimensione dell'icona come la dimensione del container
                                      onPressed: () {
                                      },
                                    ),
                                  );

                                  
                                  /*Container(
                                    height: mediaQueryData.size.height * 0.20,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.fitHeight,
                                          image: MemoryImage(snapshot.data!),
                                        ),
                                      ),
                                    );*/
                                } else {
                                  return Center(child: Text('No image selected'));
                                }
                              },
                            )
                              /*
                              Container(
                                height: mediaQueryData.size.height * 0.20,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.fitHeight,
                                      image: MemoryImage(temp!),
                                    ),
                                  ),
                                )*/
                                
                            : Image.asset(
                                "assets/person-icon.png",
                                height: mediaQueryData.size.height * 0.20,
                              ),  
                      ),
                    ),

                    Positioned(
                      bottom: mediaQueryData.size.height * 0.04,
                      right: 0,
                      left: mediaQueryData.size.height * 0.12,
                      child: InkWell(
                        onTap: () {
                          getImageFromGallery();
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            color: Color(0xFF0097b2),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: mediaQueryData.size.height * 0.32,
                child: Container(
                  width: isTabletOrizzontale(mediaQueryData)
                      ? mediaQueryData.size.width * 0.7
                      : mediaQueryData.size.width * 0.8,
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(
                      isTabletOrizzontale(mediaQueryData)
                          ? mediaQueryData.size.width * 0.15
                          : mediaQueryData.size.width * 0.10,
                      0.0,
                      isTabletOrizzontale(mediaQueryData)
                          ? mediaQueryData.size.width * 0.15
                          : mediaQueryData.size.width * 0.10,
                      0.0),
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
                    padding: const EdgeInsets.only(
                        bottom: 10, left: 20, right: 20, top: 4),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 0, right: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "I tuoi dati",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0097b2)),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ModificaProfiloResponsive(),
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: Color(0xFF0097b2),
                                  ),
                                  iconSize: 20,
                                  padding: EdgeInsets.all(0),
                                  color: Color(0xFF0097b2),
                                ),
                              ),
                            ],
                          ),
                        ),
                        _buildProfileCard(
                            mediaQueryData.size.width,
                            mediaQueryData.size.height,
                            'Nome',
                            Icons.account_circle,
                            nome),
                        SizedBox(
                            height: isTabletOrizzontale(mediaQueryData) ? 0 : 8),
                        _buildProfileCard(
                            mediaQueryData.size.width,
                            mediaQueryData.size.height,
                            'Cognome',
                            Icons.account_circle,
                            cognome),
                        SizedBox(
                            height: isTabletOrizzontale(mediaQueryData) ? 0 : 8),
                        _buildProfileCard(
                            mediaQueryData.size.width,
                            mediaQueryData.size.height,
                            'Email',
                            Icons.email,
                            email),
                        SizedBox(
                            height: isTabletOrizzontale(mediaQueryData) ? 0 : 8),
                      ],
                    ),
                  ),
                ),
              ),
              SlidingUpPanel(
                renderPanelSheet: false,
                backdropEnabled: true,
                backdropOpacity: 0.5,
                controller: panelController,
                minHeight: isTabletOrizzontale(mediaQueryData)
                    ? mediaQueryData.size.height * 0.1
                    : mediaQueryData.size.height * 0.25,
                maxHeight: isTabletVerticale(mediaQueryData)
                    ? mediaQueryData.size.height * 0.91
                    : mediaQueryData.size.height * 0.94,
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
    ),
    );
  }

  Future getImageFromGallery() async {
    final image =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) return;

    File _selectedImage = File(image.path);
    Future<Uint8List> _imageBytes = _selectedImage.readAsBytes();
    _imageBytes.then((value) {
      utente.then((valueUtente) async {
        valueUtente?.foto = value;
        
        RegistrazioneService registrazione = Registrazione('http://130.61.22.178:9000');
        final risultato = await registrazione.modificaUtenteNoPassword(valueUtente!);
        if (risultato.containsKey('success')) {
          // Se la modifica è avvenuta con successo
          modificaOK(context, risultato['success']);
      
        } else if (risultato.containsKey('error')) {
          mostraErrore(context, risultato['error']);
        }
        print(risultato);  
      });
    });

    setState(()  {
      foto = _imageBytes;
    });
  }
}

Widget _buildProfileCard(double width, double height, String label,
    IconData iconData, String text) {
  return Align(
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconData),
          SizedBox(width: 10),
          SizedBox(
            width: width * 0.60,
            child: TextField(
              readOnly: true,
              enabled: false,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
              enableInteractiveSelection: false,
              focusNode: FocusNode(),
              decoration: InputDecoration(
                labelText: label,
              ),
              controller: TextEditingController(text: text),
            ),
          ),
        ],
      ));
}