import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:modul7_3/model/person_message.dart';

import '../../model/group_message.dart';

class ChatService extends ChangeNotifier{
  // get instance of  firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // get group message
  Stream<QuerySnapshot> getGroupMessage(String groupId) {
    return _firestore
        .collection('group_chat_room')
        .doc(groupId)
        .collection('message')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  // send group message
  Future<void> sendGroupMessage(String groupId, senderId, message) async {
    final timestamp = Timestamp.now();
    final data = await FirebaseFirestore.instance.collection('users').doc(senderId).get();
    final String name = data.get('name');
    GroupMessage newMessage = GroupMessage(
        senderId: senderId,
        name: name,
        message: message,
        timestamp: timestamp);
    await _firestore
        .collection("group_chat_room")
        .doc(groupId)
        .collection('message')
        .add(newMessage.toMap());
  }

  // get person message
  Stream<QuerySnapshot> getPersonMessage(String senderId, receiverId) {
    List<String> ids = [senderId, receiverId];
    ids.sort();
    String PersonChatRoomId = ids.join('_');
    return _firestore
        .collection('person_chat_room')
        .doc(PersonChatRoomId)
        .collection('message')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  // send person message
  Future<void> sendPersonMessage(String senderId, receiverId, message) async {
    // get current user info

    final men = await _firestore.collection('users').doc(senderId).get();
    final String name = men.get('name');
    Timestamp timestamp = Timestamp.now();

    PersonMessage newMassage = PersonMessage(
        senderId: senderId,
        senderName: name,
        receiverId: receiverId,
        message: message,
        timestamp: timestamp);

    List<String> ids = [senderId, receiverId];
    ids.sort();
    String PersonChatRoomId = ids.join('_');
    await _firestore
        .collection('person_chat_room')
        .doc(PersonChatRoomId)
        .collection('message')
        .add(newMassage.toMap());
  }
}
