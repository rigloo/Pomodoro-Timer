import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class StartButton extends StatelessWidget {
  VoidCallback startTimer;
  StartButton(this.startTimer);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 200,
      child: FittedBox(
        child: ElevatedButton(
            onPressed: startTimer, //startTimer,
            child: Text(
              "START",
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
