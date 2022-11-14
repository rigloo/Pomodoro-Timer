import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TomatoCounter extends StatelessWidget {
  final int tomatos;
  TomatoCounter(this.tomatos);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < tomatos; i++)
            Text(
              "🍅",
              style: TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
            ),
        ],
      ),
      width: double.infinity,
      height: 30,
    );
  }
}
