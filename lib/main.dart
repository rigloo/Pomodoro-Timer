import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'dart:async';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        accentColor: Color.fromRGBO(237, 219, 192, 1),
        scaffoldBackgroundColor: Color.fromRGBO(219, 200, 172, 1),
      ),
      home: const MyHomePage(title: 'Pomodoro Timer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //CountdownTimerController controller;
  


  void handleTimeout() {
    print("Something");
  }

  Timer scheduleTimeout([int milliseconds = 5000]) =>
      Timer(Duration(milliseconds: milliseconds), handleTimeout);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(alignment: Alignment.center, children: [
              FittedBox(
                  child: Image.asset("assets/tomato2.png",
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width)),
              //To be replaced by Progress bar
              Text("ProgressBar")
            ]),
            SizedBox(height: 50),
            Container(
              height: 100,
              width: 200,
              child: FittedBox(
                child: ElevatedButton(
                    onPressed: () {
                      scheduleTimeout(5 * 1000);
                    }, //startTimer,
                    child: Text(
                      "START",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(221, 83, 83, 1)),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).accentColor)),
              ),
            ),
            Container(
              height: 50,
              width: 100,
              child: FittedBox(
                child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "RESET",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(237, 219, 192, 1)),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(221, 83, 83, 1))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
