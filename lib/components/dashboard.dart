import "package:flutter/material.dart";
import 'package:flutterfirebasetutorial/components/blockschedule.dart';
import 'package:flutterfirebasetutorial/components/loading.dart';
import 'package:flutterfirebasetutorial/components/noschool.dart';
import "package:flutterfirebasetutorial/services/weektemplates.dart";
import "package:flutterfirebasetutorial/models/settings.dart";

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  SettingsList _settings = SettingsList();
  DateTime currentDayDisplay = DateTime.now();

  Future figureOutDayTemplate() async {
    DateTime today = currentDayDisplay;
    var firstMonday = await _settings.firstMonday;
    print("First Monday:" + firstMonday.toString());
    int weekNo = (today.difference(firstMonday).inDays / 7.0).floor() + 1;
    if (weekNo < 0) weekNo = weekNo.abs();
    dynamic result = await WeekTemplates().getSnapshotDefault();
    print(result.data());
    if (today.weekday >= 6) return null;
    if (weekNo % 3 == 1) return result.data()["1mod3"][today.weekday - 1];
    if (weekNo % 3 == 2)
      return result.data()["2mod3"][today.weekday - 1];
    else
      return result.data()["3mod3"][today.weekday - 1];
  }

  Future checkExceptions() async {
    DateTime today = currentDayDisplay;
    if (today.weekday >= 6) return false;
    var firstMonday = await _settings.firstMonday;
    int weekNo = (today.difference(firstMonday).inDays / 7.0).floor() + 1;
    if (weekNo < 0) weekNo = weekNo.abs();
    dynamic result = await WeekTemplates().getSnapshotExceptions();
    print(result.data());
    bool hasException = false;
    List exceptions = result.data()["exceptions"];
    for (int i = 0; i < exceptions.length; i++) {
      if (exceptions[i]["week"] == weekNo) {
        print("YES");
        print((today.weekday - 1).toString());
        print(exceptions[i]["template"][today.weekday - 1]);
        hasException = true;
        print("EXCPETION!!");
        return exceptions[i]["template"][today.weekday - 1];
      }
    }
    if (!hasException) return false;
  }

  String displayDate() {
    DateTime today = currentDayDisplay;
    return _settings.weekdaysList[today.weekday] +
        " " +
        today.month.toString() +
        "-" +
        today.day.toString() +
        "-" +
        today.year.toString();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          child: Column(
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: SizedBox(),
              ),
              Icon(
                Icons.dashboard,
                size: 40,
              ),
              SizedBox(width: 5),
              Text(
                "Dashboard",
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
          Row(
            children: <Widget>[
              Expanded(
                child: SizedBox(),
              ),
              FlatButton.icon(
                label: Text(
                  displayDate(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                icon: Icon(
                  Icons.calendar_today,
                  size: 20,
                ),
                onPressed: () {
                  showDatePicker(
                          context: context,
                          initialDate: currentDayDisplay,
                          firstDate: DateTime.utc(2020, 9, 9),
                          lastDate: DateTime.utc(2021, 7, 1))
                      .then((value) {
                    if (value != null)
                      setState(() {
                        currentDayDisplay = value;
                      });
                  });
                },
              ),
              Expanded(
                child: SizedBox(),
              )
            ],
          ),
          FutureBuilder(
              future: figureOutDayTemplate(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Loading();
                }

                if (snapshot.data == null) return NoSchool();
                return FutureBuilder(
                  future: checkExceptions(),
                  builder: (context2, snapshot2) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      print(snapshot2.data);

                      String dayString = '.';
                      if (snapshot2.data is bool && snapshot2.data == false) {
                        dayString = snapshot.data;
                      } else if (snapshot2.data == null) {
                        return Loading();
                      } else if (snapshot.data == null) {
                        return NoSchool();
                      } else
                        dayString = snapshot2.data;
                      List arr = dayString.split(".");
                      print(arr);
                      String dayTemplate = arr[0];
                      int cohortNo = int.parse(arr[1]);
                      String cohort = "";
                      if (cohortNo == 0)
                        cohort = "All Remote";
                      else {
                        cohort = "Cohort " + cohortNo.toString() + " In School";
                      }
                      return Column(children: <Widget>[
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(15)),
                          child: Text(cohort,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                        BlockSchedule(dayTemplate),
                        SizedBox(
                          height: 30,
                        )
                      ]);
                    } else {
                      return Loading();
                    }
                  },
                );
              }),
        ],
      )),
    );
  }
}
