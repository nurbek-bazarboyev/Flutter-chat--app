import 'package:cloud_firestore/cloud_firestore.dart';

class GroupMessage{
  final String senderId;
  final String name;
  final String message;
  final Timestamp timestamp;
  GroupMessage({
  required this.senderId,
  required this.name,
  required this.message,
  required this.timestamp
});

  Map<String, dynamic> toMap(){
    return {
      'senderId':senderId,
      'name':name,
      'message':message,
      'timestamp':timestamp
    };
  }
}