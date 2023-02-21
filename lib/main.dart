import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './tomato.dart';
import './startButton.dart';
import './pauseButton.dart';
import './resumeButton.dart';
import 'constants.dart' as Constants;
import './tomatoCounter.dart';
import './resetButton.dart';
import './services/NotificationService.dart';

main() {
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
      debugShowCheckedModeBanner: false,
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

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  //CountdownTimerController controller;

  late final NotificationService service;

  @override
  void initState() {
    // WidgetsBinding.instance.addObserver(this);
    service = NotificationService();
    service.initialize();
    super.initState();
  }

  @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   print(state);

  //   super.didChangeAppLifecycleState(state);
  // }

  @override
  // void dispose() {
  //   // TODO: implement dispose
  //   WidgetsBinding.instance.removeObserver(this);

  //   super.dispose();
  // }

  int counter = 0;
  Timer? mytimer;
  bool paused = false;
  bool onGoing = false;
  int pomodoros = 0;
  String message = "";

  void _startTimer() {
    setState(() {
      message = Constants.WORK_MESSAGE;
      onGoing = true;
      paused = false;
    });

    if (mytimer != null) {
      mytimer!.cancel();
      mytimer = null;
    }

    mytimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        updateModel();
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

  void showNotification(String msg) async {
    await service.showNotification(id: 0, title: "Pomodoro Timer", body: msg);
  }

  void _resumeTimer() {
    setState(() {
      paused = false;
      //updateModel();
    });

    mytimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        updateModel();
      });
    });
  }

  void updateModel() {
    if (message == Constants.WORK_MESSAGE && counter == Constants.WORK_LENGTH)
      pomodoros++;

    //  SystemSound.play(SystemSoundType.alert);

    // playSound();

    if (message == Constants.WORK_MESSAGE &&
        counter == Constants.WORK_LENGTH &&
        pomodoros % 3 == 0) {
      counter = 0;
      message = Constants.LONG_BREAK_MESSAGE;
      //playSound();
      showNotification("Time for long break!");
    } else if (message == Constants.WORK_MESSAGE &&
        counter == Constants.WORK_LENGTH) {
      counter = 0;
      message = Constants.QUICK_BREAK_MESSAGE;
      // playSound();
      showNotification("Time for quick break!");
    } else if (message == Constants.QUICK_BREAK_MESSAGE &&
        counter == Constants.QUICK_BREAK_LENGTH) {
      counter = 0;
      message = Constants.WORK_MESSAGE;
      //playSound();
      showNotification("Time to work!");
    } else if (message == Constants.LONG_BREAK_MESSAGE &&
        counter == Constants.LONG_BREAK_LENGTH) {
      counter = 0;
      message = Constants.WORK_MESSAGE;
      //playSound();
      showNotification("Time to work!");
    }
    counter++;
  }

  void _resetTimer() {
    setState(() {
      message = "";
      onGoing = false;
      paused = false;
      counter = 0;
      pomodoros = 0;
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
            TomatoCounter(pomodoros),
            SizedBox(height: 50),
            //The Tomato image and progress bar joined together with a Stack
            Tomato(counter, message),
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
