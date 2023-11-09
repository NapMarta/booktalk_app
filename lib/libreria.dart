import 'package:booktalk_app/ExpandableFloatingActionButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'modifica-profilo.dart';

class Libreria extends StatefulWidget {

  @override
  _LibreriaState createState() => _LibreriaState();
}

class _LibreriaState extends State<Libreria> {
  
  int selectedBookIndex= -1;
  bool isBookSelected(int index) => selectedBookIndex == index;
  double selectedBookFontSize = 20.0; // grandezza font al click sull'item Libro
  final ScrollController _scrollController = ScrollController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        controller: _scrollController,
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
          
          // ------ LIBR;ERIA ------
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
          /*
          GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Numero di colonne per riga
          ),
          itemCount: showActions.length,
          itemBuilder: (context, index) {
            return Card(
              child: Center(
                child: Text(showActions[index]),
              ),
            );
          },
        )*/

          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Numero di colonne per riga
            ),
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
                            child: Column(
                              children: [
                                Hero(
                                  tag: "book_cover_$index",
                                  child: Image.asset("assets/copertina.jpg", height: isBookSelected(index) ? 120 : 80, width: isBookSelected(index) ? 70: 50),
                                ),
                                SizedBox(height: 8.0), // Spazio tra l'immagine e il testo
                                Text(
                                  'Libro $index',
                                  style: TextStyle(fontSize: isBookSelected(index) ? selectedBookFontSize : 16.0),
                                ),
                              ],
                              /*
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
                                          child: Image.asset("assets/2.png", height: 70),
                                        ),
                                        SizedBox(width: 80.0),
                                        GestureDetector(
                                          onTap: () {
                                            // Azione da eseguire quando si fa clic su icona-3
                                          },
                                          child: Image.asset("assets/3.png", height: 70),
                                        ),
                                      ],
                                    )
                                  : null,
                                  */
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
      floatingActionButton: ExpandableFloatingActionButton(
        icon: Icons.add,
        label: 'Aggiungi Libro',
        scrollController: _scrollController,
        onPressed: () {
          // Define the action to be taken when the FAB is pressed
          // For example, you can add a new item to the list.
          // In this case, we will scroll to the top of the list when the FAB is pressed.
          _scrollController.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
        },
      ),
    );
    
      
    
  }


  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}