import 'package:flutter/material.dart';
import 'package:frontend/screens/Verification.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'package:frontend/widgets/ui/LongButton.dart';
import 'package:intl_phone_field/phone_number.dart';

class Login extends StatefulWidget {
  static const routeName = '/login';
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  PhoneNumber phoneNumber =
      PhoneNumber(countryISOCode: '', countryCode: '', number: '');

  void onChangeHandler(PhoneNumber val) {
    setState(() {
      phoneNumber = val;
    });
  }

  void proceed(BuildContext context) {
    Navigator.of(context).pushNamed(Verification.routeName, arguments: phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(title: const Text("Login")),
          backgroundColor: Theme.of(context).backgroundColor,
          body: Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 80, right: 20, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Enter your mobile number',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 40, bottom: 10),
                  child: IntlPhoneField(
                    keyboardType: TextInputType.phone,
                    cursorColor: Theme.of(context).primaryColor,
                    autofocus: true,
                    style: const TextStyle(
                        fontFamily: 'SF-Pro-Rounded',
                        fontSize: 18,
                        color: Colors.white),
                    decoration: InputDecoration(
                      counter: const Offstage(),
                      labelText: 'Phone Number',
                      fillColor: const Color(0xFF43444B),
                      filled: true,
                      labelStyle: const TextStyle(
                          color: Color(0xFFA0A0A0),
                          fontSize: 16,
                          fontFamily: 'SF-Pro-Rounded'),
                      hintText: 'Enter your mobile number',
                      hintStyle: const TextStyle(color: Color(0xFFA0A0A0)),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    initialCountryCode: 'PK',
                    onChanged: (phone) => onChangeHandler(phone),
                  ),
                ),
                Text(
                  'If you continue, you will receive an SMS for verification. Message and data rates may apply.',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                phoneNumber.number.length == 10
                    ? Container(
                        margin: const EdgeInsets.only(top: 350),
                        child: LongButton(
                            handler: () => proceed(context),
                            buttonText: 'Next',
                            isActive: true),
                      )
                    : Container(
                        margin: const EdgeInsets.only(top: 350),
                        child: LongButton(
                            handler: () {},
                            buttonText: 'Next',
                            isActive: false),
                      )
              ],
            ),
          )),
    );
  }
}
