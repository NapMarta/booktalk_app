import 'package:booktalk_app/writeExpression.dart';
import 'package:flutter/material.dart';
    
class ErrorAlertPage extends StatefulWidget {

  final String text;

  const ErrorAlertPage({Key? key, required this.text}) : super(key: key);

  @override
  _ErrorAlertPageState createState() => _ErrorAlertPageState();
}

class _ErrorAlertPageState extends State<ErrorAlertPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AlertDialog(
          title: Text(
            'Errore', 
            style: TextStyle(color: Colors.red),
          ),
          content: Text(
            widget.text,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Torna alla pagina precedente
                /*
                    RIMOZIONE INDIETRO
                */
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => WriteExpression(),
                  ),
                ); 
              },
              child: Text(
                'OK', 
                style: TextStyle(
                    color: Colors.black, 
                    fontWeight: FontWeight.bold,
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}