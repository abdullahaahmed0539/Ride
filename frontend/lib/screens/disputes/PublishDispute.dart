// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:frontend/widgets/ui/DarkTextField.dart';
import '../../widgets/ui/LongButton.dart';
import '../../widgets/ui/TextArea.dart';
import '../Home.dart';

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

  void onSubmit() {
    //http request for submission
    Navigator.of(context)
        .pushNamedAndRemoveUntil(Home.routeName, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: DarkTextField(
                      label: 'Short description',
                      placeholder: 'Enter short description',
                      onChangeHandler: (val) => setShortDescription(val),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: TextArea(
                      radius: 5,
                      label: 'Description',
                      placeholder: 'Please Enter the details of the event.',
                      onChangeHandler: (val) =>
                          setDescription(val),
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
                  agreed &&  subject != '' && shortDescription != ''  && description != ''
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
