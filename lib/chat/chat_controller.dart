import 'package:booktalk_app/chat/chat.dart';
import 'package:booktalk_app/chat/chat_message_type.dart';
import 'package:flutter/material.dart';
import 'chatPDF.dart';

class ChatController extends ChangeNotifier {
  /* Variables */
  List<Chat> chatList = [
    Chat(
        message: "Indica la pagina iniziale dell'argomento che vuoi ripetere",
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
  bool isFirstResponse = true;
  bool isSecondResponse = false;
  List<int> pages = [0,0];

  /* Intents */
  Future<void> onFieldSubmitted() async {
    if (!isTextFieldEnable || isProcessing) return;

    // 1. chat list에 첫 번째 배열 위치에 put
    chatList = [
      ...chatList,
      Chat.sent(message: textEditingController.text),
    ];

    if(isFirstResponse){
      try{
        pages[0] = int.parse(textEditingController.text);
      }
      on Exception catch(e){
        print(e);
        textEditingController.text= "erroreINT";
      }
    }
    if (isSecondResponse){
      try{
        pages[1] = int.parse(textEditingController.text);
        print(pages);
      }
      on Exception catch(e){
        print(e);
        textEditingController.text= "erroreINT";
      }
    }

    String richiesta = textEditingController.text.replaceAll("libro", "PDF");
    richiesta = textEditingController.text.replaceAll("opera", "PDF");
    richiesta = textEditingController.text.replaceAll("testo", "PDF");
    richiesta = textEditingController.text.replaceAll("opera letteraria", "PDF");
    scriviRisposta(richiesta);

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
    if (richiesta == "erroreINT"){
      chatList = [
        ...chatList,
        Chat(
          message: "Scrivi solo il numero di pagina.\n Es. 20",
          type: ChatMessageType.received,
          time: DateTime.now(),
        ),
      ];
      notifyListeners();
      isProcessing= false;
    }
    else{
      if (isFirstResponse){
        if(pages[0]<0){
          chatList = [
            ...chatList,
            Chat(
              message: "Scrivi un valore corretto per la pagina iniziale",
              type: ChatMessageType.received,
              time: DateTime.now(),
            ),
          ];
          isFirstResponse = true;
          isSecondResponse = false;
          isProcessing= false;
          notifyListeners();
        }
        else{
          chatList = [
            ...chatList,
            Chat(
              message: "Scrivi la pagina finale dell'argomento che vuoi ripetere",
              type: ChatMessageType.received,
              time: DateTime.now(),
            ),
          ];
          isFirstResponse = false;
          isSecondResponse = true;
          isProcessing= false;
          notifyListeners();
        }
      }
      else if (isSecondResponse){
        if(pages[1]>= pages[0]){
          Future<String> risposta = chat.askChatPDF("Fammi una domanda per ripetere questo argomento", pages);

          chatList = [
              ...chatList,
              Chat(
                message: "Sto elaborando la risposta...",
                type: ChatMessageType.received,
                time: DateTime.now(),
              ),
          ];

          risposta.then((value) {
            value = value.replaceAll('PDF', 'libro');
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
            isSecondResponse = false;
          });
        }
        else{
          chatList = [
            ...chatList,
            Chat(
              message: "Scrivi un valore corretto per la pagina finale",
              type: ChatMessageType.received,
              time: DateTime.now(),
            ),
          ];
          isSecondResponse = true;
          isProcessing= false;
          notifyListeners();
        }
      }
      else{
        richiesta = richiesta+"?";
        Future<String> risposta = chat.askChatPDF(richiesta, pages);

        chatList = [
            ...chatList,
            Chat(
              message: "Sto elaborando la risposta...",
              type: ChatMessageType.received,
              time: DateTime.now(),
            ),
        ];

        risposta.then((value) {
          value = value.replaceAll('PDF', 'libro');
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

          richiesta = "fammi un'altra domanda per ripetere questo argomento";
          risposta = chat.askChatPDF(richiesta, pages);
          risposta.then((value) {
            value = value.replaceAll('PDF', 'libro');
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
        });
      }
    }
  }

  /* Getters */
  bool get isTextFieldEnable => textEditingController.text.isNotEmpty;
}
