import 'package:flutter/material.dart';
import 'package:frontend/widgets/ui/LongButton.dart';

class LocationPicker extends StatelessWidget {
  const LocationPicker({
    Key? key,
  }) : super(key: key);

  Widget customTextField(context, onChangeHandler, label, placeholder) {
    return TextField(
      onChanged: (val) {
        onChangeHandler(val);
      },
      cursorColor: Theme.of(context).primaryColor,
      autofocus: false,
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
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.all(12),
        width: double.infinity,
        decoration: ShapeDecoration(
          color: const Color.fromARGB(255, 36, 37, 40),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Enter trip details',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Container(
                margin: const EdgeInsets.only(top: 6, bottom: 8),
                child: customTextField(
                    context, () {}, 'Pickup', "Enter pickup location")),
            Container(
                margin: const EdgeInsets.only(bottom: 18),
                child: customTextField(
                    context, () {}, 'Dropoff', "Enter dropoff location")),
            LongButton(
              handler: () {},
              isActive: true,
              buttonText: 'Next',
            )
          ],
        ));
  }
}
