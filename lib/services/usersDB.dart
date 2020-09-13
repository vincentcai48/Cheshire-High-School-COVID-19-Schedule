import "package:firebase_core/firebase_core.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:flutterfirebasetutorial/models/singleclass.dart';

class UsersDB {
  CollectionReference _db = FirebaseFirestore.instance.collection("users");

  Stream get getSnapshotStream {
    return _db.snapshots();
  }

  Future deleteClass({docId: String, userId: String}) {
    return _db.doc(userId).collection("classes").doc(docId).delete();
  }

  Future addClass({className: SingleClass, userId: String}) {
    _db.doc(userId).collection("classes").add({
      "title": className.title,
      "teacher": className.teacher,
      "room": className.room,
      "periods": className.periods,
      "description": className.description,
      "color": className.color
    }).then((value) {
      return "Successfully Added";
    }).catchError((error) {
      return error;
    });
  }

  Future updateClass(
      {className: SingleClass, userId: String, docId: String}) async {
    print(className.toString());
    try {
      await _db.doc(userId).collection("classes").doc(docId).set({
        "title": className.title,
        "teacher": className.teacher,
        "room": className.room,
        "periods": className.periods,
        "description": className.description,
        "color": className.color
      });
      return "Successfully updated";
    } catch (e) {
      print(e);
      return null;
    }
  }

  Stream getAllClasses({userId: String}) {
    return _db.doc(userId).collection("classes").orderBy('periods').snapshots();
  }
}
