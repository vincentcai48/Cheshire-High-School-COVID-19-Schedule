import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:flutterfirebasetutorial/components/editClass.dart';
import 'package:flutterfirebasetutorial/models/settings.dart';
import 'package:flutterfirebasetutorial/services/auth.dart';
import 'package:flutterfirebasetutorial/services/usersDB.dart';

class SingleClassBlockEdit extends StatefulWidget {
  DocumentSnapshot doc;
  SingleClassBlockEdit({this.doc});

  @override
  _SingleClassBlockEditState createState() =>
      _SingleClassBlockEditState(doc: doc);
}

class _SingleClassBlockEditState extends State<SingleClassBlockEdit> {
  SettingsList _settings = SettingsList();
  DocumentSnapshot element;
  List<Color> colors = SettingsList().colorsList;
  Map obj;
  String docId;
  bool showEdit = false;
  bool showWaitMessage = false;

  void toggleShowEdit() {
    setState(() {
      showEdit = !showEdit;
    });
  }

  void showWaitMessageFunction() {
    setState(() {
      showWaitMessage = true;
    });
  }

  _SingleClassBlockEditState({doc: DocumentSnapshot}) {
    element = doc;
    obj = doc.data();
    docId = doc.id;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: obj["color"] == null ? Colors.red : colors[obj["color"]],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: Column(
        children: <Widget>[
          showWaitMessage
              ? Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Text(
                    "Refresh to See Updates",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ))
              : Text(""),
          Row(
            children: <Widget>[
              Text(obj["title"],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  setState(() {
                    showEdit = !showEdit;
                  });
                },
              ),
              Expanded(
                child: Text(""),
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  showWaitMessageFunction();
                  UsersDB().deleteClass(
                      userId: Auth().currentUser.uid, docId: docId);
                },
              )
            ],
          ),
          Row(
            children: <Widget>[
              obj["room"] != ""
                  ? Text("Room " + obj["room"])
                  : SizedBox(
                      height: 0,
                    ),
              obj["room"] != ""
                  ? SizedBox(
                      width: 20,
                    )
                  : SizedBox(
                      height: 0,
                    ),
              obj["teacher"] != ""
                  ? Text(
                      "Teacher: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  : SizedBox(
                      height: 0,
                    ),
              Text(obj["teacher"])
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: obj["periods"] != null && !obj["periods"].isEmpty
                  ? (() {
                      String periodsText = 'Period ';
                      obj["periods"].forEach((p) {
                        periodsText += _settings.classPeriods[p] + '  ';
                      });
                      return Text(periodsText);
                    })()
                  : Text("No Periods Specified"),
            ),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Text(obj["description"]),
              ),
            ],
          ),
          showEdit
              ? EditClass(
                  toggleShowWidget: toggleShowEdit,
                  classObj: obj,
                  classDocId: docId,
                  showWaitMessage: showWaitMessageFunction,
                )
              : Text(""),
        ],
      ),
    );
  }
}
