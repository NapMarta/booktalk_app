import 'package:booktalk_app/homepageResponsive.dart';
import 'package:flutter/material.dart';
    
class ErrorAlertPageIsbn extends StatefulWidget {

  final String text;

  const ErrorAlertPageIsbn({Key? key, required this.text}) : super(key: key);

  @override
  _ErrorAlertPageIsbnState createState() => _ErrorAlertPageIsbnState();
}

class _ErrorAlertPageIsbnState extends State<ErrorAlertPageIsbn> {
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
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HomepageResponsitive(),
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
      ),
    );
  }
}