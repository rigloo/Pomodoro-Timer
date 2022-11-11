import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';


class ResetButton extends StatelessWidget {

  VoidCallback resetTimer;
  ResetButton(this.resetTimer);
  @override
  Widget build(BuildContext context) {
    return Container(
              height: 50,
              width: 100,
              child: FittedBox(
                child: ElevatedButton(
                    onPressed: this.resetTimer,
                    child: Text(
                      "RESET",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(237, 219, 192, 1)),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(221, 83, 83, 1))),
              ),
            );
  }
}