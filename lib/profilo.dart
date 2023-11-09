import 'package:booktalk_app/homepage.dart';
import 'package:booktalk_app/modifica-profilo.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEditing = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  //final Libreria _libreriaPage = Libreria();
  final panelController = PanelController();
  bool isFirstTime = true; // Aggiungi questa variabile di stato


  @override
  void initState() {
    super.initState();
    nameController.text = 'Maria';
    surnameController.text = 'Rossi';
    emailController.text = 'maria@email.com';
    WidgetsBinding.instance.addPostFrameCallback((_) {
      panelController.open();
      double newPosition = 0.5 * (800.0 - 65.0) * 0.6; // Aggiusta qui secondo necessità
      panelController.animatePanelToPosition(newPosition, duration: Duration(milliseconds: 0), curve: Curves.linear);
      isFirstTime=false;
    });
  }

  Widget _buildProfileCard(
      TextEditingController controller, String label, IconData iconData) {
    return Row(
      children: [
        Icon(iconData),
        SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: controller,
            readOnly: !isEditing,
            decoration: InputDecoration(
              labelText: label,
            ),
          ),
        ),
      ],
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        //extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/sfondo.png"),
                  fit: BoxFit.cover,
                ),
                //color: Colors.white,
              ),
              child: Column(
                children: [Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 10.0, top: 45),
                              child: Text(
                                'Bentornata Maria!',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 4,
                                      color: Color.fromARGB(255, 112, 112, 112),
                                      offset: Offset(2, 2),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 165.0, top: 45),
                    child: Container(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Homepage(),
                          ));
                        },
                        child: Icon(
                          Icons.home,
                          color: Color(0xFF0099b5),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Aggiungi qui la logica per il logout
                    // Per esempio, puoi chiamare una funzione che gestisce il logout
                    // o navigare verso la schermata di login.
                    // Esempio: logoutFunction();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 45),
                    child: Container(
                      child: GestureDetector(
                        onTap: () {
                          // Aggiungi qui la logica per il logout
                          // Esempio: logoutFunction();
                        },
                        child: Icon(
                          Icons.exit_to_app,
                          color: Color(0xFF0099b5),
                        ),
                      ),
                    ),
                  ),
                ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top:30, bottom: 50),
                        child: Image.asset(
                          "assets/person-icon.png",
                          width: 150,),
                      ),                      
                      Positioned(
                        top: 200, // Regola la posizione verticale del riquadro
                        left: 20, // Regola la posizione orizzontale del riquadro
                        child: Container(
                          width: 350,
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
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                children: [
                                  Text("I tuoi dati", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0099b5)),),
                                  SizedBox(width: 170,),
                                  Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => ProfileManagementPage(),
                                          ),
                                      ); 
                                      /*setState(() {
                                        isEditing = !isEditing;
                                      });*/
                                      /*if(isEditing){
                                        panelController.hide();
                                      }
                                      else{
                                        panelController.show();
                                      }*/
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Color(0xFF0099b5),
                                    ),
                                    iconSize: 30,
                                    padding: EdgeInsets.all(12),
                                    color: Color(0xFF0099b5),
                                  ),
                                ),
                                ],
                                ),
                                _buildProfileCard(
                                    nameController, 'Nome', Icons.account_circle),
                                SizedBox(height: 10),
                                _buildProfileCard(
                                    surnameController, 'Cognome', Icons.account_circle),
                                SizedBox(height: 10),
                                _buildProfileCard(
                                    emailController, 'Email', Icons.email),
                                SizedBox(height: 10),

                                /*Align(
                                  alignment: Alignment.center,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        isEditing = !isEditing;
                                      });
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(
                                          Color(0xFF0099b5)),
                                      textStyle: MaterialStateProperty.all(
                                        TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    child: Text(isEditing ? 'Salva' : 'Modifica'),
                                  ),
                                ),*/
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SlidingUpPanel(
              controller: panelController,
              minHeight: 65.0,
              maxHeight: 800.0,
              onPanelSlide: (double pos) {
              if(isFirstTime){
                double newPosition = pos * (800.0 - 65.0) * 0.65;
                panelController.animatePanelToPosition(newPosition, duration: Duration(milliseconds: 0), curve: Curves.linear);
                isFirstTime=false;
              }
              else if (pos<=65.0){
                double newPosition = 65.0 * (800.0 - 65.0) * 0.65;
                panelController.animatePanelToPosition(newPosition, duration: Duration(milliseconds: 0), curve: Curves.linear);
              }},

              panel: Center(child: Column(children: [
                SizedBox(height: 80,), 
                Text("Utilizzo dell'app", 
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),), 
                SizedBox(height: 20,), 
                Image.asset("assets/grafico1.png", width: 350,),

                SizedBox(height: 80,), 
                Text("Percentuale di utilizzo delle funzionalità", 
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,), textAlign: TextAlign.center,), 
                SizedBox(height: 20,), 
                Image.asset("assets/grafico2.png", width: 350,)
                ])),

              backdropEnabled: false,
              slideDirection: SlideDirection.UP,
              collapsed: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF0099b5),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.0),
                    topRight: Radius.circular(24.0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/linea.png", width: 70,),
                    //Text("^", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30)),
                    SizedBox(height: 15),
                    //Image.asset("assets/library.gif", width: 70,),
                    Text(
                      'Statistiche',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22
                      ),
                    ),
                    SizedBox(height: 10),

                  ],
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
    );
  }  
}
