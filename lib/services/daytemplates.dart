import "package:firebase_core/firebase_core.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class DayTemplates {
  CollectionReference _db =
      FirebaseFirestore.instance.collection("daytemplates");

  Future getSnapshotStream(String n) async {
    return await _db.doc(n).get();
  }
}
