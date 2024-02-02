import 'package:booktalk_app/utils.dart';
import 'package:booktalk_app/widget/header.dart';
import 'package:flutter/material.dart';

class EspressioniResponsive extends StatefulWidget {
  final List<String> step;
  EspressioniResponsive({required this.step});
  @override
  _EspressioniResponsiveState createState() => _EspressioniResponsiveState();
}

class _EspressioniResponsiveState extends State<EspressioniResponsive> {
  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);

    //var stepSoluzioni = List.generate(10);

    return SafeArea(
      left: true,
      right: true,
      bottom: false,
      top: true,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Scaffold(
            // ----- HEADER -----
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: Header(
                iconProfile: Image.asset('assets/person-icon.png'),
                text: "Soluzione",
                isHomePage: false,
                isProfilo: false,
              ),
            ),
            backgroundColor: Colors.white,
            body: ListView.builder(
              itemCount: widget.step.length,
              padding: EdgeInsets.only(
                top: 20,
                left: isTablet(mediaQueryData) 
                      ? mediaQueryData.size.width * 0.2
                      : 0,
                right: isTablet(mediaQueryData) 
                      ? mediaQueryData.size.width * 0.2
                      : 0,
              ),
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.only(
                    top: 20, 
                    left: isTablet(mediaQueryData) 
                      ? mediaQueryData.size.width * 0.32
                      : mediaQueryData.size.width * 0.12,
                    right: isTablet(mediaQueryData) 
                      ? mediaQueryData.size.width * 0.32
                      : mediaQueryData.size.width * 0.12,
                  ),
                  height: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            (index == 0)
                            ? "Equazione"
                            /*
                              : (index == widget.step.length-1)
                                ? "Risultato"
                                : ...
                            */
                            : "Step ${index + 2}",
                            style: TextStyle(
                              color: Color(0xFFf0bc5e),
                              fontSize: 13, 
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      /*
                      SizedBox(
                        height: 15,
                      ),*/
                      Text(
                        
                        widget.step[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: (index == 0)
                            ? FontWeight.bold
                            : FontWeight.normal,
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(/*
                                left: isTablet(mediaQueryData) 
                                  ? mediaQueryData.size.width * 0.3
                                  : mediaQueryData.size.width * 0.1,
                                right: isTablet(mediaQueryData) 
                                  ? mediaQueryData.size.width * 0.3
                                  : mediaQueryData.size.width * 0.1
                            */
                            ),
                            child: Container(
                              height: 1,
                              color: Colors.grey, // Colore della linea grigia
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
              
            
            
          ),
        ],
      ),
    );
  }
}
