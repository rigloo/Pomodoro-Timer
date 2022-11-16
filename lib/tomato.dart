import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'constants.dart' as Constants;

class Tomato extends StatelessWidget {
  final int counter;
  final String message;
  double get value {
    if (message == Constants.WORK_MESSAGE) {
      return counter.toDouble() / Constants.WORK_LENGTH;
    } else if (message == Constants.QUICK_BREAK_MESSAGE) {
      return counter.toDouble() / Constants.QUICK_BREAK_LENGTH;
    } else if (message == Constants.LONG_BREAK_MESSAGE) {
      return counter.toDouble() / Constants.LONG_BREAK_LENGTH;
    } else
      return 0;
  }

  String get image_path {
     if (message == ""){
      return "assets/tomato2.png";
     }
    else if  (message == Constants.WORK_MESSAGE){
      return "assets/angry_tomato.png";
    }
    else {
      return "assets/relaxed_tomato.png";
    }
  }
  

  Color get tomatoColor {
    if (message == Constants.WORK_MESSAGE)
      return Color.fromRGBO(255, 210, 48, 1);
    else
      return Color.fromARGB(255, 255, 163, 244);
  }

  Tomato(this.counter, this.message);
  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      FittedBox(
          child: Image.asset(image_path,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width)),
      //Progress bar
      SizedBox(
        height: MediaQuery.of(context).size.height * .1,
        width: MediaQuery.of(context).size.width * .8,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: LinearProgressIndicator(
            backgroundColor: Colors.white,
            value: value,
            color: tomatoColor,
          ),
        ),
      ),
      Text(
        message,
        style: TextStyle(
          letterSpacing: 5.0,
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
      )
    ]);
  }
}
