import 'dart:async';

import 'package:flappybird/bird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdYaxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdYaxis;
  bool gameHasStarted = false;

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYaxis;
    });
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYaxis = initialHeight - height;
      });
      if (birdYaxis > 1) {
        timer.cancel();
        gameHasStarted = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Expanded(
        flex: 2,
        child: GestureDetector(
          onTap: () {
            if (gameHasStarted) {
              jump();
            } else {
              startGame();
            }
          },
          child: AnimatedContainer(
            alignment: Alignment(0, birdYaxis),
            duration: Duration(microseconds: 0),
            color: Colors.blue,
            child: MyBird(),
          ),
        ),
      ),
      Expanded(
        child: Container(
          color: Colors.green,
        ),
      ),
    ]));
  }
}
