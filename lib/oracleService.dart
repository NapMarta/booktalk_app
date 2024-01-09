import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Query Results'),
        ),
        body: FutureBuilder<List<dynamic>>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<dynamic> resultData = snapshot.data!;
              return ListView.builder(
                itemCount: resultData.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(resultData[index]['nome']),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Future<List<dynamic>> fetchData() async {
    final response = await http.get(Uri.parse('http://130.61.22.178:9000/selectUtente'));

    if (response.statusCode == 200) {
      // Verifica il tipo di contenuto della risposta
      if (response.headers['content-type']?.contains('application/json') ?? false) {
        List<dynamic> resultData = json.decode(response.body) as List<dynamic>;
        return resultData;
      } else {
        throw Exception('Unexpected content type: ${response.headers['content-type']}');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }
}