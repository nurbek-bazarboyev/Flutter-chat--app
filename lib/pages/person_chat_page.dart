import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:modul7_3/components/chat_bubble.dart';
import 'package:modul7_3/components/my_text_field.dart';
import 'package:modul7_3/service/chat_service/chat_service.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  final String receiverId;
  final String title;

  const ChatPage({super.key, required this.title, required this.receiverId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  int month = 0,
      day = 0,
      hour = 0,
      min = 0;

  final TextEditingController controller = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String toMonth(int month) {
    switch (month) {
      case 1:
        return "Yanvar";
      case 2:
        return "Fevral";
      case 3:
        return "Mart";
      case 4:
        return "Aprel";
      case 5:
        return "May";
      case 6:
        return "Iyun";
      case 7:
        return "Iyul";
      case 8:
        return "Avgust";
      case 9:
        return "Sentabr";
      case 10:
        return "Oktabr";
      case 11:
        return "Noyabr";
      case 12:
        return "Dekabr";
      default: return '${month}';
    }
  }

void sendMessage() async {
    //final serv = Provider.of<ChatService>(context);
    if(controller.text.isNotEmpty){
       ChatService().sendPersonMessage(
          _firebaseAuth.currentUser!.uid, widget.receiverId, controller.text);
      controller.clear();
    }
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.black,
    appBar: AppBar(
      backgroundColor: Colors.blue,
      leading: IconButton(onPressed: () {
        Navigator.pop(context);
      }, icon: Icon(CupertinoIcons.back, color: Colors.white,)),
      title: Text(widget.title, style: TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),),
    ),
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Expanded(child: _buildMessageList()),
          _buildInput()
        ],
      ),
    ),
  );

}

Widget _buildMessageList() {
  return StreamBuilder<QuerySnapshot>(
      stream: ChatService().getPersonMessage(
          _firebaseAuth.currentUser!.uid, widget.receiverId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Error ${snapshot.error}"),);
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Text("Loading.."),);
        }int count=0;
        return ListView(
          children: snapshot.data!.docs.map((document) =>
              _buildMessageListItem(document,++count)).toList(),
        );
      }
  );
}

Widget _buildMessageListItem(DocumentSnapshot document,int c) {
  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
  final String uid = _firebaseAuth.currentUser!.uid;
  bool val = uid == data['senderId'];
  var alignment = val ? Alignment.centerRight : Alignment.centerLeft;

  Timestamp timestamp = data['timestamp'];
  DateTime ts = timestamp.toDate();
  Timestamp ftimestamp = Timestamp.now();
  if(c==1){
    month = ts.month;
    day = ts.day;
    hour = ts.hour;
    min = ts.minute;

    return Column(
      children: [
        Center(
          child: Text("${ts.day}-${toMonth(ts.month)} ${ts.hour<10 ? '0${ts.hour}': ts.hour}:${ts.minute<10 ? '0${ts.minute}' : ts.minute}",style: TextStyle(color: Colors.white),),
        ),
        SizedBox(height: 20,),
        Container(
  alignment: alignment,
  decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(8),
  color: Colors.black.withOpacity(.1)
  ),
  child: val ? ChatBubble(
  name: '',
  message: data['message'],
  left: !val) : Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  mainAxisSize: MainAxisSize.min,
  children: [
  ChatBubble(
  name: '',
  message: data['message'],
  left: !val)
  ],
  ),
  ),
        SizedBox(height: 20,),
      ],
    );
  }
  if (timestamp != ftimestamp) {
    if (ts.month == month) {
      if (ts.day == day) {
        if (ts.hour == hour) {
          if (ts.minute - min >= 5) {
            min = ts.minute;
            return Column(
              children: [
                Center(
                  child: Text("${hour<10 ? '0${hour}': hour}:${min<10 ? '0${min}' : min}",style: TextStyle(color: Colors.white)),
                ),
                SizedBox(height: 20,),
                Container(
                  alignment: alignment,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black.withOpacity(.1)
                  ),
                  child: val ? ChatBubble(
                      name: '',
                      message: data['message'],
                      left: !val) : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ChatBubble(
                          name: '',
                          message: data['message'],
                          left: !val)
                    ],
                  ),
                ),
                SizedBox(height: 20,),
              ],
            );
          }
        }
        else {
          hour = ts.hour;
          min = ts.minute;
          return Column(
            children: [
              Center(
                child: Text("${hour<10 ? '0${hour}': hour}:${min<10 ? '0${min}' : min}",style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 20,),
              Container(
                alignment: alignment,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.black.withOpacity(.1)
                ),
                child: val ? ChatBubble(
                    name: '',
                    message: data['message'],
                    left: !val) : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ChatBubble(
                        name: '',
                        message: data['message'],
                        left: !val)
                  ],
                ),
              ),
              SizedBox(height: 20,),
            ],
          );
        }
      }
      else {
        month = ts.month;
        day = ts.day;
        hour = ts.hour;
        min = ts.minute;
        return Column(
          children: [
            Center(
              child: Text("${day}-${toMonth(month)} ${hour<10 ? '0${hour}': hour}:${min<10 ? '0${min}' : min}",style: TextStyle(color: Colors.white),),
            ),
            SizedBox(height: 20,),
            Container(
              alignment: alignment,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.black.withOpacity(.1)
              ),
              child: val ? ChatBubble(
                  name: '',
                  message: data['message'],
                  left: !val) : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ChatBubble(
                      name: '',
                      message: data['message'],
                      left: !val)
                ],
              ),
            ),
            SizedBox(height: 20,),
          ],
        );
      }
    }
    else {
      month = ts.month;
      day = ts.day;
      hour = ts.hour;
      min = ts.minute;
      return Column(
        children: [
          Center(
            child: Text("${day}-${toMonth(month)} ${hour<10 ? '0${hour}': hour}:${min<10 ? '0${min}' : min}",style: TextStyle(color: Colors.white),),
          ),
          SizedBox(height: 20,),
          Container(
            alignment: alignment,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black.withOpacity(.1)
            ),
            child: val ? ChatBubble(
                name: '',
                message: data['message'],
                left: !val) : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ChatBubble(
                    name: '',
                    message: data['message'],
                    left: !val)
              ],
            ),
          ),
          SizedBox(height: 20,),
        ],
      );
    }
  }

  return Container(
    alignment: alignment,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.black.withOpacity(.1)
    ),
    child: val ? ChatBubble(
        name: '',
        message: data['message'],
        left: !val) : Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ChatBubble(
            name: '',
            message: data['message'],
            left: !val)
      ],
    ),
  );
}

Widget _buildInput(){
    return Row(children: [
      Expanded(child: Container(
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey,width: 2),
          borderRadius: BorderRadius.circular(8)
        ),child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "enter message",
          hintStyle: TextStyle(color: Colors.white),
          filled: true,
          fillColor: Colors.black26
        ),
      ),
      )),
      IconButton(onPressed: sendMessage, icon: Icon(Icons.send,color: Colors.blue,size: 30,))
    ],);
}
}
