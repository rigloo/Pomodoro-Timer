import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class Tomato extends StatelessWidget {
   final counter;
    Tomato(this.counter);
  @override
  Widget build(BuildContext context) {
   
    return Stack(alignment: Alignment.center, children: [
      FittedBox(
          child: Image.asset("assets/tomato2.png",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width)),
      //To be replaced by Progress bar
      SizedBox(
        height: 65,
        width: 330,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: LinearProgressIndicator(
            backgroundColor: Colors.white,
            value: counter.toDouble()/25.00,
            color: Color.fromRGBO(255, 210, 48, 1),
          ),
        ),
      )
    ]);
  }
}
