import 'package:flutter/material.dart';
import 'package:booktalk_app/widget/ExpandableFloatingActionButton.dart';

import 'dart:ui';

class LibreriaFunzionzlita extends StatefulWidget {
  @override
  _LibreriaState createState() => _LibreriaState();
}

class _LibreriaState extends State<LibreriaFunzionzlita> {
  
  bool isBlurActive = false;
  double selectedBookFontSize = 20.0;
  final ScrollController _scrollController = ScrollController();
  bool isButtonVisible = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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

            SizedBox(height: 50),
            Text('Seleziona il libro desiderato', 
              style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              shadows: [
                Shadow(
                  blurRadius: 8,
                  color: Colors.white,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            ),


            Padding(
              padding: const EdgeInsets.only(
                  top: 35.0, bottom: 20.0, left: 8.0, right: 8.0),
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






  
             
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }           
}

  

