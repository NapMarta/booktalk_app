
import 'package:booktalk_app/chat/bubble.dart';
import 'package:booktalk_app/chat/chat.dart';
import 'package:booktalk_app/chat/chat_controller.dart';
import 'package:booktalk_app/widget/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);
  @override
  _ChatScreen createState() => _ChatScreen();
}

class _ChatScreen  extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: true,
      right: true,
      bottom: false,
      top: true,
      child: Stack(
        alignment: Alignment.center,
        children: [
          /* 
          // sfondo
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/sfondo2.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          */
          Scaffold(
            resizeToAvoidBottomInset: true,
            // backgroundColor: Colors.transparent,
            backgroundColor: Colors.white,

            //  -----HEADER -----
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: Header(
                iconProfile: Image.asset('assets/person-icon.png'),
                text: "Supporto al Learning",
                isHomePage: false,
                isProfilo: false,
              ),
            ),
            
            body: Column(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      context.read<ChatController>().focusNode.unfocus();
                    },
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Selector<ChatController, List<Chat>>(
                        selector: (context, controller) =>
                            controller.chatList.reversed.toList(),
                        builder: (context, chatList, child) {
                          return ListView.separated(
                            shrinkWrap: true,
                            reverse: true,
                            padding: const EdgeInsets.only(top: 12, bottom: 20) +
                                const EdgeInsets.symmetric(horizontal: 12),
                            separatorBuilder: (_, __) => const SizedBox(
                              height: 12,
                            ),
                            controller:
                                context.read<ChatController>().scrollController,
                            itemCount: chatList.length,
                            itemBuilder: (context, index) {
                              return Bubble(chat: chatList[index]);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const _BottomInputField(),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
}

/// Bottom Fixed Filed
class _BottomInputField extends StatelessWidget {
  const _BottomInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Container(
        // non si può mettere una dimensione fissa, così aumenta la dimensione del
        constraints: const BoxConstraints(minHeight: 48),
        width: double.infinity,
        /*
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color(0xFFE5E5EA),
            ),
          ),
        ), 
        */
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 3, bottom: 4),
          child: TextField(
            focusNode: context.read<ChatController>().focusNode,
            onChanged: context.read<ChatController>().onFieldChanged,
            controller: context.read<ChatController>().textEditingController,
            maxLines: null,
            textAlignVertical: TextAlignVertical.top,
            decoration: InputDecoration(
              
              contentPadding: const EdgeInsets.only(
                right: 42,
                left: 16,
                top: 18,
              ),
              hintText: 'Messaggio',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: Color(0xFFE5E5EA),
                  width: 1,
                )
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: Color(0xFFE5E5EA),
                  width: 1,
                )
              ),
              suffixIcon: IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/send.svg",
                  colorFilter: ColorFilter.mode(
                    context.select<ChatController, bool>(
                            (value) => value.isTextFieldEnable)
                        ? const Color(0xFF0097b2)
                        : const Color(0xFFBDBDC2),
                    BlendMode.srcIn,
                  ),
                ),
                onPressed: context.read<ChatController>().onFieldSubmitted,
              ),
              fillColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
