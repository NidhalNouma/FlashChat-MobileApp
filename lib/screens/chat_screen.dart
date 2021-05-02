import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/functions/Auth.dart';
import 'package:flash_chat/functions/Messages.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'Chat';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _mymsg = Messages();
  String message;
  final messageController = TextEditingController();
  String user;

  @override
  void initState() {
    super.initState();
    user = MyAuth().getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                MyAuth().logOut(() {
                  Navigator.pop(context);
                });
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: _mymsg.msgStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final msg = snapshot.data.docs;
                  msg.sort(
                    (a, b) => b['date'].compareTo(a['date']),
                  );
                  List<MessageBubble> txtW = [];
                  for (var m in msg) {
                    final d = m.data();
                    txtW.add(
                      MessageBubble(
                        message: d['message'],
                        sender: d['user'],
                        isMe: d['user'] == user,
                      ),
                    );
                  }
                  return Expanded(
                    child: ListView(
                      reverse: true,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      children: txtW,
                    ),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                );
              },
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      onChanged: (value) {
                        this.message = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      //Implement send functionality.
                      _mymsg.add(user, message, () {
                        messageController.clear();
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String message;
  final String sender;
  final bool isMe;

  MessageBubble({this.message, this.sender, this.isMe});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            !isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Text(
            sender,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
            elevation: 3,
            color: isMe ? Colors.indigo : Colors.lightBlueAccent,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                message,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
