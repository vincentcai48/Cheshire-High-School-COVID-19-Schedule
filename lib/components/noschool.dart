import "package:flutter/material.dart";

class NoSchool extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        SizedBox(
          height: 70,
        ),
        Row(
          children: <Widget>[
            Expanded(child: SizedBox()),
            Icon(
              Icons.school,
              size: 26,
            ),
            SizedBox(width: 5),
            Text(
              "No School Today",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: SizedBox(),
            )
          ],
        ),
        SizedBox(
          height: 70,
        )
      ],
    ));
  }
}
