import 'package:flutter/material.dart';
import 'package:booktalk_app/ExpandableFloatingActionButton.dart';

class Libreria extends StatefulWidget {
  @override
  _LibreriaState createState() => _LibreriaState();
}

class _LibreriaState extends State<Libreria> {
  int selectedBookIndex = -1;
  bool isBookSelected(int index) => selectedBookIndex == index;
  double selectedBookFontSize = 20.0; // grandezza font al click sull'item Libro
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 35.0, bottom: 20.0, left: 8.0, right: 8.0),
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
                  // L'azione relativa all'icona del sole è stata rimossa qui
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
          Expanded(
            child: CustomScrollView(
              controller: _scrollController,
              slivers: <Widget>[
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // Numero di colonne per riga
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: GestureDetector(
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
                                    child: Image.asset(
                                      "assets/copertina.jpg",
                                      height: isBookSelected(index) ? 120 : 80,
                                      width: isBookSelected(index) ? 70 : 50,
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    'Libro $index',
                                    style: TextStyle(
                                      fontSize: isBookSelected(index)
                                          ? selectedBookFontSize
                                          : 16.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: 30, // da sostituire con la lista di libri
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
