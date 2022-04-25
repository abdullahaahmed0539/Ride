import 'package:flutter/material.dart';
import 'package:frontend/api%20calls/disputes.dart';
import 'package:frontend/models/booking.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/providers/app.dart';
import 'package:frontend/providers/booking.dart';
import 'package:frontend/providers/user.dart';
import 'package:frontend/services/user_alert.dart';
import 'package:frontend/widgets/ui/dark_text_field.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import '../../widgets/ui/long_button.dart';
import '../../widgets/ui/text_area.dart';
import '../home.dart';

class PublishDispute extends StatefulWidget {
  static const routeName = '/publish_dispute';
  const PublishDispute({Key? key}) : super(key: key);

  @override
  State<PublishDispute> createState() => _PublishDisputeState();
}

class _PublishDisputeState extends State<PublishDispute> {
  String subject = '';
  String shortDescription = '';
  String description = '';
  bool agreed = false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  void setSubject(String val) {
    setState(() {
      subject = val;
    });
  }

  void setShortDescription(String val) {
    setState(() {
      shortDescription = val;
    });
  }

  void setDescription(String val) {
    setState(() {
      description = val;
    });
  }

  void onSubmit() async {
    User user = Provider.of<UserProvider>(context, listen: false).user;
    Booking booking =
        Provider.of<BookingProvider>(context, listen: false).booking;
    String appMode =
        Provider.of<AppProvider>(context, listen: false).app.getAppMode();
    if (appMode == 'driver') {
      Response response = await createDispute(
          user.id,
          booking.riderId,
          subject,
          shortDescription,
          description,
          'driver',
          user.phoneNumber,
          user.token);

      createDisputeResponseHandler(response);
    } else {
      Response response = await createDispute(
          user.id,
          booking.driverId,
          subject,
          shortDescription,
          description,
          'rider',
          user.phoneNumber,
          user.token);
      createDisputeResponseHandler(response);
    }
  }

  createDisputeResponseHandler(Response response) {
    if (response.statusCode == 201) {
     Navigator.of(context)
         .pushNamedAndRemoveUntil(Home.routeName, (route) => false);
    } else {
      snackBar(scaffoldKey, 'Error occured. Please try again.');
    }
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
          title: const Text('Create dispute'),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      margin: const EdgeInsets.only(top: 40),
                      child: Text(
                        'Please enter the details of the event which occurred.',
                        style: Theme.of(context).textTheme.titleLarge,
                      )),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: DarkTextField(
                      label: 'Subject',
                      placeholder: 'Enter subject',
                      onChangeHandler: (val) => setSubject(val),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: DarkTextField(
                        label: 'Short description',
                        placeholder: 'Enter short description',
                        onChangeHandler: (val) => setShortDescription(val),
                        keyboardType: TextInputType.text),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: TextArea(
                      radius: 5,
                      label: 'Description',
                      placeholder: 'Please Enter the details of the event.',
                      onChangeHandler: (val) => setDescription(val),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: Row(
                        children: [
                          Checkbox(
                            activeColor: Theme.of(context).primaryColor,
                            side: const BorderSide(
                              color: Colors.white,
                            ),
                            value: agreed,
                            onChanged: (value) {
                              setState(() {
                                agreed = value ?? false;
                              });
                            },
                          ),
                          const Expanded(
                              child: Text(
                            'I hereby declare that I am raising this dispute on my own will and that I shall be accountable if the results end up not in my favour. ',
                            style: TextStyle(fontSize: 14),
                          ))
                        ],
                      )),
                  agreed &&
                          subject != '' &&
                          shortDescription != '' &&
                          description != ''
                      ? Container(
                          margin: const EdgeInsets.only(top: 20, bottom: 40),
                          child: LongButton(
                              buttonText: 'Publish for voting',
                              handler: onSubmit,
                              isActive: true))
                      : Container(
                          margin: const EdgeInsets.only(top: 20, bottom: 40),
                          child: LongButton(
                              buttonText: 'Publish for voting',
                              handler: () {},
                              isActive: false))
                ]),
          ),
        ),
      ),
    );
  }
}
