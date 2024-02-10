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
    return WillPopScope(
      onWillPop: () async {
          Navigator.of(context).pop();
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => WriteExpression(),
            ),
            (route) => true,
          );
        return false;
        
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 201, 201, 201),
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
                  Navigator.of(context).pop();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => WriteExpression(),
                    ),
                    (route) => true,
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
      ),
    );
  }
}