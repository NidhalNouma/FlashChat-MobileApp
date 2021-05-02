import 'package:cloud_firestore/cloud_firestore.dart';

class Messages {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void add(String user, String msg, Function fn) async {
    await _firestore.collection('messages').add({
      'user': user,
      'message': msg,
      'date': DateTime.now(),
    });
    fn();
  }

  void getMessages() async {
    final msgs = await _firestore.collection('messages').get();
    var docs = msgs.docs;

    for (var d in docs) {
      print(d.data());
    }
  }

  Stream<QuerySnapshot> msgStream() {
    // await for(var doc in _firestore.collection('messages').snapshots())
    // {
    //   for(var d in doc.docs){
    //     print(d.data());
    //   }
    // }

    return _firestore.collection('messages').snapshots();
  }
}
