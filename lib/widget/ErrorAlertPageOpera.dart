import 'package:flutter/material.dart';
    
class ErrorAlertPageOpera extends StatefulWidget {

  final String text;

  const ErrorAlertPageOpera({Key? key, required this.text}) : super(key: key);

  @override
  _ErrorAlertPageState createState() => _ErrorAlertPageState();
}

class _ErrorAlertPageState extends State<ErrorAlertPageOpera> {
  @override
  Widget build(BuildContext context) {
    
    return WillPopScope(
      onWillPop: () async {
          Navigator.of(context).pop();
          Navigator.pop(context);
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
                  Navigator.pop(context);
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