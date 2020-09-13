import 'package:flutterfirebasetutorial/components/mainpage.dart';
import "package:flutterfirebasetutorial/services/auth.dart";
import "authwrapper.dart";
import "package:flutter/material.dart";

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().getStream,
      builder: (context, snapshot) {
        return snapshot.data == null ? AuthWrapper() : MainPage();
      },
    );
  }
}
