import 'package:booktalk_app/chat/chat.dart';
import 'package:booktalk_app/chat/chat_message_type.dart';
import 'package:flutter/material.dart';
import 'chatPDF.dart';

class ChatController extends ChangeNotifier {
  /* Variables */
  List<Chat> chatList = [
    Chat(
        message: "Hello!",
        type: ChatMessageType.received,
        time: DateTime.now(),
      ),
  ];

  ChatPDF chat = ChatPDF();

  /* Controllers */
  late final ScrollController scrollController = ScrollController();
  late TextEditingController textEditingController =
      TextEditingController();
  late final FocusNode focusNode = FocusNode();
  bool isProcessing = false; 

  /* Intents */
  Future<void> onFieldSubmitted() async {
    if (!isTextFieldEnable || isProcessing) return;

    // 1. chat list에 첫 번째 배열 위치에 put
    chatList = [
      ...chatList,
      Chat.sent(message: textEditingController.text),
    ];

    scriviRisposta(textEditingController.text);

    // 2. 스크롤 최적화 위치
    // 가장 위에 스크롤 된 상태에서 채팅을 입력했을 때 최근 submit한 채팅 메세지가 보이도록
    // 스크롤 위치를 가장 아래 부분으로 변경
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    textEditingController.text = '';
    notifyListeners();
  }

  void onFieldChanged(String term) {
    notifyListeners();
  }

  void scriviRisposta (String richiesta) async{
    isProcessing = true;
    Future<String> risposta = chat.askChatPDF(richiesta);

    chatList = [
        ...chatList,
        Chat(
          message: "Sto elaborando la risposta...",
          type: ChatMessageType.received,
          time: DateTime.now(),
        ),
    ];

    risposta.then((value) {
      chatList.removeLast();
      chatList = [
        ...chatList,
        Chat(
          message: value.toString(),
          type: ChatMessageType.received,
          time: DateTime.now(),
        ),
      ];
      notifyListeners();
      isProcessing = false;
    });
  }

  /* Getters */
  bool get isTextFieldEnable => textEditingController.text.isNotEmpty;
}
