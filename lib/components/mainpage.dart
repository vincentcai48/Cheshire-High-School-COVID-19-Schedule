import "package:flutter/material.dart";
import 'package:flutterfirebasetutorial/components/Classes.dart';
import 'package:flutterfirebasetutorial/components/account.dart';
import 'package:flutterfirebasetutorial/components/dashboard.dart';
import "package:flutterfirebasetutorial/services/auth.dart";

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Auth _auth = Auth();

  //one of three things: "Dashboard", "Classes",or "Account"
  String _page = 'Dashboard';

  Widget returnWidget() {
    if (_page == "Dashboard")
      return Dashboard();
    else if (_page == "Classes")
      return Classes();
    else
      return Account();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "CHS Schedule App",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.red,
        elevation: 1.0,
      ),
      body: SafeArea(child: returnWidget()),
      bottomNavigationBar: FractionallySizedBox(
          widthFactor: 1,
          heightFactor: 0.07,
          child: Container(
            child: Center(
                child: Row(
              children: <Widget>[
                Expanded(
                  child: IconButton(
                    icon: Icon(
                      Icons.dashboard,
                      color: _page == "Dashboard" ? Colors.white : Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        _page = "Dashboard";
                      });
                    },
                  ),
                ),
                Expanded(
                  child: IconButton(
                    icon: Icon(
                      Icons.class_,
                      color: _page == "Classes" ? Colors.white : Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        _page = "Classes";
                      });
                    },
                  ),
                ),
                Expanded(
                  child: IconButton(
                    icon: Icon(Icons.account_circle,
                        color:
                            _page == "Account" ? Colors.white : Colors.black),
                    onPressed: () {
                      setState(() {
                        _page = "Account";
                      });
                    },
                  ),
                )
              ],
            )),
            color: Colors.red,
          )),
    );
  }
}
