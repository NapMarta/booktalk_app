import 'package:booktalk_app/risolviEspressioni.dart';
import 'package:booktalk_app/utils.dart';
import 'package:booktalk_app/espressioniResponsive.dart';
import 'package:booktalk_app/widget/header.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:math_keyboard/math_keyboard.dart';

class WriteExpression extends StatefulWidget {
  const WriteExpression({Key? key}) : super(key: key);

  @override
  _WriteExpressionState createState() => _WriteExpressionState();
}

class _WriteExpressionState extends State<WriteExpression> {
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
                text: "Equazione matematica",
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
                  padding: EdgeInsets.only(top: mediaQueryData.size.height * 0.1),
                  child: Text(
                    "Inserisci un'equazione", 
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,), 
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: mediaQueryData.size.height * 0.1,
                      left: 20,
                      right: 20),
                  child: MathField(
                    keyboardType: MathKeyboardType
                        .expression, // Specify the keyboard type (expression or number only).
                    variables: const [
                      'x',
                      '=',
                    ], // Specify the variables the user can use (only in expression mode).
                    decoration: const InputDecoration(
                      labelText: 'Equazione',
                      fillColor: Colors.white,
                      labelStyle: TextStyle(fontSize: 16, color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.5,
                          )),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1.5,
                        ),
                      ),
                      filled: true,
                      prefixIcon: Icon(
                        Icons.calculate,
                        color: Colors.grey,
                      ),
                    ), // Decorate the input field using the familiar InputDecoration.
                    //onChanged: (String value) {}, // Respond to changes in the input field.

                    onSubmitted: (value) {
                      print(value);

                      /*final mathExpression = TeXParser(value).parse();
                      final texNode = convertMathExpressionToTeXNode(mathExpression);
                      print(mathExpression);
                      */

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => GetExpression(exp: value),
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
