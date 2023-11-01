import 'package:flutter/material.dart';
import 'profilo.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  List<bool> showActions = List.generate(20, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[

          // ------ HEADER ------
          SliverAppBar(
            expandedHeight: 20.0,
            floating: true,
            pinned: false,
            backgroundColor: Color(0xFFbee2ee),
            title: Image.asset('assets/BookTalk-scritta.png', width: 150),
            leading: IconButton(
              icon: Icon(Icons.home, color: Color(0xFF0099b5)),
              onPressed: () {
                // Azione da eseguire per tornare alla homepage
              },
            ), 
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.person, color: Color(0xFF0099b5), size: 30),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProfileManagementPage(),
                      ),
                  );                 },
              ),
            ],
          ),
          
          // ------ Pulsanti funzionalita' ------
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      // Azione da eseguire quando si fa clic sull'icona-1
                    },
                    child: Image.asset("assets/icona-1.png", width: 50, height: 50),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Azione da eseguire quando si fa clic sull'icona-2
                    },
                    child: Image.asset("assets/icona-2.png", width: 50, height: 50),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Azione da eseguire quando si fa clic sull'icona-3
                    },
                    child: Image.asset("assets/icona-3.png", width: 50, height: 50),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Text(
                'Ciao Nome',
                style: TextStyle(fontSize: 30, color: Color(0xFF0099b5)),
                ),
              ),
            ),
          ),


          // ------ LIBRERIA ------
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'I tuoi libri',
                    style: TextStyle(fontSize: 25, color: Color(0xFF0099b5)),
                  ),
                ],
              ),
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Column(
                  children: [
                    ListTile(
                      leading: Image.asset("assets/copertina.jpg", width: 40, height: 40),
                      title: Text('Libro $index'),
                      onTap: () {
                        setState(() {
                          showActions[index] = !showActions[index];
                        });
                      },
                    ),
                    if (showActions[index])
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              // Azione da eseguire quando si fa clic sull'icona-2
                            },
                            child: Image.asset("assets/icona-2.png", width: 50, height: 50),
                          ),
                          SizedBox(width: 30.0), // Aggiunge uno spazio di 16 pixel tra i pulsanti
                          GestureDetector(
                            onTap: () {
                              // Azione da eseguire quando si fa clic sull'icona-3
                            },
                            child: Image.asset("assets/icona-3.png", width: 50, height: 50),
                          ),
                        ],
                      ),
                  ],
                );
              },
              childCount: 20, // Sostituisci con la tua lista di libri
            ),
          ),
        ],
      ),




      // ------ Pulsante "Aggiungi libro" ------
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Azione da eseguire per aggiungere un nuovo libro
        },
        icon: Icon(Icons.add),
        label: Text('Aggiungi libro'),
        backgroundColor: Color(0xFF0099b5),
      ),

    );
  }
}
