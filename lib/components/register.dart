import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import "package:flutterfirebasetutorial/services/auth.dart";

class Register extends StatefulWidget {
  Function toggleLoginState;
  Register({this.toggleLoginState});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email = '';
  String password = '';
  String errorMessage = '';
  Auth _auth = Auth();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          child: Center(
        child: Column(
          children: <Widget>[
            FlatButton(
                child: Text("<<< Back to Login"),
                onPressed: () {
                  widget.toggleLoginState();
                },
                color: Colors.transparent),
            Text("Register",
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
                      child: Text("Register Now"),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          print(email);
                          print(password);
                          print("pressed");
                          dynamic result =
                              await _auth.register(email, password);
                          setState(() {
                            errorMessage =
                                "Error Registering. Check email and password are formatted correctly";
                          });
                        }
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
