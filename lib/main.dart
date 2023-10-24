import 'package:flutter/material.dart';

void main() {
  runApp(BookTalkApp());
}

//HEADER
class BookTalkApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BookTalk',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: BookTalkHomePage(),
    );
  }
}

class BookTalkHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BookTalk'),
      ),
      body: Center(
        child: Text('Benvenuto su BookTalk!',
                  style: TextStyle(fontSize: 24.0), // Imposta la grandezza del font a 24.0
                  ),
      ),
    );
  }
}
