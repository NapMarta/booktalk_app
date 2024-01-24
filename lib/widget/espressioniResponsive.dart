import 'package:booktalk_app/widget/header.dart';
import 'package:flutter/material.dart';
    
class EspressioniResponsive extends StatefulWidget {
  const EspressioniResponsive({Key? key}) : super(key: key);

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
                text: "Espressioni Matematiche",
                isHomePage: false,
                isProfilo: false,
              ),
            ),
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) { 
                  return Text("Step ${index}");
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}