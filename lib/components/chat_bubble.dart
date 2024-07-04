import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
class ChatBubble extends StatelessWidget {
  final String name;
  final String message;
  final bool left,image;
  const ChatBubble({super.key, required this.name, required this.message, required this.left,  this.image=false});

  @override
  Widget build(BuildContext context) {
    return name=='' ? badges.Badge(
      badgeStyle: badges.BadgeStyle(
        padding: EdgeInsets.all(0)
      ),
      position: badges.BadgePosition.topEnd(top: 21, end: 24),
      badgeContent: left? (image?Container(
        height: 26,
        width: 26,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue,
        ),
      ):SizedBox()):SizedBox(),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
        margin: EdgeInsets.only(top: 5,right: left ? 40 : 0, left: left ? 0 : 40),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white.withOpacity(left ? .3 : .15)
        ),child: Column(
        crossAxisAlignment: left ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Text(message,style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w400,))
        ],
      ),
      ),
    ) :
    Container(
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
      margin: EdgeInsets.only(top: 5,right: left ? 40 : 0, left: left ? 0 : 40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white.withOpacity(left ? .3 : .15)
      ),child: Column(
      crossAxisAlignment: left ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Text(name,style: TextStyle(color: Colors.blue,fontSize: 16,fontWeight: FontWeight.w500)),
        Text(message,style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w400))
      ],
    ),
    );
  }
  bool isEmail(){
    String text = message;
    int startindex = 0,emailindex = 0;
    bool email = message.contains('@');
    if(email){
      for(int i = 0; i < message.length; i++){
        if(message[i]=='@'){
          emailindex = i;
        }
        else if(message[i] == ' '){
          startindex = i;
        }
      }
    }


    return false;
  }

}
