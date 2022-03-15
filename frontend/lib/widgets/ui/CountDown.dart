import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';


class CountDown extends StatelessWidget {
  final CountDownController controller;
  final Function handler;
  const CountDown({ Key? key, required this.controller, required this.handler}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularCountDownTimer(
            duration: 60,
            initialDuration: 0,
            controller: controller,
            width: 100,
            height: 100,
            ringColor: Theme.of(context).primaryColor,
            fillColor: Theme.of(context).backgroundColor,
            fillGradient: null,
            backgroundColor: Theme.of(context).backgroundColor,
            backgroundGradient: null,
            strokeWidth: 5,
            strokeCap: StrokeCap.round,
            textStyle: const TextStyle(
                fontSize: 33.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
            textFormat: CountdownTextFormat.S,
            isReverse: false,
            isReverseAnimation: true,
            isTimerTextShown: true,
            autoStart: true,
            onComplete: () => handler(),
          );
  }
}