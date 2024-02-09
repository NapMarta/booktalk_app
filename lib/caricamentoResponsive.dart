import 'package:booktalk_app/widget/header.dart';
import 'package:flutter/material.dart';
    
class CaricamentoResponsive extends StatefulWidget {
  final String text;

  const CaricamentoResponsive({Key? key, required this.text}) : super(key: key);

  @override
  _CaricamentoResponsiveState createState() => _CaricamentoResponsiveState();
}

class _CaricamentoResponsiveState extends State<CaricamentoResponsive> {
  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      left: true,
      right: true,
      bottom: false,
      top: true,
      child: Scaffold(
        // ----- HEADER -----
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Header(
            iconProfile: Image.asset('assets/person-icon.png'),
            text: "",
            isHomePage: false,
            isProfilo: false,
          ),
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: mediaQueryData.size.height * 0.15,
              ),
              Text(
                widget.text,
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: mediaQueryData.size.height * 0.15,
              ),
              CircularProgressIndicator(
                color: Color(0xFF0097b2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}