import "package:flutter/material.dart";

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Center(
        child: Column(children: <Widget>[
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
          ),
          SizedBox(height: 15),
          Text(
            "Loading",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
          )
        ]),
      ),
    );
  }
}
