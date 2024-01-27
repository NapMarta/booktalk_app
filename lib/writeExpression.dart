import 'package:booktalk_app/widget/espressioniResponsive.dart';
import 'package:booktalk_app/widget/header.dart';
import 'package:flutter/material.dart';
import 'package:math_keyboard/math_keyboard.dart';
    
class WriteExpression extends StatefulWidget {
  const WriteExpression({Key? key}) : super(key: key);

  @override
  _WriteExpressionState createState() => _WriteExpressionState();
}

class _WriteExpressionState extends State<WriteExpression> {
  @override
  Widget build(BuildContext context) {
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
                text: "Inserisci l'espressione matematica",
                isHomePage: false,
                isProfilo: false,
              ),
            ),
            backgroundColor: Colors.white,
            body: ListView(
              children: [
                /*
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: TextField(),
                ),*/
                Padding(
                  padding: EdgeInsets.all(16),
                  child: MathField(
                    keyboardType: MathKeyboardType.expression, // Specify the keyboard type (expression or number only).
                    variables: const ['x', '='], // Specify the variables the user can use (only in expression mode).
                    decoration: const InputDecoration(), // Decorate the input field using the familiar InputDecoration.
                    //onChanged: (String value) {}, // Respond to changes in the input field.
                    
                    onSubmitted: (value) {
                      print(value);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EspressioniResponsive(value: value),
                        ),
                      );
                    },
                    
                    autofocus: true,
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
