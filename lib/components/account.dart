import "package:flutter/material.dart";
import "package:flutterfirebasetutorial/services/auth.dart";

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  Auth _auth = Auth();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            child: Center(
                child: Column(
      children: <Widget>[
        SizedBox(height: 70),
        Center(
          child: Icon(Icons.account_circle, size: 100),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Account",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          "Email: ",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          Auth().currentUser.email,
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(
          height: 20,
        ),
        RaisedButton(
          onPressed: () {
            _auth.signOut();
          },
          child: Text("Logout"),
        )
      ],
    ))));
  }
}
