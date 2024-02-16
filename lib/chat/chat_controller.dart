import 'package:booktalk_app/chat/chat.dart';
import 'package:booktalk_app/chat/chat_message_type.dart';
import 'package:flutter/material.dart';
import 'chatPDF.dart';

class ChatController extends ChangeNotifier {

  List<Chat> chatList = [
    Chat(
        message: "Quale capitolo del libro vuoi ripetere?",
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
  int capitolo = -1;
  List<String> domande = [];
  int domandeTot = -1;
  int numDomanda = -1;
  bool messaggioRipetizione = false;
  String libro ="";

  Future<void> onFieldSubmitted() async {
    if (!isTextFieldEnable || isProcessing) return;

    chatList = [
      ...chatList,
      Chat.sent(message: textEditingController.text),
    ];

    if(isFirstResponse){
      try{
        capitolo = int.parse(textEditingController.text);
      }
      on Exception catch(e){
        print(e);
        textEditingController.text= "erroreINT_CAPITOLO";
      }
    }
    if (isSecondResponse){
      try{
        domandeTot = int.parse(textEditingController.text);
      }
      on Exception catch(e){
        print(e);
        textEditingController.text= "erroreINT_DOMANDE";
      }
    }

    String richiesta = textEditingController.text.replaceAll("libro", "PDF");
    richiesta = textEditingController.text.replaceAll("opera", "PDF");
    richiesta = textEditingController.text.replaceAll("testo", "PDF");
    richiesta = textEditingController.text.replaceAll("capitolo", "PDF");
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
    if (richiesta == "erroreINT_CAPITOLO"){
      chatList = [
        ...chatList,
        Chat(
          message: "Scrivi solo il numero del capitolo che vuoi ripetere. Es. 4",
          type: ChatMessageType.received,
          time: DateTime.now(),
        ),
      ];
      notifyListeners();
      isProcessing= false;
    }
    else if (richiesta == "erroreINT_DOMANDE"){
      chatList = [
        ...chatList,
        Chat(
          message: "Scrivi solo il numero di domande che vuoi ricevere. Es. 5",
          type: ChatMessageType.received,
          time: DateTime.now(),
        ),
      ];
      notifyListeners();
      isProcessing= false;
    }
    else{
      if (isFirstResponse){
        String path = "$libro/$capitolo.pdf";
        if(capitolo<0){
          chatList = [
            ...chatList,
            Chat(
              message: "Scrivi un valore corretto per il capitolo da ripetere.",
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
                  message: "...",
                  type: ChatMessageType.received,
                  time: DateTime.now(),
                ),
          ];
        }
        Future<bool> isCapitoloOK = chat.uploadPDF(path);

        isCapitoloOK.then((value) {

          if(!value){
            chatList.removeLast();
            chatList = [
              ...chatList,
              Chat(
                message: "Scrivi un valore corretto per il capitolo da ripetere.",
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
            chatList.removeLast();
            chatList = [
              ...chatList,
              Chat(
                message: "Quante domande vuoi ricevere per ripetere questo capitolo?",
                type: ChatMessageType.received,
                time: DateTime.now(),
              ),
            ];
            isFirstResponse = false;
            domande = [];
            numDomanda = 0;
            isSecondResponse = true;
            isProcessing= false;
            notifyListeners();
          }
        });
      }
      else if (isSecondResponse){
        if(domandeTot>1 && domandeTot<11){

          Future<String> risposta = chat.askChatPDF("Fammi $domandeTot domande per ripetere questo argomento");

          chatList = [
              ...chatList,
              Chat(
                message: "...",
                type: ChatMessageType.received,
                time: DateTime.now(),
              ),
          ];

          risposta.then((value) {
            value = value.replaceAll('PDF', 'capitolo');
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
              message: "Scrivi un valore corretto per il numero di domande che vuoi ricevere.\nIl numero deve essere compreso tra 2 e 10.",
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
        if (richiesta.contains("non lo so")|| richiesta.contains("RISPOSTA") || richiesta.contains("Risposta") || richiesta.contains("risposta") || richiesta.contains("boh") || richiesta.contains("bho") || richiesta.contains("Boh") || richiesta.contains("Bho") || richiesta.contains("non mi ricordo") || richiesta.contains("Non lo so")){
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
        else if ((richiesta == "si" || richiesta == "Si" || richiesta == "Sì" || richiesta == "sì" || richiesta == "SI")&& messaggioRipetizione){
          chatList = [
            ...chatList,
            Chat(
              message: "Quante domande vuoi ricevere per la tua ripetizione?",
              type: ChatMessageType.received,
              time: DateTime.now(),
            ),
          ];
          notifyListeners();
          isSecondResponse = true;
          messaggioRipetizione = false;
          isProcessing = false;
          return;
        }
        else{
          richiesta = richiesta+"?";
        }
        Future<String> risposta = chat.askChatPDF(richiesta);

        chatList = [
            ...chatList,
            Chat(
              message: "...",
              type: ChatMessageType.received,
              time: DateTime.now(),
            ),
        ];

        risposta.then((value) {
          value = value.replaceAll('PDF', 'capitolo');
          chatList.removeLast();
          if (value.startsWith("Mi dispiace") && numDomanda < domandeTot){
            value= "Prova a scrivere una risposta più completa in modo che possa correggerti.\nPer conoscere la risposta esatta digita 'RISPOSTA'";
            numDomanda--;
          }
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
                    message: "Hai terminato la ripetizione, vuoi ricevere altre domande per ripetere questo capitolo?",
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

  void setLibro(String s) {
    this.libro = s;
  }
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