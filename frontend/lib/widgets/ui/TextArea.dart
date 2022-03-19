import 'package:flutter/material.dart';

class TextArea extends StatelessWidget {
  final String label;
  final String placeholder;
  final Function onChangeHandler;

  const TextArea(
      {required this.label,
      required this.placeholder,
      required this.onChangeHandler});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          maxLines: 15,
          onChanged: (val) {
            onChangeHandler(val);
          },
          cursorColor: Theme.of(context).primaryColor,
          autofocus: true,
          autocorrect: false,
          style: const TextStyle(
              fontFamily: 'SF-Pro-Rounded', fontSize: 18, color: Colors.white),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            fillColor: const Color(0xFF43444B),
            filled: true,
            labelText: label,
            alignLabelWithHint: true,
            labelStyle: const TextStyle(
                color: Color(0xFFA0A0A0),
                fontSize: 16,
                fontFamily: 'SF-Pro-Rounded-Medium'),
            hintText: placeholder,
            hintStyle: const TextStyle(color: Color(0xFFA0A0A0)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
            ),
          ),
        ),
      ],
    );
  }
}
