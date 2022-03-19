import 'package:flutter/material.dart';
import 'package:frontend/widgets/ui/DarkTextField.dart';
import '../widgets/ui/LongButton.dart';
import '../widgets/ui/TextArea.dart';
import 'Home.dart';

class PublishDispute extends StatefulWidget {
  static const routeName = '/publish_dispute';
  const PublishDispute({Key? key}) : super(key: key);

  @override
  State<PublishDispute> createState() => _PublishDisputeState();
}

class _PublishDisputeState extends State<PublishDispute> {
  String title = '';
  String subject = '';
  String description = '';
  bool agreed = false;

  void setTitle(String val) {
    setState(() {
      title = val;
    });
  }

  void setSubject(String val) {
    setState(() {
      subject = val;
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
                      label: 'Title',
                      placeholder: 'Enter title',
                      onChangeHandler: (val) => setTitle(val.toLowerCase()),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: DarkTextField(
                      label: 'Subject',
                      placeholder: 'Enter subject',
                      onChangeHandler: (val) => setSubject(val.toLowerCase()),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: TextArea(
                      label: 'Description',
                      placeholder: 'Please Enter the details of the event.',
                      onChangeHandler: (val) =>
                          setDescription(val.toLowerCase()),
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
                  agreed && title!='' && subject!='' && description != ''
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
