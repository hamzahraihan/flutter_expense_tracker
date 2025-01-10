import 'package:cloud_firestore/cloud_firestore.dart';

// TODO create a firebase services model

FirebaseFirestore db = FirebaseFirestore.instance;

Future<DocumentSnapshot> retrieveData(String collectionName) async {
  CollectionReference data =
      FirebaseFirestore.instance.collection(collectionName);
  return data.doc().get();
}
