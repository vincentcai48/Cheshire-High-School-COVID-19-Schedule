import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:flutterfirebasetutorial/models/settings.dart";

class SingleClassBlock extends StatelessWidget {
  String title, room, description, teacher, start, end, period;
  double length;
  int color;
  List<Color> colors = SettingsList().colorsList;

  SingleClassBlock(
      {this.title,
      this.room,
      this.description,
      this.teacher,
      this.length,
      this.start,
      this.end,
      this.color,
      this.period});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Container(
            height: length * 80.0 < 80 ? 80 : length * 80.0,
            child: Row(
              children: <Widget>[
                SizedBox(width: 10),
                Column(
                  children: <Widget>[
                    Container(
                      child: Text(start,
                          style: TextStyle(fontWeight: FontWeight.w700)),
                    ),
                    Expanded(
                        child: Center(
                            child: period == null
                                ? Text("")
                                : Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(3),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey,
                                              spreadRadius: 1,
                                              blurRadius: 1,
                                              offset: Offset(2, 2))
                                        ]),
                                    child: Text(period.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.white))))),
                    Container(
                        child: Text(end,
                            style: TextStyle(fontWeight: FontWeight.w700)))
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 20, 0),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:
                              color < 0 ? Colors.transparent : colors[color]),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: SingleChildScrollView(
                          child: Column(children: <Widget>[
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(title,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold))),
                            SizedBox(
                              height: 5,
                            ),
                            Row(children: <Widget>[
                              room == ""
                                  ? SizedBox()
                                  : Text("Rm " + room + " "),
                              teacher == ""
                                  ? SizedBox()
                                  : Row(children: <Widget>[
                                      Text(
                                        "Teacher: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(teacher)
                                    ])
                            ]),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(description))
                          ]),
                        ),
                      ),
                      height: length * 80.0 < 80 ? 80 : length * 80.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
