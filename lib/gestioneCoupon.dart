import 'dart:convert';
import 'dart:io';
import 'package:booktalk_app/aggiuntaLibroResponsive.dart';
import 'package:booktalk_app/widget/header.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async' show Future, runZonedGuarded;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';

Future<void> verificaCoupon(String isbn, String coupon) async {
  WidgetsFlutterBinding.ensureInitialized();

  //Prendere i parametri isbn e coupon da quelli che ha inserito l'utente
  //String isbn = '8806134965';
  //String coupon = 'A45DF3';

  final url = 'http://130.61.22.178:9000/verificaCoupon';

  final response = await http.post(Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'isbn': isbn, 'coupon': coupon}));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    if (data['result']) {
      print('Il libro è supportato e il codice coupon è valido.');
      //Aggiungere il libro al database e messaggio di conferma
    } else {
      print('Libro attualmente non supportato o codice coupon non valido.');
      //Stampare messaggio di errore
    }
  } else {
    throw Exception('Errore durante la richiesta HTTP');
  }
}
