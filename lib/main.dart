import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebasetutorial/components/loading.dart';
import 'package:flutterfirebasetutorial/components/wrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(home: Wrapper());
        }
        return MaterialApp(
            home: Scaffold(
          body: Center(
              child: Column(
            children: <Widget>[
              SizedBox(
                height: 100,
              ),
              Loading(),
            ],
          )),
        ));
      },
    );
  }
}
