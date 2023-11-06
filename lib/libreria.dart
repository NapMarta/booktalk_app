import 'package:flutter/material.dart';
import 'modifica-profilo.dart';

class Libreria extends StatefulWidget {
  @override
  _LibreriaState createState() => _LibreriaState();
}

class _LibreriaState extends State<Libreria> {

  List<bool> showActions = List.generate(15, (index) => false);
  int selectedBookIndex= -1;
  bool isBookSelected(int index) => selectedBookIndex == index;
  double selectedBookFontSize = 20.0; // grandezza font al click sull'item Libro


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[

          // ------ HEADER ------
          SliverAppBar(
            expandedHeight: 20.0,
            floating: true,
            pinned: false,
            backgroundColor: Color(0xFFbee2ee),
            title: Image.asset('assets/BookTalk-scritta.png', width: 150),
            leading: BackButton(color: Color(0xFF0099b5)), // freccia indietro


            // ------ Pulsante Profilo ------
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProfileManagementPage(),
                    ),
                  );
                },
                child: Image.asset('assets/person-icon.png', width: 35, height: 35),
              ),
            ],
          ),
          
          // ------ LIBRERIA ------
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Text(
                  'I tuoi libri',
                  style: TextStyle(fontSize: 30, color: Color(0xFF048A8F), fontWeight: FontWeight.bold),
                ),
              ),
              ),
            ),
          
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isBookSelected(index)) {
                              selectedBookIndex = -1;
                            } else {
                              selectedBookIndex = index;
                            }
                          });
                        },
                        child: Container(
                          child: AnimatedOpacity(
                            duration: Duration(milliseconds: 500),
                            opacity: isBookSelected(index) ? 1.0 : 0.6,
                            child: ListTile(
                              leading: Hero(
                                tag: "book_cover_$index",
                                child: Image.asset("assets/copertina.jpg", height: isBookSelected(index) ? 120 : 80, width: isBookSelected(index) ? 70: 50,),
                              ),
                              title: Text(
                                'Libro $index',
                                style: TextStyle(fontSize: isBookSelected(index) ? selectedBookFontSize : 16.0, 
                                ),
                              ),
                              subtitle: isBookSelected(index)
                                  ? Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        SizedBox(height: 150.0,),
                                        GestureDetector(
                                          onTap: () {
                                            // Azione da eseguire quando si fa clic su icona-2
                                          },
                                          child: Image.asset("assets/icona-2.png", height: 70),
                                        ),
                                        SizedBox(width: 80.0),
                                        GestureDetector(
                                          onTap: () {
                                            // Azione da eseguire quando si fa clic su icona-3
                                          },
                                          child: Image.asset("assets/icona-3.png", height: 70),
                                        ),
                                      ],
                                    )
                                  : null,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              childCount: 15, // da sostituire con la lista di libri
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
        backgroundColor: Color(0xFF048A8F),
      ),
    );
  }
}
