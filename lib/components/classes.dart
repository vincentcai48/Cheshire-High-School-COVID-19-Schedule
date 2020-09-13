import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:flutterfirebasetutorial/components/addClass.dart';
import 'package:flutterfirebasetutorial/components/loading.dart';
import 'package:flutterfirebasetutorial/components/singleclassblockedit.dart';
import "package:flutterfirebasetutorial/services/usersDB.dart";
import "package:flutterfirebasetutorial/services/auth.dart";
import "package:flutterfirebasetutorial/models/settings.dart";

class Classes extends StatefulWidget {
  @override
  _ClassesState createState() => _ClassesState();
}

class _ClassesState extends State<Classes> {
  UsersDB _usersDB = UsersDB();
  Auth _auth = Auth();
  bool showAddClass = false;

  void toggleAddClass() => setState(() => showAddClass = !showAddClass);

  Widget generateClasses(List<DocumentSnapshot> docList) {
    Column c = Column(
      children: (() {
        List<Color> colors = SettingsList().colorsList;
        List l = List<Widget>();
        docList.forEach((element) {
          l.add(SingleClassBlockEdit(doc: element));
        });
        return l;
      })(),
    );
    return c;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(height: 15),
              Row(
                children: <Widget>[
                  Expanded(
                    child: SizedBox(),
                  ),
                  Icon(
                    Icons.class_,
                    size: 40,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Classes",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                  ),
                  Expanded(
                    child: SizedBox(),
                  )
                ],
              ),
              SizedBox(
                height: 25,
              ),
              FlatButton.icon(
                icon: showAddClass
                    ? Icon(Icons.remove_circle)
                    : Icon(Icons.add_circle),
                label: showAddClass ? Text("Hide Widget") : Text("Add a Class"),
                onPressed: () {
                  toggleAddClass();
                },
              ),
              SizedBox(
                height: 30,
              ),
              showAddClass
                  ? AddClass(toggleAddClass: toggleAddClass)
                  : Text(""),
              StreamBuilder(
                  stream: _usersDB.getAllClasses(userId: _auth.currentUser.uid),
                  builder: (context, snapshot) {
                    print(snapshot);
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Loading();
                    }

                    return generateClasses(snapshot.data.documents);
                  }),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
