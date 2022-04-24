import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/screens/users/update_phone_number.dart';
import 'package:frontend/services/user_alert.dart';
import 'package:frontend/widgets/ui/spinner.dart';
import 'package:http/http.dart';
import 'package:intl_phone_field/phone_number.dart';
import '../../services/utilities.dart';
import '../home.dart';
import 'register.dart';
import 'package:frontend/widgets/ui/count_down.dart';
import 'package:frontend/widgets/ui/long_button.dart';
import 'package:provider/provider.dart';
import '../../providers/user.dart';
import '../../widgets/ui/pin_code_field.dart';
import 'login.dart';
import '../../api calls/user.dart';
import '../../models/user.dart' as custom_user;
import '../profile.dart';

class Verification extends StatefulWidget {
  static const routeName = '/verification';
  const Verification({Key? key}) : super(key: key);

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  late String verificationCode;
  String currentText = "";
  bool verifying = false;
  bool otpExpired = false;
  final CountDownController controller = CountDownController();

  void setCurrentText(String val) {
    if (mounted) {
      setState(() {
        currentText = val;
      });
    }
  }

  void onTimerComplete() {
    if (mounted) {
      setState(() {
        otpExpired = true;
      });
    }
  }

  void verifyPhone() async {
    if (mounted) {
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      final phoneNumber = routeArgs['phoneNumber'];
      final previousScreen = routeArgs['previousScreen'];
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '${phoneNumber.countryCode}${phoneNumber.number}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          if (mounted) {
            setState(() => verifying = true);
          }
          UserCredential value =
              await FirebaseAuth.instance.signInWithCredential(credential);

          if (value.user != null) {
            previousScreen == 'login'
                ? loginHandler(phoneNumber)
                : updatePhoneNumberHandler(phoneNumber);
          } else {
            if (mounted) {
              setState(() => verifying = false);
            }
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          if (mounted) {
            setState(() => verifying = false);
          }
          snackBar(scaffoldKey, e.code);
        },
        codeSent: (verificationID, resendToken) {
          if (mounted) {
            setState(() => verificationCode = verificationID);
          }
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          if (mounted) {
            setState(() => verificationCode = verificationID);
          }
        },
        timeout: const Duration(seconds: 90),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      verifyPhone();
    });
  }

  Widget showDisabledNextButton() {
    return Container(
      margin: const EdgeInsets.only(top: 200),
      child: LongButton(
        handler: () {},
        buttonText: 'Next',
        isActive: false,
      ),
    );
  }

  void loginHandler(PhoneNumber phoneNumber) async {
    if (mounted) {
      var response = await login(phoneNumber);
      if (response.statusCode == 200) {
        Provider.of<UserProvider>(context, listen: false)
            .user
            .onLogin(response, context);
        Navigator.of(context)
            .pushNamedAndRemoveUntil(Home.routeName, (route) => false);
      } else if (response.statusCode == 404) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            Register.routeName, ModalRoute.withName('/login'),
            arguments: phoneNumber);
      } else if (response.statusCode == 406) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(Login.routeName, (route) => false);
      } else {
        if (mounted) {
          setState(() => verifying = false);
        }
        snackBar(scaffoldKey, 'Internal server error. Try again!');
      }
    }
  }

  void updatePhoneNumberHandler(PhoneNumber phoneNumber) async {
    custom_user.User user =
        Provider.of<UserProvider>(context, listen: false).user;
    //http to update
    Response response =
        await updatePhoneNumber(user.phoneNumber, phoneNumber, user.token);

    if (response.statusCode != 201 &&
        response.statusCode != 204 &&
        response.statusCode != 404 &&
        response.statusCode != 406 &&
        response.statusCode != 401) {
      snackBar(scaffoldKey, 'Internal server error.');
      if (mounted) {
        setState(() => verifying = false);
      }
    }

    if (response.statusCode == 201) {
      var responseData = json.decode(response.body)['data'];
      PhoneNumber extractedPhoneNumber = convertToPhoneNumber(
          responseData['updated_phoneNumber'], responseData['country']);
      Provider.of<UserProvider>(context, listen: false)
          .user
          .updateUserPhoneNumberAndCountry(extractedPhoneNumber,
              responseData['country'], responseData['token']);
      Navigator.of(context).pushNamedAndRemoveUntil(
          Profile.routeName, ModalRoute.withName('/home'));
    }

    if (response.statusCode == 204) {
      snackBar(scaffoldKey, 'No changes detected');
      await Future.delayed(const Duration(seconds: 2));
      Navigator.of(context).pop();
    }

    //Incase of user not found
    if (response.statusCode == 404) {
      snackBar(scaffoldKey, 'No user with your mobile number found.');
      await Future.delayed(const Duration(seconds: 2));
      Navigator.of(context)
          .pushNamedAndRemoveUntil(Login.routeName, (route) => false);
    }

    //Incase of incorrect mobile format
    if (response.statusCode == 406) {
      await Future.delayed(const Duration(seconds: 2));
      snackBar(scaffoldKey, 'Incorrect mobile format.');
      Navigator.of(context).pushNamedAndRemoveUntil(
          UpdatePhoneNumber.routeName, (route) => false);
    }
    //Incase of access denied
    if (response.statusCode == 401) {
      snackBar(scaffoldKey, 'Unauthorized Access.');
      if (mounted) {
        setState(() => verifying = false);
      }
    }
  }

  Widget showEnabledNextButton() {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final phoneNumber = routeArgs['phoneNumber'];
    final String previousScreen = routeArgs['previousScreen'];
    return Container(
      margin: const EdgeInsets.only(top: 200),
      child: LongButton(
        handler: () async {
          try {
            if (mounted) {
              setState(() => verifying = true);
            }
            UserCredential value = await FirebaseAuth.instance
                .signInWithCredential(PhoneAuthProvider.credential(
                    verificationId: verificationCode, smsCode: currentText));
            if (value.user != null) {
              previousScreen == 'login'
                  ? loginHandler(phoneNumber)
                  : updatePhoneNumberHandler(phoneNumber);
            } else {
              if (mounted) {
                setState(() => verifying = false);
              }
            }
          } on FirebaseAuthException catch (e) {
            if (mounted) {
              setState(() => verifying = false);
            }
            FocusScope.of(context).unfocus();
            snackBar(scaffoldKey, e.code);
          }
        },
        buttonText: 'Next',
        isActive: true,
      ),
    );
  }

  Widget showDisableResendCodeButton() {
    return const TextButton(
        onPressed: null,
        child: Text(
          'Resend Code',
          style: TextStyle(
            color: Colors.grey,
            fontFamily: "SF-Pro-Display",
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ));
  }

  Widget showEnableResendCodeButton() {
    return TextButton(
        style: TextButton.styleFrom(
          primary: const Color(0xff9F61F0),
        ),
        onPressed: () {
          verifyPhone();
          controller.start();
          otpExpired = false;
        },
        child: const Text(
          'Resend Code',
          style: TextStyle(
            fontFamily: "SF-Pro-Display",
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ));
  }

  Widget otpVerification() {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final phoneNumber = routeArgs['phoneNumber'];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 60, bottom: 50),
            child: Text(
              'Enter the 6-digit verification code sent to you at ${phoneNumber.countryCode} ${phoneNumber.number}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          CountDown(controller: controller, handler: onTimerComplete),
          Container(
              margin: const EdgeInsets.only(top: 50),
              child: PinCodeField(onComplete: setCurrentText)),
          Row(
            children: [
              Text(
                'Did not get a message?',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              otpExpired
                  ? showEnableResendCodeButton()
                  : showDisableResendCodeButton()
            ],
          ),
          currentText.length == 6
              ? showEnabledNextButton()
              : showDisabledNextButton()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          key: scaffoldKey,
          resizeToAvoidBottomInset: false,
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            title: const Text('Phone verification'),
          ),
          body: verifying
              ? Spinner(text: 'Verifying', height: 0)
              : otpVerification()),
    );
  }
}
