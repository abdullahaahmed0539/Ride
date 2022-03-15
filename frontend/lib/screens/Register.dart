import 'package:flutter/material.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:validators/validators.dart';
import 'package:frontend/screens/Home.dart';
import 'package:frontend/widgets/ui/DarkTextField.dart';
import 'package:frontend/widgets/ui/LongButton.dart';

class Register extends StatefulWidget {
  static const routeName = '/register';
  final PhoneNumber phoneNumber;
  const Register({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String firstName = '';
  String lastName = '';
  String email = '';
  String walletAddress = '';

  void onFirstNameChange(String val) {
    setState(() {
      firstName = val;
    });
  }

  void onLastNameChange(String val) {
    setState(() {
      lastName = val;
    });
  }

  void onEmailChange(String val) {
    setState(() {
      email = val;
    });
  }

  void onWalletAddressChange(String val) {
    setState(() {
      walletAddress = val;
    });
  }

  void onCreateAccount() {
    //add http req
    Navigator.of(context).pop();
    Navigator.of(context).pushNamed(
     Home.routeName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(title: const Text('Register')),
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [
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
                    onChangeHandler: (val) =>
                        onFirstNameChange(val.toLowerCase())),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: DarkTextField(
                    label: 'Last name',
                    placeholder: 'Enter your last name',
                    onChangeHandler: (val) =>
                        onLastNameChange(val.toLowerCase())),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: DarkTextField(
                    label: 'E-mail',
                    placeholder: 'Enter your email',
                    onChangeHandler: (val) => onEmailChange(val)),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: DarkTextField(
                    label: 'Metamask wallet Address',
                    placeholder: 'Enter your metamask wallet address',
                    onChangeHandler: (val) => onWalletAddressChange(val)),
              ),
              (firstName != '' &&
                      lastName != '' &&
                      isEmail(email) &&
                      walletAddress != '')
                  ? Container(
                      margin: const EdgeInsets.only(top: 200),
                      child: LongButton(
                          handler: () => onCreateAccount(),
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
            ]),
          )),
    );
  }
}
