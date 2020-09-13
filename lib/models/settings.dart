import "package:flutter/material.dart";
import "package:firebase_core/firebase_core.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class SettingsList {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.yellow,
    Colors.pink,
    Colors.grey,
  ];

  List<String> classPeriods = [
    "1A",
    "1C",
    "1D",
    "2A",
    "2B",
    "2D",
    "3A",
    "3B",
    "3C",
    "4B",
    "4C",
    "4D",
    "5A",
    "5C",
    "5D",
    "6A",
    "6B",
    "6D",
    "7A",
    "7B",
    "7C",
    "8B",
    "8C",
    "8D",
    "Advisory",
    "Lunch",
    "Office Hours"
  ];

  List weekdays = [
    "",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  List get weekdaysList {
    return weekdays;
  }

  Future get firstMonday async {
    DocumentSnapshot doc =
        await _firestore.collection("settings").doc("onedocument").get();
    Map data = doc.data()["firstMonday"];
    return DateTime.utc(data["year"], data["month"], data["day"]);
  }

  List<Color> get colorsList {
    return colors;
  }

  void hello() {
    print("hello");
  }
}
