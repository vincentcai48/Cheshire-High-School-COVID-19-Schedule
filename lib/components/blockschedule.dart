import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterfirebasetutorial/components/loading.dart';
import 'package:flutterfirebasetutorial/components/singleclassblock.dart';
import 'package:flutterfirebasetutorial/models/settings.dart';
import 'package:flutterfirebasetutorial/services/auth.dart';
import "package:flutterfirebasetutorial/services/daytemplates.dart";
import "package:flutterfirebasetutorial/services/usersDB.dart";

class BlockSchedule extends StatefulWidget {
  String dayTemplate;

  //the number day template as a string. eg n=1.
  BlockSchedule(String n) {
    dayTemplate = n;
    print(n);
  }
  @override
  _BlockScheduleState createState() => _BlockScheduleState();
}

class _BlockScheduleState extends State<BlockSchedule> {
  DayTemplates _dayTemplates = new DayTemplates();
  UsersDB _usersDB = new UsersDB();
  Auth _auth = Auth();
  SettingsList settings = SettingsList();

  Widget renderSchedule(List<dynamic> docList) {
    StreamBuilder c = StreamBuilder(
        stream: _usersDB.getAllClasses(userId: _auth.currentUser.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          }

          return Column(children: (() {
            List l = List<Widget>();
            docList.forEach((element) {
              String classTitle = 'No Class';
              String classDescription = '';
              String classRoom = '';
              String classTeacher = '';
              int color = -1;
              int targetPeriod = 24;
              if (element["period"] is int)
                targetPeriod = element["period"];
              else {
                targetPeriod = int.parse(element["period"]);
              }
              snapshot.data.documents.forEach((e) {
                e.data()["periods"].forEach((p) {
                  if (p == targetPeriod) {
                    classTitle = e.data()["title"];
                    classDescription = e.data()["description"];
                    classRoom = e.data()["room"];
                    classTeacher = e.data()["teacher"];
                    color = e.data()["color"] == null ? 0 : e.data()["color"];
                  }
                });
              });
              List<String> time = element["time"].split("-");
              List<String> a = time[0].split(":");
              List<String> b = time[1].split(":");
              double a1 = double.parse(a[0]) + double.parse(a[1]) / 60.0;
              double a2 = double.parse(b[0]) + double.parse(b[1]) / 60.0;
              print(classTitle);
              print(classDescription);
              print(classRoom);
              print(classTeacher);
              if (a1 < 3) a1 = a1 + 12;
              if (a2 < 3) a2 = a2 + 12;
              double length = (a2 - a1).abs();
              print(length);
              l.add(Container(
                  child: SingleClassBlock(
                      start: time[0],
                      end: time[1],
                      length: length,
                      title: classTitle,
                      teacher: classTeacher,
                      description: classDescription,
                      room: classRoom,
                      period: settings.classPeriods[targetPeriod],
                      color: color == null ? -1 : color)));
            });
            return l;
          })());
        });
    return c;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          child: FutureBuilder(
              future: _dayTemplates.getSnapshotStream(widget.dayTemplate),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                print(snapshot.data);

                return renderSchedule(snapshot.data.data()["blocks"]);
              })),
    );
  }
}
