import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_core/firebase_core.dart";

class WeekTemplates {
  CollectionReference _db =
      FirebaseFirestore.instance.collection("weektemplates");

  Future getSnapshotDefault() async {
    return await _db.doc("default").get();
  }

  Future getSnapshotExceptions() async {
    return await _db.doc("exceptions").get();
  }
}
