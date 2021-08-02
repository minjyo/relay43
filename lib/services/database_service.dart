import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseService {
  final CollectionReference groupCollection = FirebaseFirestore.instance.collection('groups');
  
  // 그룹을 새로 만들고, 해당 그룹의 groupId를 반환
  Future createGroup(String userEmail) async{
    DocumentReference groupDocRef = await groupCollection.add({
      'groupId': '',
      'admin': userEmail,
      'members': []
    });
    
    await groupDocRef.update({
      'members': FieldValue.arrayUnion([userEmail]),
      'groupId': groupDocRef.id
    });
    
    return groupDocRef.id;
  }
  
  // 그룹에 참가함
  Future joinGroup(String groupId, String userEmail) async{
    DocumentReference groupDocRef = groupCollection.doc(groupId);
    
    await groupDocRef.update({
      'members': FieldValue.arrayUnion([userEmail])
    });
    
    return true;
  }
  exitGroup(String groupId, String userEmail) async {
    DocumentReference groupDocRef = groupCollection.doc(groupId);


    await groupDocRef.update({
      'members': FieldValue.arrayRemove([userEmail])
    });
    
    Map<String, dynamic> data = (await groupDocRef.get()).data() as Map<String, dynamic>;
    if (data['members'].length <= 0){
      deleteGroup(groupId);
    }
  }
  
  // 그룹이 존재하는지 여부를 반환한다.
  Future groupExists(String groupId) async{
    DocumentReference groupDocRef = groupCollection.doc(groupId);
    
    return (await groupDocRef.get()).exists;
  }
  
  // 그룹을 제거함
  deleteGroup(String groupId) {
    groupCollection.doc(groupId).collection('messages').get()
    .then((snapshot){
      snapshot.docs.forEach((element) {
        element.reference.delete();
      });
    });
    groupCollection.doc(groupId).delete();
  }
  
  // 해당 그룹 채팅방에 참가하고 있는 사용자명 배열을 반환함
  Future<dynamic> getUserInGroup(String groupId, String userEmail) async{
    var documentSnapshot = await groupCollection.doc(groupId).get();
    
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    return data['members'];
  }
  
  // groupId 채팅방에 Message를 보낸다.
  void sendMessage(String groupId, Map<String, dynamic> chatMessageMap) {
    // 해당 그룹의 메시지 콜렉션에 메시지를 추가한다.
    groupCollection.doc(groupId).collection("messages").add(chatMessageMap);
  }

  // groupId 채팅방의 Message를 가져온다.
  // Stream 형태로 가져온다.
  Stream<QuerySnapshot> getChats(String groupId) {
    return groupCollection.doc(groupId)
        .collection('messages').orderBy("time").snapshots();
  }
  
}