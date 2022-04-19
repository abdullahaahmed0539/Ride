import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/api%20calls/Driver.dart';
import 'package:frontend/providers/User.dart';
import 'package:frontend/widgets/ui/LongButton.dart';
import 'package:frontend/widgets/ui/spinner.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import '../../models/User.dart';
import '../../services/user_alert.dart';
import '../../widgets/ui/DarkTextField.dart';
import '../../widgets/ui/cnic_field.dart';

class DriverSignup extends StatefulWidget {
  static const routeName = '/driver_sign_up';
  const DriverSignup({Key? key}) : super(key: key);

  @override
  State<DriverSignup> createState() => _DriverSignupState();
}

class _DriverSignupState extends State<DriverSignup> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  User? user;
  bool isLoading = false; 
  String userId = '',
      cnic = '',
      carModel = '',
      color = '',
      registrationNumber = '',
      licenseUrl = '';
  double milage = -1;

  void onSubmit() async {
    setState(() {
      isLoading = true;
    });
    Response response = await createDriverOnBoardingRequest(
        user!.id,
        carModel,
        licenseUrl,
        cnic,
        color,
        registrationNumber,
        milage,
        user!.phoneNumber,
        user!.token);
    responseHandler(response);
    if(mounted){
      setState(() {
      isLoading = false;
    });
    }
  }

  void responseHandler(Response response) {
    if (response.statusCode != 201 &&
        response.statusCode != 401 &&
        response.statusCode != 406) {
      snackBar(scaffoldKey, 'Internal server error.');
    }

    if (response.statusCode == 401) {
      snackBar(scaffoldKey, 'Forbidden access.');
    }
    if (response.statusCode == 406) {
      var errorObj = json.decode(response.body)['error'];
      if (errorObj['code'] == 'REQUEST_ALREADY_MADE') {
        Fluttertoast.showToast(msg: errorObj['message'].toString());
      } else {
        snackBar(scaffoldKey, 'Incorrect CNIC format.');
      }
    }

    if (response.statusCode == 201) {
      Fluttertoast.showToast(
          msg: 'Your Application has been submitted.',
          backgroundColor: Theme.of(context).primaryColor);
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    super.initState();
    user = Provider.of<UserProvider>(context, listen: false).user;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          key: scaffoldKey,
          resizeToAvoidBottomInset: true,
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            title: const Text('Captain on-boarding'),
          ),
          body: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: !isLoading? Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: Text(
                          'Fill in the details and earn by becoming a captain',
                          style: Theme.of(context).textTheme.titleLarge,
                        )),
                    Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 8),
                      child: DarkTextField(
                        label: 'Car model',
                        placeholder: 'Enter your car model',
                        keyboardType: TextInputType.text,
                        onChangeHandler: (val) =>
                            setState(() => carModel = val.toLowerCase()),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: DarkTextField(
                          label: 'Color',
                          placeholder: 'Enter your car\'s color',
                          keyboardType: TextInputType.text,
                          onChangeHandler: (val) =>
                              setState(() => color = val.toLowerCase())),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: DarkTextField(
                          label: 'Car milage',
                          placeholder: 'Enter your car\'s milage',
                          keyboardType: TextInputType.number,
                          onChangeHandler: (val) => setState(() {
                                if (val != '') {
                                  milage = double.parse(val.toString());
                                } else {
                                  milage = -1;
                                }
                              })),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: DarkTextField(
                          label: 'licenseUrl',
                          placeholder: 'Enter url;',
                          keyboardType: TextInputType.text,
                          onChangeHandler: (val) =>
                              setState(() => licenseUrl = val)),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: DarkTextField(
                          label: 'Registration number',
                          placeholder: 'Ex AVD-868',
                          keyboardType: TextInputType.text,
                          onChangeHandler: (val) =>
                              setState(() => registrationNumber = val)),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 16, bottom: 5),
                      child: PKCNICInputField(
                        cursorColor: Theme.of(context).primaryColor,
                        prefixIconColor: Colors.white,
                        onChanged: (val) => setState(() => cnic = val),
                      ),
                    ),
                    (cnic != '' &&
                            cnic.length == 15 &&
                            carModel != '' &&
                            color != '' &&
                            registrationNumber != '' &&
                            licenseUrl != '' &&
                            milage != -1)
                        ? Container(
                            margin: const EdgeInsets.only(top: 60),
                            child: LongButton(
                                handler: () => onSubmit(),
                                buttonText: 'Submit application',
                                isActive: true),
                          )
                        : Container(
                            margin: const EdgeInsets.only(top: 60),
                            child: LongButton(
                                handler: () {},
                                buttonText: 'Submit application',
                                isActive: false),
                          )
                  ]),
            ): Spinner(text: 'Submitting', height: 300),
          )),
    );
  }
}
