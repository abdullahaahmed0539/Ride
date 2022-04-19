library pk_cnic_input_field;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PKCNICInputField extends StatelessWidget {
  final onChanged;
  final _mobileFormatter = NumberTextInputFormatter();
  final cursorColor;
  final prefixIconColor;
  PKCNICInputField(
      {required this.onChanged,
      this.cursorColor = Colors.black,
      this.prefixIconColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      cursorColor: Theme.of(context).primaryColor,
      keyboardType: TextInputType.number,
      maxLength: 15,
      autofocus: false,
      autocorrect: false,
      style: const TextStyle(
          fontFamily: 'SF-Pro-Rounded', fontSize: 18, color: Colors.white),
      decoration: InputDecoration(
        counterStyle: const TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        fillColor: const Color(0xFF43444B),
        filled: true,
        labelText: 'CNIC number',
        labelStyle: const TextStyle(
            color: Color(0xFFA0A0A0),
            fontSize: 16,
            fontFamily: 'SF-Pro-Rounded-Medium'),
        hintText: "42201-0000000-0",
        hintStyle: const TextStyle(color: Color(0xFFA0A0A0)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        _mobileFormatter
      ],
    );
  }
}

class NumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = StringBuffer();
    if (newTextLength >= 6) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 5) + '-');
      if (newValue.selection.end >= 5) selectionIndex += 1;
    }
    if (newTextLength >= 13) {
      newText.write(newValue.text.substring(5, usedSubstringIndex = 12) + '-');
      if (newValue.selection.end >= 12) selectionIndex += 1;
    }
    // Dump the rest.
    if (newTextLength >= usedSubstringIndex) {
      newText.write(newValue.text.substring(usedSubstringIndex));
    }
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
