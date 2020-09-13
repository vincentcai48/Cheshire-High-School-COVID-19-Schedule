import 'package:flutter/material.dart';
import 'package:flutterfirebasetutorial/components/login.dart';
import "package:flutterfirebasetutorial/services/auth.dart";
import "mainpage.dart";
import "register.dart";

class AuthWrapper extends StatefulWidget {
  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool isLogin = true;

  void toggleLoginState() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "Cheshire Schedules 2020",
              style: TextStyle(
                color: Colors.red[700],
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Center(
          child: Container(
              child: isLogin
                  ? Login(toggleLoginState: toggleLoginState)
                  : Register(toggleLoginState: toggleLoginState)),
        ));
  }
}
