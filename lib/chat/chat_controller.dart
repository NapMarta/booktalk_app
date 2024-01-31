import 'package:booktalk_app/chat/chat.dart';
import 'package:booktalk_app/chat/chat_message_type.dart';
import 'package:flutter/material.dart';
import 'chatPDF.dart';

class ChatController extends ChangeNotifier {

  List<Chat> chatList = [
    Chat(
        message: "Indica la pagina iniziale dell'argomento che vuoi ripetere",
        type: ChatMessageType.received,
        time: DateTime.now(),
      ),
  ];

  ChatPDF chat = ChatPDF();


  late final ScrollController scrollController = ScrollController();
  late TextEditingController textEditingController =
      TextEditingController();
  late final FocusNode focusNode = FocusNode();
  bool isProcessing = false; 
  bool isFirstResponse = true;
  bool isSecondResponse = false;
  List<int> pages = [0,0];
  List<String> domande = [];
  int numDomanda = -1;
  bool messaggioRipetizione = false;

  Future<void> onFieldSubmitted() async {
    if (!isTextFieldEnable || isProcessing) return;

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
          Future<String> risposta = chat.askChatPDF("Fammi due domande per ripetere questo argomento", pages);

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
            domande = estraiDomande(value);
            numDomanda=0;

            chatList.removeLast();
            chatList = [
              ...chatList,
              Chat(
                message: domande[numDomanda],
                type: ChatMessageType.received,
                time: DateTime.now(),
              ),
            ];
            numDomanda++;
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
        if (richiesta == "non lo so"){
          if (numDomanda -1 < domande.length)
            richiesta = domande[numDomanda-1];
          else
            richiesta = domande[numDomanda-2];
        }
        else if (richiesta == "no" && messaggioRipetizione){
          chatList = [
            ...chatList,
            Chat(
              message: "Ciao, buono studio!",
              type: ChatMessageType.received,
              time: DateTime.now(),
            ),
          ];
          notifyListeners();
          isProcessing = false;
          return;
        }
        else if (richiesta == "si" && messaggioRipetizione){
          chatList = [
            ...chatList,
            Chat(
              message: "Fammi la domanda che vuoi",
              type: ChatMessageType.received,
              time: DateTime.now(),
            ),
          ];
          notifyListeners();
          isProcessing = false;
          return;
        }
        else{
          richiesta = richiesta+"?";
        }
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

          if(numDomanda<domande.length){

            chatList = [
                ...chatList,
                Chat(
                  message: domande[numDomanda],
                  type: ChatMessageType.received,
                  time: DateTime.now(),
                ),
            ];
              numDomanda++;
              notifyListeners();
              isProcessing = false;
          }
          else{
            if (!messaggioRipetizione){
              chatList = [
                  ...chatList,
                  Chat(
                    message: "Hai terminato la ripetizione, hai qualche altra domanda da pormi?",
                    type: ChatMessageType.received,
                    time: DateTime.now(),
                  ),
              ];
                notifyListeners();
                messaggioRipetizione = true;
            }
            isProcessing = false;
          }
        });
      }
    }
  }

  /* Getters */
  bool get isTextFieldEnable => textEditingController.text.isNotEmpty;
}

  List<String> estraiDomande (String value){

    RegExp regex = RegExp(r'\d+\.\s(.*?\?)');
    Iterable<RegExpMatch> matches = regex.allMatches(value);

    List<String> questions = [];
    for (RegExpMatch match in matches) {
      questions.add(match.group(1)!);
    }

    return questions;
  }