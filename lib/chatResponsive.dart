import 'dart:io';

import 'package:booktalk_app/chat/chat_controller.dart';
import 'package:booktalk_app/chat/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
    
class ChatResponsive extends StatefulWidget {

  @override
  _ChatResponsiveState createState() => _ChatResponsiveState();
}

class _ChatResponsiveState extends State<ChatResponsive> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ChatController(),
        child: ChatScreen(),
      );
  }
}