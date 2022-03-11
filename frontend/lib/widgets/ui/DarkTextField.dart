import 'package:flutter/material.dart';

class DarkTextField extends StatelessWidget {
  final String label;
  final String placeholder;
  final Function onChangeHandler;

  const DarkTextField(
      {required this.label,
      required this.placeholder,
      required this.onChangeHandler});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          onChanged: (val) {
            onChangeHandler(val);
          },
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
            labelStyle: const TextStyle(
                color: Color(0xFFA0A0A0),
                fontSize: 16,
                fontFamily: 'SF-Pro-Rounded-Medium'),
            hintText: placeholder,
            hintStyle: const TextStyle(color: Color(0xFFA0A0A0)),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white60),
            ),
          ),
        ),
      ],
    );
  }
}
