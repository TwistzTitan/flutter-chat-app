import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';

final auth = FirebaseAuth.instance;
final store = FirebaseFirestore.instance;


class ChatScreen extends StatefulWidget {
  static final String routeID = "ChatScreen";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final textChatController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              tooltip: 'Sair',
              icon: Icon(Icons.close),
              onPressed: () async{
                await auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.black54,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Container(
                decoration: kMessageContainerDecoration,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: NowChatMessages()
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            onChanged: (value) {
                              //Do something with the user input.
                            },
                            keyboardAppearance: Brightness.dark,
                            keyboardType: TextInputType.multiline,
                            decoration: kMessageTextFieldDecoration,
                            controller: textChatController,
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () {
                            if(textChatController.text.isNotEmpty){
                              store.collection("chatMessages").add({"sender": auth.currentUser.email, "text": textChatController.text});
                              textChatController.clear();
                            }
                          },
                          child: Text(
                            'Enviar',
                            style: kSendButtonTextStyle,
                            
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NowChatMessages extends StatefulWidget {
  @override
  _NowChatMessagesState createState() => _NowChatMessagesState();
}

class _NowChatMessagesState extends State<NowChatMessages> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: store.collection('chatMessages').snapshots(),
      builder: (context, qSnap){
       if(qSnap.hasData){
         List<Widget> chatMessages = [];
         var messageChat;
         for (var item in qSnap.data.docs.reversed){
            bool isMe = item.data()["sender"] == auth.currentUser.email ;
            messageChat = Column(
              crossAxisAlignment: isMe? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:8.0),
                  child: Text(item.data()["sender"]+" :"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: isMe ? Colors.white38 : Colors.deepOrangeAccent,
                    shadowColor: Colors.black,
                    elevation: 5.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                              item.data()["text"],
                              style: TextStyle(
                                color: isMe? Colors.white : Colors.white,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            );
           chatMessages.add(messageChat);  
         }
         chatMessages.reversed;
         return ListView(
           children: chatMessages,
           reverse: true,
           );
       }
       else{
         return Center(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               CircularProgressIndicator(
                 backgroundColor: Colors.orange,
               ),
               Text('Entrando no chat', 
                style: TextStyle(color: Colors.white38),
              )
             ],
           ),
         );
       }
      },
    );
  }
}
