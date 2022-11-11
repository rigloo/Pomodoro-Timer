import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class ResumeButton extends StatelessWidget {
  VoidCallback resumeTimer;
  ResumeButton(this.resumeTimer);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 200,
      child: FittedBox(
        child: ElevatedButton(
            onPressed: resumeTimer, //startTimer,
            child: Text(
              "RESUME",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(221, 83, 83, 1)),
            ),
            style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).accentColor)),
      ),
    );
  }
}
