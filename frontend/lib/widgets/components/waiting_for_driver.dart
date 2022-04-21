import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WaitingForDriverUI extends StatelessWidget {
  const WaitingForDriverUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.only(bottom:12, right:12, left: 12, top: 13),
        width: double.infinity,
        decoration: ShapeDecoration(
          color: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: AnimatedTextKit(
          totalRepeatCount: 100,
          animatedTexts: [
            FadeAnimatedText(
              'Waiting for driver\'s response',
              textAlign: TextAlign.center,
              duration: const Duration(seconds: 3),
              textStyle: Theme.of(context).textTheme.titleMedium
              
              
            ),
            ScaleAnimatedText(
              'Please wait',
              textAlign: TextAlign.center,
              duration: const Duration(seconds: 3),
              textStyle: const TextStyle(color: Colors.white)
              
            ),
          ],
        ));
  }
}
