import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseService {
  void sendMessage(String groupId, Map<String, dynamic> chatMessageMap) {
    FirebaseFirestore.instance.collection("groups").doc(groupId)
        .collection("messages").add(chatMessageMap);
    FirebaseFirestore.instance.collection("groups").doc(groupId)
    .update({
      'recentMessage': "test11",
      'recentMessageSender': 'sender',
      'recentMessageTime': new DateTime(2000).toString(),
    });
  }

  getChats(String groupId) {
    return FirebaseFirestore.instance.collection('groups').doc(groupId).collection('messages').snapshots();
  }
  
}