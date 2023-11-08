import 'package:booktalk_app/modifica-profilo.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEditing = false;
  String name = 'Maria';
  String surname = 'Rossi';
  String email = 'maria@email.com';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      backgroundColor: Colors.white,
      
      // ------ HEADER ------
      appBar: AppBar(
        backgroundColor: Color(0xFFbee2ee),
        title: Text('Profilo', style: TextStyle(color: Color(0xFF0099b5), fontWeight: FontWeight.bold,),),
        leading: BackButton(color: Color(0xFF0099b5)), // freccia indietro
        actions: [
          IconButton(
            icon: Icon(Icons.edit), // Icona di modifica
            color: Color(0xFF0099b5),

            onPressed: () {
              // Azione quando viene premuto il pulsante di modifica
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProfileManagementPage(),
                ),
              );
            },
          ),
        ],
      ),


      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              Text(
                'I tuoi dati',
                  style: TextStyle(fontSize: 30, color: Color(0xFF048A8F), fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              SizedBox(height: 20.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 2.0, color: Colors.blue),
                  borderRadius: BorderRadius.circular(10.0),
                ),

                
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      enabled: isEditing,
                      decoration: InputDecoration(
                        labelText: 'Nome',
                        labelStyle: TextStyle(color: Colors.black), // Colore del testo del label
                      ),
                      initialValue: name,
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                      style: TextStyle(color: Colors.black), // Colore del testo
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      enabled: isEditing,
                      decoration: InputDecoration(
                        labelText: 'Cognome',
                        labelStyle: TextStyle(color: Colors.black), // Colore del testo del label
                      ),
                      initialValue: surname,
                      onChanged: (value) {
                        setState(() {
                          surname = value;
                        });
                      },
                      style: TextStyle(color: Colors.black), // Colore del testo
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      enabled: isEditing,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.black), // Colore del testo del label
                      ),
                      initialValue: email,
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                      style: TextStyle(color: Colors.black), // Colore del testo
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
