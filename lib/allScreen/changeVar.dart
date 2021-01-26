import 'package:flutter/material.dart';

class ChangeVar extends StatefulWidget {
  static const String idScreen = "ChangeVariable";
  @override
  _ChangeVarState createState() => _ChangeVarState();
}

class _ChangeVarState extends State<ChangeVar> {
  int dataToChange = 0;

  void changeData() {
    setState(() {
      dataToChange += 1;
    });
  }

  void resetData() {
    setState(() {
      dataToChange = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Change Variable"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "$dataToChange",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            RaisedButton(
              onPressed: changeData,
              color: Colors.cyan,
              splashColor: Colors.red,
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
              child: Text(
                "Click me",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 45.0,
            ),
            RaisedButton(
              onPressed: resetData,
              color: Colors.cyan,
              splashColor: Colors.red,
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
              child: Text(
                "Reset",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
