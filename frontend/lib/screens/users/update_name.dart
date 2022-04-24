import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/api%20calls/user.dart';
import 'package:frontend/providers/user.dart';
import 'package:frontend/services/user_alert.dart';
import 'package:frontend/widgets/ui/spinner.dart';
import 'package:frontend/widgets/ui/dark_text_field.dart';
import 'package:frontend/widgets/ui/long_button.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import 'login.dart';
import '../profile.dart';

class UpdateName extends StatefulWidget {
  static const routeName = '/update_name';
  const UpdateName({Key? key}) : super(key: key);

  @override
  State<UpdateName> createState() => _UpdateNameState();
}

class _UpdateNameState extends State<UpdateName> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String firstName = '';
  String lastName = '';
  bool updating = false;

  void handleUpdateResponse(Response response) async {
    //Incase of internal server error or any other irrelevant error.
    if (response.statusCode != 201 &&
        response.statusCode != 204 &&
        response.statusCode != 404 &&
        response.statusCode != 401) {
      snackBar(scaffoldKey, 'Internal server error.');
    }
    //Incase of successfull updation
    if (response.statusCode == 201) {
      var responseData = json.decode(response.body)['data'];
      Provider.of<UserProvider>(context, listen: false).user.updateUserName(
          responseData['updated_first_name'],
          responseData['updated_last_name']);
      snackBar(scaffoldKey, 'Successfully updated.');
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
          await updateName(user.phoneNumber, firstName, lastName, user.token);
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
              title: const Text('Update name'),
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
                            'Update your name',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Text(
                              'Your name makes it easy for captains to confirm who they are picking up ',
                              style: Theme.of(context).textTheme.bodyMedium),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: DarkTextField(
                              label: 'First name',
                              placeholder: 'Enter your first name',
                              keyboardType: TextInputType.text,
                              onChangeHandler: (val) => setState(
                                  () => firstName = val.toLowerCase())),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: DarkTextField(
                              label: 'Last name',
                              placeholder: 'Enter your last name',
                              keyboardType: TextInputType.text,
                              onChangeHandler: (val) =>
                                  setState(() => lastName = val.toLowerCase())),
                        ),
                        firstName != '' && lastName != ''
                            ? Container(
                                margin: const EdgeInsets.only(top: 350),
                                child: LongButton(
                                    buttonText: 'Update',
                                    isActive: true,
                                    handler: onSubmit),
                              )
                            : Container(
                                margin: const EdgeInsets.only(top: 350),
                                child: LongButton(
                                    buttonText: 'Update',
                                    isActive: false,
                                    handler: () {}),
                              )
                      ],
                    )
                  : Spinner(text: 'Updating', height: 300,),
            ))));
  }
}
