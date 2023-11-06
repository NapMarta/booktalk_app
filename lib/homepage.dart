import 'package:flutter/material.dart';
import 'profilo.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  List<bool> showActions = List.generate(15, (index) => false);
  int selectedBookIndex= -1;
  bool isBookSelected(int index) => selectedBookIndex == index;
  double selectedBookFontSize = 20.0; // grandezza font al click sull'item Libro


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
            automaticallyImplyLeading: false, // per rimuovere la freccia indietro

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
          
          // ------ Pulsanti funzionalita' ------
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Text(
                  'Studia con BookTalk',
                  style: TextStyle(fontSize: 30, color: Color.fromARGB(255, 8, 201, 111), fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      // Azione da eseguire quando si fa clic sull'icona-1
                    },
                    child:
                    Column(children: [Image.asset("assets/risolvi-espressioni.png"), SizedBox(height: 40.0),],) 
                  ),

                  GestureDetector(
                    onTap: () {
                      // Azione da eseguire quando si fa clic sull'icona-2
                    },
                    child:
                    Column(children: [Image.asset("assets/analisi-del-testo.png"), SizedBox(height: 40.0),],) 
                  ),
                  GestureDetector(
                    onTap: () {
                      // Azione da eseguire quando si fa clic sull'icona-3
                    },
                    child: Image.asset("assets/studia-argomento.png"),
                  ),
                ],
              ),
            ),
          ),

          // ------ SALUTO ------
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Text(
                  'Ciao Maria',
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
                                child: Image.asset("assets/copertina.jpg", height: isBookSelected(index) ? 150 : 80, width: isBookSelected(index) ? 70: 50,),
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
                                          child: Image.asset("assets/icona-2.png", width: 80),
                                        ),
                                        SizedBox(width: 50.0),
                                        GestureDetector(
                                          onTap: () {
                                            // Azione da eseguire quando si fa clic su icona-3
                                          },
                                          child: Image.asset("assets/icona-3.png", width: 80),
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
        backgroundColor: Color(0xFF0099b5),
      ),

    );
  }
}
