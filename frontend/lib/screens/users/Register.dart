import 'package:flutter/material.dart';
import 'package:frontend/widgets/ui/spinner.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

import '../../services/utilities.dart';
import '../home.dart';
import '../../widgets/ui/dark_text_field.dart';
import '../../widgets/ui/long_button.dart';
import '../../api calls/users.dart';
import '../../providers/user.dart';
import '../../services/user_alert.dart';
import 'login.dart';

class Register extends StatefulWidget {
  static const routeName = '/register';
  const Register({Key? key}) : super(key: key);
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String firstName = '';
  String lastName = '';
  String email = '';
  String walletAddress = '';
  bool loading = false;

  void loginHandling(Response response) {
    if (response.statusCode == 200) {
      Provider.of<UserProvider>(context, listen: false)
          .user
          .onLogin(response, context);
      Navigator.of(context)
          .pushNamedAndRemoveUntil(Home.routeName, (route) => false);
    } else {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(Login.routeName, (route) => false);
    }
  }

  void onCreateAccount(PhoneNumber phoneNumber) async {
    if (mounted) {
      setState(() {
        loading = true;
      });
    }
    try {
      Response registerResponse = await register(
          phoneNumber, firstName, lastName, email, walletAddress);
      if (registerResponse.statusCode == 201) {
        var responseData = json.decode(registerResponse.body)['data'];
        PhoneNumber extractedPhoneNumber = convertToPhoneNumber(
            responseData['phoneNumber'], responseData['country']);
        Response loginResponse = await login(extractedPhoneNumber);
        loginHandling(loginResponse);
      } else if (registerResponse.statusCode == 500) {
        throw Error();
      } else {
        if (mounted) {
          setState(() {
            loading = false;
          });
        }
        snackBar(scaffoldKey,
            'A user with the provided e-mail or metamask wallet already exists.');
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
      snackBar(scaffoldKey, 'Internal server error. Try login in again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    PhoneNumber phoneNumber =
        ModalRoute.of(context)!.settings.arguments as PhoneNumber;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          key: scaffoldKey,
          resizeToAvoidBottomInset: false,
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(title: const Text('Register')),
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: !loading
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Container(
                            margin: const EdgeInsets.only(top: 60),
                            child: Text(
                              'Your first time here? Tell us more about yourself. ',
                              style: Theme.of(context).textTheme.titleLarge,
                            )),
                        Container(
                          margin: const EdgeInsets.only(top: 25, bottom: 5),
                          child: DarkTextField(
                            label: 'First name',
                            placeholder: 'Enter your first name',
                            color: Colors.transparent,
                            keyboardType: TextInputType.text,
                            onChangeHandler: (val) =>
                                setState(() => firstName = val.toLowerCase()),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: DarkTextField(
                            label: 'Last name',
                            placeholder: 'Enter your last name',
                            color: Colors.transparent,
                            keyboardType: TextInputType.text,
                            onChangeHandler: (val) =>
                                setState(() => lastName = val.toLowerCase()),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          child: DarkTextField(
                              label: 'E-mail',
                              placeholder: 'Enter your email',
                              color: Colors.transparent,
                              keyboardType: TextInputType.emailAddress,
                              onChangeHandler: (val) =>
                                  setState(() => email = val)),
                        ),
                        !isEmail(email) && email != ''
                            ? Container(
                                margin: const EdgeInsets.only(top: 1),
                                child: const Text(
                                  'Incorrect email format.',
                                  style: TextStyle(
                                      color: Colors.redAccent, fontSize: 16),
                                ))
                            : Container(),
                        Container(
                          margin: const EdgeInsets.only(top: 16),
                          child: DarkTextField(
                              label: 'Metamask wallet Address',
                              keyboardType: TextInputType.text,
                              color: Colors.transparent,
                              placeholder: 'Enter your metamask wallet address',
                              onChangeHandler: (val) =>
                                  setState(() => walletAddress = val)),
                        ),
                        (firstName != '' &&
                                lastName != '' &&
                                isEmail(email) &&
                                walletAddress != '')
                            ? Container(
                                margin: const EdgeInsets.only(top: 200),
                                child: LongButton(
                                    handler: () => onCreateAccount(phoneNumber),
                                    buttonText: 'Create account',
                                    isActive: true),
                              )
                            : Container(
                                margin: const EdgeInsets.only(top: 200),
                                child: LongButton(
                                    handler: () {},
                                    buttonText: 'Create account',
                                    isActive: false),
                              )
                      ])
                : Spinner(text: 'Registering', height: 0),
          )),
    );
  }
}
