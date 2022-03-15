import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodeField extends StatelessWidget {
  final Function onComplete;
  const PinCodeField({Key? key, required this.onComplete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color boxColor = Color(0xFF43444B);
    return PinCodeTextField(
      autoFocus: false,
      keyboardType: TextInputType.phone,
      length: 6,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          activeColor: boxColor,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 50,
          fieldWidth: 40,
          activeFillColor: boxColor,
          inactiveFillColor: boxColor,
          selectedFillColor: boxColor,
          inactiveColor: boxColor,
          selectedColor: Theme.of(context).primaryColor),
      animationDuration: const Duration(milliseconds: 300),
      enableActiveFill: true,
      onChanged: (value) => onComplete(value),
      beforeTextPaste: (text) => true,
      appContext: context,
    );
  }
}
