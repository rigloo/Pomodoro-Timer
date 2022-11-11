import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pomodoro_timer/pauseButton.dart';
import 'package:pomodoro_timer/resetButton.dart';
import 'dart:async';
import './tomato.dart';
import './startButton.dart';
import './pauseButton.dart';
import './resumeButton.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
  int counter = 0;
  Timer? mytimer;
  bool paused = false;
  bool onGoing = false;
  int pomodoros = 0;

  void _startTimer() {
    setState(() {
      onGoing = true;
      paused = false;
    });
    mytimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        counter++;
      });
    });
  }

  void _pauseTimer() {
    setState(() {
      paused = true;
    });

    mytimer!.cancel();
    mytimer = null;
  }

  void _resumeTimer() {
    setState(() {
      paused = false;
    });

    mytimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        counter++;
      });
    });
  }

  void _resetTimer() {
    setState(() {
      onGoing = false;
      paused = false;
      counter = 0;
    });

    if (mytimer == null) return;
    mytimer!.cancel();
    mytimer = null;
  }

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
            //The Tomato image and progress bar joined together with a Stack
            Tomato(counter),
            //Some padding to put buttons on bottom
            SizedBox(height: 50),

            //Output which buttton (Start, Pause, Resume) 
            if (!onGoing && !paused)
              StartButton(_startTimer)
            else if (onGoing && !paused)
              PauseButton(_pauseTimer)
            else if (paused)
              ResumeButton(_resumeTimer),
            ResetButton(_resetTimer),
          ],
        ),
      ),
    );
  }
}
