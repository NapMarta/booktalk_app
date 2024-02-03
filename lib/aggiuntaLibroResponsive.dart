
import 'package:booktalk_app/homepageResponsive.dart';
import 'package:booktalk_app/utils.dart';
import 'package:booktalk_app/widget/header.dart';
import 'package:flutter/material.dart';
    
class AggiuntaLibroResponsive extends StatefulWidget {
  const AggiuntaLibroResponsive({Key? key}) : super(key: key);

  @override
  _AggiuntaLibroResponsiveState createState() => _AggiuntaLibroResponsiveState();
}

class _AggiuntaLibroResponsiveState extends State<AggiuntaLibroResponsive> {
  @override
  Widget build(BuildContext context) {
    // variabile che indica le informazioni correnti del dispositivo
    var mediaQueryData = MediaQuery.of(context);

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
                text: "Aggiunta libro",
                isHomePage: false,
                isProfilo: false,
              ),
            ),
            backgroundColor: Colors.white,
            body: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: isTabletOrizzontale(mediaQueryData)
                                                ? 0
                                                : mediaQueryData.size.height * 0.05),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: Image.asset(
                          "assets/libro1.jpg",
                          width: isTabletOrizzontale(mediaQueryData)
                              ? 45
                              : 60,
                        ),
                      ),

                      SizedBox(width: 30,),

                      Text(
                        "Titolo libro", 
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,), 
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: isTabletOrizzontale(mediaQueryData)
                                                ? mediaQueryData.size.height * 0.04
                                                : mediaQueryData.size.height * 0.1),
                  child: Text(
                    "Inserisci il coupon del tuo libro", 
                    style: TextStyle(fontSize: 18, 
                                      fontWeight: FontWeight.bold,), 
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: isTabletOrizzontale(mediaQueryData)
                              ? mediaQueryData.size.height * 0.03
                              : mediaQueryData.size.height * 0.05,
                      left: isTabletOrizzontale(mediaQueryData)
                              ? mediaQueryData.size.width * 0.20
                              : 20,
                      right: isTabletOrizzontale(mediaQueryData)
                              ? mediaQueryData.size.width * 0.20
                              : 20),
                  child: TextFormField(
                    restorationId: 'coupon_field',
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      // focusColor: Color(0xFF0097b2),
                      labelText: 'Coupon', 
                      labelStyle: TextStyle(fontSize:  16, 
                                            color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1.5,
                        )
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1.5,
                        ),
                      ),
                      filled: true,
                      prefixIcon: Icon(Icons.book_outlined,),
                    ),
                    keyboardType: TextInputType.name,
                    autofocus: true,                    
                    onFieldSubmitted: (value) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => HomepageResponsitive(),
                        )
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}