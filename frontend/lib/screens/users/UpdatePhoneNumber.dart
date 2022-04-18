// ignore_for_file: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/api%20calls/User.dart';
import 'package:frontend/services/user_alert.dart';
import 'package:http/http.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../widgets/ui/LongButton.dart';
import 'Verification.dart';

class UpdatePhoneNumber extends StatefulWidget {
  static const routeName = '/update_phone_number';
  const UpdatePhoneNumber({Key? key}) : super(key: key);

  @override
  State<UpdatePhoneNumber> createState() => _UpdatePhoneNumberState();
}

class _UpdatePhoneNumberState extends State<UpdatePhoneNumber> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  PhoneNumber phoneNumber =
      PhoneNumber(countryISOCode: '', countryCode: '', number: '');
  bool updating = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            key: scaffoldKey,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text('Update mobile number'),
            ),
            backgroundColor: Theme.of(context).backgroundColor,
            body: SingleChildScrollView(
                child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 30),
                            child: Text(
                              'Update your mobile number',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Text(
                                'We will send a new verification code on your new mobile number.',
                                style: Theme.of(context).textTheme.bodyMedium),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: IntlPhoneField(
                              keyboardType: TextInputType.phone,
                              cursorColor: Theme.of(context).primaryColor,
                              autofocus: true,
                              pickerDialogStyle: PickerDialogStyle(
                                  countryNameStyle:
                                      const TextStyle(color: Colors.black),
                                  countryCodeStyle:
                                      const TextStyle(color: Colors.black),
                                  searchFieldCursorColor: Colors.black,
                                  searchFieldInputDecoration: InputDecoration(
                                    hintText: 'Search',
                                    label: const Text('Search country'),
                                    floatingLabelStyle: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  )),
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
                                hintStyle:
                                    const TextStyle(color: Color(0xFFA0A0A0)),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor),
                                ),
                              ),
                              initialCountryCode: 'PK',
                              onChanged: (phone) => setState(() {
                                phoneNumber = phone;
                              }),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Text(
                              'If you continue, you will receive an SMS for verification. Message and data rates may apply.',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                          phoneNumber.number.length == 10
                              ? Container(
                                  margin: const EdgeInsets.only(top: 390),
                                  child: LongButton(
                                      handler: () async {
                                        Response response =
                                            await userExists(phoneNumber);
                                        if (response.statusCode == 200) {
                                          bool exists =
                                              json.decode(response.body)['data']
                                                  ['exists'];
                                          if (!exists) {
                                            Navigator.of(context).pushNamed(
                                                Verification.routeName,
                                                arguments: {
                                                  'phoneNumber': phoneNumber,
                                                  'previousScreen':
                                                      'updateEmail'
                                                });
                                          } else {
                                            snackBar(scaffoldKey,
                                                'A user with the following user name already exists');
                                          }
                                        }
                                      },
                                      buttonText: 'Next',
                                      isActive: true),
                                )
                              : Container(
                                  margin: const EdgeInsets.only(top: 390),
                                  child: LongButton(
                                      handler: () {},
                                      buttonText: 'Next',
                                      isActive: false),
                                )
                        ])))));
  }
}
