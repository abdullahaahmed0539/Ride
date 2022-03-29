import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/api%20calls/User.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

import '../models/User.dart';
import '../providers/User.dart';
import '../services/error.dart';
import '../widgets/ui/DarkTextField.dart';
import '../widgets/ui/LongButton.dart';
import '../widgets/ui/spinner.dart';
import 'Login.dart';
import 'Profile.dart';

class UpdateEmail extends StatefulWidget {
  static const routeName = '/update_email';
  const UpdateEmail({Key? key}) : super(key: key);

  @override
  State<UpdateEmail> createState() => _UpdateEmailState();
}

class _UpdateEmailState extends State<UpdateEmail> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String email = '';
  bool updating = false;

  void handleUpdateResponse(Response response) async {
    //Incase of internal server error or any other irrelevant error.
    if (response.statusCode != 201 &&
        response.statusCode != 204 &&
        response.statusCode != 404 &&
        response.statusCode != 406 &&
        response.statusCode != 401) {
      snackBar(scaffoldKey, 'Internal server error.');
    }
    //Incase of successfull updation
    if (response.statusCode == 201) {
      var responseData = json.decode(response.body)['data'];
      Provider.of<UserProvider>(context, listen: false)
          .updateUserEmail(responseData['updated_email']);
      snackBar(
          scaffoldKey, 'Successfully updated. Redirecting to profile page.');
      Navigator.of(context).pushNamedAndRemoveUntil(
          Profile.routeName, ModalRoute.withName('/home'));
    }

    // Incase of no changes in update
    if (response.statusCode == 204) {
      snackBar(scaffoldKey, 'No changes detected');
      return null;
    }

    //Incase of user not found
    if (response.statusCode == 404) {
      snackBar(scaffoldKey, 'No user with your mobile number found.');
      Navigator.of(context)
          .pushNamedAndRemoveUntil(Login.routeName, (route) => false);
      return null;
    }

    //Incase of access denied
    if (response.statusCode == 406) {
      snackBar(scaffoldKey, 'Incorrect email format.');
    }
    //Incase of access denied
    if (response.statusCode == 401) {
      snackBar(scaffoldKey, 'Unauthorized Access.');
    }
  }

  void onSubmit() async {
    setState(() {
      updating = true;
    });
    User user = Provider.of<UserProvider>(context, listen: false).user;
    try {
      Response updateResponse =
          await updateEmail(user.phoneNumber, email, user.token);
      await Future.delayed(const Duration(seconds: 3));
      handleUpdateResponse(updateResponse);
      setState(() {
        updating = false;
      });
    } catch (error) {
      setState(() {
        updating = false;
      });
      snackBar(scaffoldKey, 'Unknown Error occured.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            key: scaffoldKey,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text('Update email'),
            ),
            backgroundColor: Theme.of(context).backgroundColor,
            body: SingleChildScrollView(
                child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: !updating
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 30),
                                  child: Text(
                                    'Update your email',
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: Text(
                                      'Stay connected with us with latest updates and promoson your email',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  child: DarkTextField(
                                      label: 'Email',
                                      placeholder: 'Enter your email',
                                      onChangeHandler: (val) => setState(
                                          () => email = val.toLowerCase())),
                                ),
                                !isEmail(email) && email != ''
                                    ? Container(
                                        margin: const EdgeInsets.only(top: 5),
                                        child: const Text(
                                          'Incorrect email format.',
                                          style: TextStyle(
                                              color: Colors.redAccent,
                                              fontSize: 16),
                                        ))
                                    : Container(),
                                email != '' && isEmail(email)
                                    ? Container(
                                        margin: const EdgeInsets.only(top: 430),
                                        child: LongButton(
                                            buttonText: 'Update',
                                            isActive: true,
                                            handler: onSubmit),
                                      )
                                    : Container(
                                        margin: const EdgeInsets.only(top: 430),
                                        child: LongButton(
                                            buttonText: 'Update',
                                            isActive: false,
                                            handler: () {}),
                                      )
                              ])
                        : Spinner(text: 'Updating')))));
  }
}
