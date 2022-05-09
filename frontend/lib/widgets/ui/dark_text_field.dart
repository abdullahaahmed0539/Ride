import 'package:flutter/material.dart';

class DarkTextField extends StatelessWidget {
  final String label;
  final String placeholder;
  final Function onChangeHandler;
  final TextInputType keyboardType;
  final Color color;

  const DarkTextField(
      {Key? key,
      required this.label,
      required this.placeholder,
      required this.onChangeHandler,
      required this.keyboardType,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          onChanged: (val) {
            onChangeHandler(val);
          },
          keyboardType: keyboardType,
          cursorColor: Theme.of(context).primaryColor,
          autofocus: false,
          autocorrect: false,
          style: const TextStyle(
              fontFamily: 'SF-Pro-Rounded', fontSize: 18, color: Colors.white),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: color)),
            fillColor: const Color(0xFF43444B),
            filled: true,
            labelText: label,
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
