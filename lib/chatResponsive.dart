import 'dart:io';

import 'package:booktalk_app/business_logic/monitoraggioStatistiche.dart';
import 'package:booktalk_app/chat/chat_controller.dart';
import 'package:booktalk_app/chat_screen.dart';
import 'package:booktalk_app/storage/libro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
    
class ChatResponsive extends StatefulWidget {
  final Libro libro;

  const ChatResponsive({Key? key, required this.libro}) : super(key: key);

  @override
  _ChatResponsiveState createState() => _ChatResponsiveState();
}

class _ChatResponsiveState extends State<ChatResponsive> {
  MonitoraggioStatistiche monitoraggioStatistiche = MonitoraggioStatistiche.instance;

  @override
  void initState(){
    super.initState();
    print(widget.libro.isbn);
    monitoraggioStatistiche.incrementaFunz3();
    monitoraggioStatistiche.aggiungiClickLibro(widget.libro.isbn);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ChatController(),
        child: ChatScreen(libro: widget.libro!.titolo),
      );
  }
}