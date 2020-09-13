import 'package:flutter/material.dart';
import "package:flutterfirebasetutorial/services/auth.dart";

class Login extends StatefulWidget {
  Function toggleLoginState;
  Login({this.toggleLoginState});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = '';
  String password = '';
  String errorMessage = '';
  final _formKey = GlobalKey<FormState>();
  Auth _auth = Auth();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
      child: Container(
          child: Center(
        child: Column(
          children: <Widget>[
            Text("Login",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      validator: (value) =>
                          value.isEmpty ? "Enter an email" : null,
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(hintText: "Email"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) => value.length < 6
                          ? "Enter more than 6 characters"
                          : null,
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                      obscureText: true,
                      decoration: InputDecoration(hintText: "Password"),
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(errorMessage),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.red[700],
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          print(email);
                          print(password);
                          print("pressed");
                          dynamic result = await _auth.signIn(email, password);
                          setState(() {
                            errorMessage = "Error Logging in";
                          });
                        }
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    FlatButton(
                        child: Text(
                          "Register for a New Account >>>",
                          style:
                              TextStyle(decoration: TextDecoration.underline),
                        ),
                        onPressed: () {
                          widget.toggleLoginState();
                        },
                        color: Colors.transparent),
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    ));
  }
}
