import 'dart:io';
import 'dart:ui';

import 'package:booktalk_app/widget/ExpandableFloatingActionButton.dart';
import 'package:booktalk_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
    
class LibreriaResponsive extends StatefulWidget {
  const LibreriaResponsive({Key? key}) : super(key: key);

  @override
  _LibreriaResponsiveState createState() => _LibreriaResponsiveState();
}

class _LibreriaResponsiveState extends State<LibreriaResponsive> {
  File ? _selectedImage;
  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    final ScrollController _scrollController = ScrollController();

    return Scaffold(
      backgroundColor: Colors.transparent,

      // HEADER
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(mediaQueryData.size.height * 0.07),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFF0097b2),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: mediaQueryData.size.height * 0.006),
              Image.asset(
                "assets/linea.png",
                width: 50,
              ),
              SizedBox(height: mediaQueryData.size.height * 0.013),
              Text(
                'Libreria',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: size(mediaQueryData.size.width,
                      mediaQueryData.size.height, 16),
                ),
              ),
              //SizedBox(height: 2),
            ],
          ),
        ),
      ),

      body: Column(
        children: [
          // ----------- BARRA DI RICERCA -----------
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 10, bottom: 20.0, left: 8.0, right: 8.0),
            child: SearchAnchor(
              builder: (BuildContext context, SearchController controller) {
                return SearchBar(
                  controller: controller,
                  padding: const MaterialStatePropertyAll<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 16.0)),
                  onTap: () {
                    
                  },
                  onChanged: (_) {
                  },
                  leading: const Icon(Icons.search),
                );
              },
              
              // Per i suggerimenti
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

          SizedBox(height: mediaQueryData.size.height * 0.02,),

          // ----------- LISTA A GRIGLIA -----------
          /*
          Expanded(
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: getMinor(mediaQueryData.size.width, mediaQueryData.size.height) > 600 ? 5 : 3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 50,
                childAspectRatio: 3 / 4,
              ),
              itemBuilder: (BuildContext ctx, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.grey[500]!),
                  ),
                );
              },
            ),
          )
          */
          Expanded(
            child:  CustomScrollView(
              controller: _scrollController,
              slivers: <Widget>[
                SliverPadding(
                  padding: EdgeInsets.only(bottom: 60.0), 
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: getMinor(mediaQueryData.size.width, mediaQueryData.size.height) > 600 ? 5 : 3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 50,
                      childAspectRatio: 3 / (mediaQueryData.orientation == Orientation.landscape ? 2 : 3),
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        
                          return GestureDetector(
                          onTap: () {
                            _showDialog(context, 'Libro $index', mediaQueryData.size.width, mediaQueryData.size.height);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              //border: Border.all(width: 1.0, color: Colors.grey), 
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                "assets/copertina.jpg",
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
          getImageFromCamera();
        },
      ),
    );
  }

  Future getImageFromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);

    if(image == null) return;
    setState(() {
      _selectedImage = File(image!.path);
    });
  }
}






void _showDialog(BuildContext context, String bookTitle, double width, double height) {

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
                borderRadius: BorderRadius.circular(25.0),
              ),
              width: width*0.5,
              height: height*0.40,
              alignment: Alignment.center,
              padding: EdgeInsets.all(0),

              child: Column(
                children: [
                  Hero(
                    tag: "book_cover_$bookTitle",
                    child: Padding(padding: const EdgeInsets.all(15), // Aggiunge spazio attorno all'immagine
                        child: Image.asset(
                        "assets/copertina.jpg",
                        width: getMinor(width,
                            height) >
                            600
                        ? 120
                        : 80,
                      ),
                    ),
                  ),

                  Text(
                    '$bookTitle',
                    style: TextStyle(fontSize: size(width, height, 20),  fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                    
                  
                  
                  SizedBox(height: height*0.05),
                  Text(
                    'Dettagli del libro',
                    style: TextStyle(fontSize: size(width, height, 12)),
                    textAlign: TextAlign.center,
                  ),
                  //SizedBox(height: 25.0),    

                  Expanded(
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: IntrinsicWidth(
                        stepWidth: (width*0.5)+30,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Expanded(                              
                              child: Container(
                                //width: (width*0.5)/2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(25)),
                                  border: Border.all(width: 1.0, color: Colors.grey)
                                ),
                                height: 50,
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(6.0),
                                    child: Image.asset("assets/2.jpeg"),
                                  ),
                                ),
                              ),
                              ),
                              Expanded(
                                child: Container(
                                  //width: (width*0.5)/2,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(25),),
                                    border: Border.all(width: 1.0, color: Colors.grey),
                                  ),
                                  height: 50,
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(6.0),
                                      child: Image.asset("assets/funzionalità3.jpg"),
                                    ),
                                  ),
                                ),
                              ),

                          ],
                        ),        
                      ),
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
