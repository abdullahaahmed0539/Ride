import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/screens/Home.dart';
import 'package:frontend/widgets/ui/CountDown.dart';
import 'package:frontend/widgets/ui/LongButton.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../widgets/ui/PinCodeField.dart';

class Verification extends StatefulWidget {
  static const routeName = '/verification';
  const Verification({Key? key}) : super(key: key);

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  late String verificationCode;
  String currentText = "";
  bool verifying = false;
  bool otpExpired = false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final CountDownController controller = CountDownController();

  void setCurrentText(String val) {
    setState(() {
      currentText = val;
    });
  }

  void onTimerComplete() {
    setState(() {
      otpExpired = true;
    });
  }

  void verifyPhone() async {
    final phoneNumber =
        ModalRoute.of(context)!.settings.arguments as PhoneNumber;
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '${phoneNumber.countryCode}${phoneNumber.number}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          setState(() {
            verifying = true;
          });
          UserCredential value =
              await FirebaseAuth.instance.signInWithCredential(credential);
          setState(() {
            verifying = false;
          });
          if (value.user != null) {
            Navigator.of(context).pushNamedAndRemoveUntil(Home.routeName, (r) => false);
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          setState(() {
            verifying = false;
          });
          scaffoldKey.currentState?.showSnackBar(SnackBar(
            content: Text(e.code),
          ));
        },
        codeSent: (verificationID, resendToken) {
          setState(() {
            verificationCode = verificationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            verificationCode = verificationID;
          });
        },
        timeout: const Duration(seconds: 60),
        forceResendingToken: );

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

  Widget showEnabledNextButton() {
    return Container(
      margin: const EdgeInsets.only(top: 200),
      child: LongButton(
        handler: () async {
          try {
            setState(() {
              verifying = true;
            });
            UserCredential value = await FirebaseAuth.instance
                .signInWithCredential(PhoneAuthProvider.credential(
                    verificationId: verificationCode, smsCode: currentText));
            setState(() {
              verifying = false;
            });
            if (value.user != null) {
              Navigator.of(context).pushNamedAndRemoveUntil(Home.routeName, (r) => false);
            }
          } on FirebaseAuthException catch (e) {
            setState(() {
              verifying = false;
            });
            FocusScope.of(context).unfocus();
            // ignore: deprecated_member_use
            scaffoldKey.currentState
                ?.showSnackBar(SnackBar(content: Text(e.code)));
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
    final phoneNumber =
        ModalRoute.of(context)!.settings.arguments as PhoneNumber;
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

  Widget onVerifying() {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        CircularProgressIndicator(
          color: Theme.of(context).primaryColor,
        ),
        Container(
            margin: const EdgeInsets.only(top: 10),
            child: const Text(
              'Verifying',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'SF-Pro-Rounded',
                  fontSize: 14),
            ))
      ]),
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
          body: verifying ? onVerifying() : otpVerification()),
    );
  }
}
