import "package:flutter/material.dart";
import 'package:flutterfirebasetutorial/models/singleclass.dart';
import "package:flutterfirebasetutorial/services/usersDB.dart";
import "package:flutterfirebasetutorial/services/auth.dart";
import "package:flutterfirebasetutorial/models/settings.dart";

class EditClass extends StatefulWidget {
  Function toggleShowWidget;
  Function showWaitMessage;
  Map classObj;
  String classDocId = '';
  EditClass(
      {this.toggleShowWidget,
      this.classObj,
      this.classDocId,
      this.showWaitMessage});

  @override
  _EditClassState createState() =>
      _EditClassState(classObj: classObj, classDocId: classDocId);
}

class _EditClassState extends State<EditClass> {
  final _formKey = GlobalKey<FormState>();

  String title;
  String room;
  String teacher;
  String description;
  String docId;
  int color;
  List periods = List<bool>(24);
  List letters = ["A", "B", "C", "D"];
  UsersDB _usersDB = UsersDB();
  Auth _auth = Auth();

  _EditClassState({classObj: Map, classDocId: String}) {
    title = classObj["title"];
    room = classObj["room"];
    teacher = classObj["teacher"];
    description = classObj["description"];
    color = classObj["color"];
    docId = classDocId;
    classObj["periods"].forEach((p) {
      if (p >= 0 && p < 24) {
        periods[p] = true;
      }
    });
  }

  List<bool> nullToFalse(List l) {
    for (int i = 0; i < l.length; i++) if (l[i] == null) l[i] = false;
    return l;
  }

  Widget renderColorGrid() {
    Widget grid = Wrap(
      direction: Axis.horizontal,
      children: (() {
        List<Color> colors = SettingsList().colorsList;
        int colorNum =
            0; //array index, because we use a forEach, we have to keep track of array index up here
        List<Widget> l = List<Widget>();
        for (int i = 0; i < colors.length; i++) {
          Widget c = Column(
            children: <Widget>[
              Container(
                height: 30,
                width: 30,
                color: colors[i],
              ),
              Checkbox(
                value: color == i,
                onChanged: (value) {
                  setState(() {
                    color = i;
                  });
                },
              )
            ],
          );
          l.add(c);
        }
        return l;
      })(),
    );
    return grid;
  }

  Widget renderPeriodGrid() {
    setState(() {
      periods = nullToFalse(periods);
    });
    print(periods);
    Widget grid = Column(
      children: (() {
        List rows = List<Widget>();
        for (int r = 0; r < 8; r++) {
          rows.add(SizedBox(
            height: 10,
          ));
          rows.add(Row(
            children: (() {
              List items = List<Widget>();
              items.add(Text((r + 1).toString() + ": ",
                  style: TextStyle(fontSize: 20)));
              items.add(SizedBox(width: 10));
              int n =
                  0; //0 or 1, depending on if to add one to c to get the index of the array or not.
              //c is 0-2 becaue only variables defined within a for loop scope stay defined that way in the checkbox onChanged Function
              for (int c = 0; c < 3; c++) {
                //happens to skip out on the day r%4. 1 and 5 skip out on B, 2 and 6 skip out on C, etc ...
                if (c == (r + 1) % 4) n = 1;
                items.add(Column(children: <Widget>[
                  Text(
                    letters[c + n],
                  ),
                  Checkbox(
                    value: periods[r * 3 + c],
                    onChanged: (value) {
                      //make sure you see why it is r*3+n. r is the period number (1,2,3, etc) and n is the letter day (A,B,C...).
                      setState(() {
                        List tempPeriods = periods;
                        print((c).toString());
                        print(tempPeriods[r * 3 + c]);
                        tempPeriods[r * 3 + c] = value;
                        print(tempPeriods[r * 3 + c]);
                        print(value ? "true" : "false");
                        periods = tempPeriods;
                        print(tempPeriods);
                        print(periods);
                      });
                    },
                  )
                ]));
              }
              return items;
            })(),
          ));
        }
        return rows;
      })(),
    );
    return grid;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.grey[300]),
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Edit",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.settings)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          validator: (value) =>
                              value.isEmpty ? "Please enter a title" : null,
                          style: TextStyle(fontSize: 25),
                          initialValue: title,
                          onChanged: (val) => setState(() => title = val),
                          decoration: InputDecoration(hintText: "Title"),
                        ),
                        Row(children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              onChanged: (val) => setState(() => room = val),
                              style: TextStyle(fontSize: 18),
                              initialValue: room,
                              decoration: InputDecoration(hintText: "Room"),
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: TextFormField(
                              onChanged: (val) => setState(() => teacher = val),
                              style: TextStyle(fontSize: 18),
                              initialValue: teacher,
                              decoration: InputDecoration(hintText: "Teacher"),
                            ),
                          )
                        ]),
                        TextFormField(
                          onChanged: (val) => setState(() => description = val),
                          style: TextStyle(fontSize: 16),
                          initialValue: description,
                          decoration: InputDecoration(hintText: "Description"),
                        ),
                        SizedBox(height: 40),
                        Center(
                          child: renderColorGrid(),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Center(
                            child: Text(
                          "Select Class Periods",
                          style: TextStyle(fontSize: 24),
                        )),
                        Center(child: renderPeriodGrid()),
                        SizedBox(
                          height: 20,
                        ),
                        RaisedButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              List truncatedPeriods = List<int>();
                              for (int i = 0; i < periods.length; i++) {
                                if (periods[i]) truncatedPeriods.add(i);
                              }
                              SingleClass newClass = new SingleClass(
                                  periods: truncatedPeriods,
                                  title: title,
                                  room: room,
                                  teacher: teacher,
                                  description: description,
                                  color: color);
                              dynamic result = await _usersDB.updateClass(
                                  className: newClass,
                                  userId: _auth.currentUser.uid,
                                  docId: docId);

                              if (result == null)
                                print("Error");
                              else {
                                print(result);
                              }
                              widget.toggleShowWidget();
                              print("hello");
                              widget.showWaitMessage();
                            }
                          },
                          child: Text("Save Changes",
                              style: TextStyle(
                                color: Colors.white,
                              )),
                          color: Colors.black,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
