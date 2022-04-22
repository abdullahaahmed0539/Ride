import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WaitingForRidersUI extends StatelessWidget {
  const WaitingForRidersUI({Key? key}) : super(key: key);

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
          totalRepeatCount: 10000,
          animatedTexts: [
            FadeAnimatedText(
              'You are visible to nearby riders',
              textAlign: TextAlign.center,
              duration: const Duration(seconds: 3),
              textStyle: Theme.of(context).textTheme.titleMedium
              
              
            ),
            FadeAnimatedText(
              'Please wait for a rider\'s request',
              textAlign: TextAlign.center,
              duration: const Duration(seconds: 3),
              textStyle: Theme.of(context).textTheme.titleMedium
              
            ),
          ],
        ));
  }
}
