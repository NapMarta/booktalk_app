import 'package:flutter/material.dart';
import 'package:booktalk_app/ExpandableFloatingActionButton.dart';

import 'dart:ui';

class Libreria extends StatefulWidget {
  @override
  _LibreriaState createState() => _LibreriaState();
}

class _LibreriaState extends State<Libreria> {
  
  bool isBlurActive = false;
  double selectedBookFontSize = 20.0;
  final ScrollController _scrollController = ScrollController();
  bool isButtonVisible = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        flexibleSpace: Container(
          height: 80, // Imposta l'altezza desiderata per l'AppBar
          decoration: BoxDecoration(
            color: Color(0xFF0099b5),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 11),
              Image.asset("assets/linea.png", width: 70,),
              SizedBox(height: 15),
              Text(
                'Libreria',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ],
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),

      //backgroundColor: Colors.white,
      body: Column(

        /*decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 2),
              blurRadius: 6,
              spreadRadius: 0,
            ),
          ],
        ),*/

        
          // ----------- BARRA DI RICERCA -----------
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 0, bottom: 20.0, left: 8.0, right: 8.0),
              child: SearchAnchor(
                builder: (BuildContext context, SearchController controller) {
                  return SearchBar(
                    controller: controller,
                    padding: const MaterialStatePropertyAll<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 16.0)),
                    onTap: () {
                      controller.openView();
                    },
                    onChanged: (_) {
                      controller.openView();
                    },
                    leading: const Icon(Icons.search),
                  );
                },
                suggestionsBuilder:
                    (BuildContext context, SearchController controller) {
                  return List<ListTile>.generate(5, (int index) {
                    final String item = 'Libro $index';
                    return ListTile(
                      title: Text(item),
                      onTap: () {
                        setState(() {
                          controller.closeView(item);
                        });
                      },
                    );
                  });
                },
              ),
            ),

            // ----------- LISTA A GRIGLIA -----------
            

            Expanded(
            child:  CustomScrollView(
              controller: _scrollController,
              slivers: <Widget>[

                SliverPadding(
                  padding: EdgeInsets.only(bottom: 50.0), // Aggiungi lo spazio desiderato qui
                  sliver: 
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {

                      return Padding(
                        padding: EdgeInsets.only(bottom: 0.0),
                        child: GestureDetector(
                          onTap: () {
                            _showDialog(context, 'Libro $index');
                          },
                          child: Container(
                            //----------- DEFINIZIONE DELL'ELEMENTO -----------
                            child: Column(
                              children: [
                                Hero(
                                  tag: "book_cover_$index",
                                  child: Image.asset(
                                    "assets/copertina.jpg",
                                    height: 80,
                                    width: 50,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  'Libro $index',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: 30,
                  ),                  
                ),
                ),
              ],
            ),
          ),
          
        ],
      ),
    

      // ----------- PUSANTE AGGIUNGI LIBRO -----------
      floatingActionButton: ExpandableFloatingActionButton(
        icon: Icons.add,
        label: 'Aggiungi Libro',
        scrollController: _scrollController,
        onPressed: () {
          _scrollController.animateTo(0,
              duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
        },
      ),
    );
  }
  //----------- FINE -----------






void _showDialog(BuildContext context, String bookTitle) {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: AlertDialog(
            backgroundColor: Colors.transparent,
            content: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(8.0),
              ),
              
              width: 200.0, // Imposta la larghezza desiderata
              height: 250.0,
              alignment: Alignment.center,
            
              child: Column(
              children: [
                Row(
                  children: [
                      Hero(
                        tag: "book_cover_$bookTitle",
                        child: Padding(padding: const EdgeInsets.all(15), // Aggiunge spazio attorno all'immagine
                            child: Image.asset(
                            "assets/copertina.jpg",
                            height: 80,
                            width: 50,
                          ),
                        ),
                      ),

                      Text(
                        '$bookTitle',
                        style: TextStyle(fontSize: 16.0,  fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                  ],
                ),
                
                SizedBox(height: 8.0),
                Text(
                  'Dettagli del libro',
                  style: TextStyle(fontSize: 16.0),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 25.0),
                Center(
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // collegamento alla funzionalità 2
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 5, // Add elevation for boxShadow
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0), // Adjust border radius as needed
                        ),
                        shadowColor: Colors.grey, // Set shadow color
                        primary: Colors.white, // Set background color to white
                        padding: EdgeInsets.all(0.0),  // Adjust padding as needed
                      ),
                      
                      child: Image.asset(
                        "assets/2.jpeg",
                        height: 50,
                      ),
                      
                    ),

                    SizedBox(width: 20,),
                    ElevatedButton(
                      onPressed: () {
                        // collegamento alla funzionalità 3                        
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 5, // Add elevation for boxShadow
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0), // Adjust border radius as needed
                        ),
                        shadowColor: Colors.grey, // Set shadow color
                        primary: Colors.white, // Set background color to white
                        padding: EdgeInsets.all(0.0), // Adjust padding as needed
                      ),
                      child: Image.asset(
                        "assets/funzionalità3.jpg",
                        height: 50,
                      ),
                      
                    ),

                  ],
                ),
                ),
            
                ],
                ),                  
                
              ),
              ),
          );
          
      },
    );
  }


  
             
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }           
}

  

