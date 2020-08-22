import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_learning/model/brew.dart';
import 'package:firebase_learning/model/user.dart';

class  DatabaseService{

  final String uid;

  DatabaseService({this.uid});

  //collection refrenec
  final CollectionReference brewCollection  = Firestore.instance.collection('brews');

  Future updateUserData(String sugars, String name,int strength) async {
    return await brewCollection.document(uid).setData({
      'sugars' : sugars,
      'name' : name,
      'streght': strength
    });
  }

  //brew list from snapshot
  List<Brew> _brewListSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Brew(
        name: doc.data['name'] ?? "",
        strength:  doc.data['streght'] ?? 0,
        sugars:  doc.data["sugars"] ?? '0',
      );
    }).toList();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data['name'],
        sugars: snapshot.data['sugars'],
        strength: snapshot.data['streght']
    );
  }

   // get brews stream
  Stream<List<Brew>> get brews{
    return brewCollection.snapshots().map(_brewListSnapshot);
  }

  //get user doc stream
Stream<UserData> get userData{
    return brewCollection.document(uid).snapshots()
    .map(_userDataFromSnapshot);
}

}