import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/screens/Home.dart';
import 'package:frontend/screens/Register.dart';
import 'package:frontend/widgets/ui/CountDown.dart';
import 'package:frontend/widgets/ui/LongButton.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../providers/User.dart';
import 'dart:convert';
import '../widgets/ui/PinCodeField.dart';
import 'Login.dart';

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
        if (value.user != null) {
          login(phoneNumber, context);
        } else {
          setState(() {
            verifying = false;
          });
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
    );
  }

  Future<void> login(PhoneNumber phoneNumber, BuildContext context) async {
    try {
      final headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      };

      final body = jsonEncode(<String, String>{
        'phoneNumber': '${phoneNumber.countryCode}${phoneNumber.number}',
      });

      final response = await http.post(
          Uri.parse('http://10.0.2.2:5000/users/login'),
          headers: headers,
          body: body);
      if (response.statusCode == 404) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            Register.routeName, (route) => false,
            arguments: phoneNumber);
      } else if (response.statusCode == 200) {
        final user = Provider.of<UserProvider>(context, listen: false);
        var responseData = json.decode(response.body)['data'];
        String isoCode = responseData['phoneNumber'].substring(0, 3);
        String number = responseData['phoneNumber'].substring(3, 13);
        PhoneNumber extractedPhoneNumber = PhoneNumber(
            countryISOCode: responseData['country'],
            countryCode: isoCode,
            number: number);
        user.createUser(
            responseData['_id'],
            responseData['firstName'],
            responseData['lastName'],
            responseData['email'],
            extractedPhoneNumber,
            responseData['country'],
            responseData['walletAddress'],
            responseData['isDriver'],
            responseData['token'],
            responseData['expiresIn']);
        Navigator.of(context)
            .pushNamedAndRemoveUntil(Home.routeName, (route) => false);
      } else if (response.statusCode == 406) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(Login.routeName, (route) => false);
      } else {
        throw Error();
      }
    } catch (error) {
      print(error);
      setState(() {
        verifying = false;
      });
      scaffoldKey.currentState?.showSnackBar(const SnackBar(
        content: Text('Internal server error. Try again!'),
      ));
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

  Widget showEnabledNextButton() {
    final phoneNumber =
        ModalRoute.of(context)!.settings.arguments as PhoneNumber;
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

            if (value.user != null) {
              login(phoneNumber, context);
            } else {
              setState(() {
                verifying = false;
              });
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
