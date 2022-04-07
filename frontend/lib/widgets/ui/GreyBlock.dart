// ignore_for_file: file_names
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GreyBlock extends StatelessWidget {
  final String text;
  double top, bottom;
  GreyBlock({Key? key, required this.text, required this.bottom, required this.top}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: top, bottom: bottom),
        padding: const EdgeInsets.all(12),
        width: double.infinity,
        decoration: ShapeDecoration(
          color: const Color(0xff43444B),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ));
  }
}
