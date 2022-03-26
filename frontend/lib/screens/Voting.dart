import 'package:flutter/material.dart';
import 'package:frontend/widgets/ui/TextView.dart';

import '../widgets/ui/LongButton.dart';
import 'Home.dart';

class Voting extends StatefulWidget {
  static const routeName = '/voting';
  const Voting({Key? key}) : super(key: key);

  @override
  State<Voting> createState() => _VotingState();
}

class _VotingState extends State<Voting> {
  String subject = 'Subject', defendentsClaim = 'DC', initiatorsClaim = 'IC';
  int? _groupValue = 0;

  @override
  void initState() {
    super.initState();
    //call api for fetching dispute
    //assign it to states
  }

  void vote() {
    //publish vote
    Navigator.of(context)
        .pushNamedAndRemoveUntil(Home.routeName, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text('Voting'),
            ),
            backgroundColor: Theme.of(context).backgroundColor,
            body: SingleChildScrollView(
                child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: Text(
                        'Read the dispute matter and vote.',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Text(
                          'Subject',
                          style: Theme.of(context).textTheme.titleSmall,
                        )),
                    Container(
                        margin: const EdgeInsets.only(top: 2),
                        child: TextView(text: subject)),
                    Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Text(
                          'Initiator\'s claim',
                          style: Theme.of(context).textTheme.titleSmall,
                        )),
                    Container(
                        margin: const EdgeInsets.only(top: 2),
                        child: TextView(text: initiatorsClaim)),
                    Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Text(
                          'Defendent\'s claim',
                          style: Theme.of(context).textTheme.titleSmall,
                        )),
                    Container(
                        margin: const EdgeInsets.only(top: 2),
                        child: TextView(text: defendentsClaim)),
                    Container(
                        margin: const EdgeInsets.only(top: 40),
                        child: Text(
                          'Who do you think is right?',
                          style: Theme.of(context).textTheme.titleMedium,
                        )),
                    Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Row(
                          children: [
                            Radio(
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.white),
                              toggleable: false,
                              value: 0,
                              groupValue: _groupValue,
                              onChanged: (int? newValue) {
                                setState(() => _groupValue = newValue);
                              },
                            ),
                            Text(
                              'Defendent',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        )),
                    Row(
                      children: [
                        Radio(
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => Colors.white),
                          toggleable: false,
                          value: 1,
                          groupValue: _groupValue,
                          onChanged: (int? newValue) {
                            setState(() => _groupValue = newValue);
                          },
                        ),
                        Text('Initiator',
                            style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 150),
                        child: LongButton(
                            buttonText: 'Publish for voting',
                            handler: vote,
                            isActive: true))
                  ]),
            ))));
  }
}
