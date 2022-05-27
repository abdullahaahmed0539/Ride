import 'package:flutter/material.dart';
import 'create_dispute.dart';
import '../../widgets/ui/long_button.dart';

class DisputeGuidelines extends StatefulWidget {
  static const routeName = '/dispute_guidelines';
  const DisputeGuidelines({Key? key}) : super(key: key);
  @override
  State<DisputeGuidelines> createState() => _DisputeGuidelinesState();
}

class _DisputeGuidelinesState extends State<DisputeGuidelines> {
  bool agreed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Dispute guidelines'),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: RawScrollbar(
          thumbColor: const Color.fromARGB(255, 109, 109, 109),
          isAlwaysShown: true,
          radius: const Radius.circular(20),
          thickness: 5,
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Text(
                        'We are really sorry for your bad experience. Before you proceed ahead, here are some guidelines related to raising a dispute for voting.',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Text(
                        '• Once a issue has been raised for polling, you can not bring the issue down.\n\n• Once you have submitted the issue, your captain will get a chance to justify his actions. This is done so that the community can judge based on both parties point of view.\n\n•The community will vote on your dispute, and the party with majority votes after 12 hours wins.\n\n• If you win the dispute, you will not be charged for any fee for that ride. Instead, you will be given the fare amount as compensation for your bad experience. The captain will also be given a strike for his actions.\n\n• If you lose the dispute, then you will be charged the whole fare amount and at the same time given a strike.\n\n• If a captain or a rider reaches 3 strikes, they are stripped of from their duties as a captain. Hence, raise a dispute wisely.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Row(children: [
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
                          'I have read the terms and agreement and I hereby pledge an honour that I will not raise a false dispute.',
                          style: TextStyle(fontSize: 14),
                        ))
                      ]),
                    ),
                    agreed
                        ? Container(
                            margin: const EdgeInsets.only(top: 20, bottom: 40),
                            child: LongButton(
                                buttonText: 'Next',
                                handler: () {
                                  final total = ModalRoute.of(context)!
                                      .settings
                                      .arguments as int;
                                  Navigator.of(context).pushNamed(
                                      PublishDispute.routeName,
                                      arguments: total);
                                },
                                isActive: true))
                        : Container(
                            margin: const EdgeInsets.only(top: 20, bottom: 40),
                            child: LongButton(
                                buttonText: 'Next',
                                handler: () {},
                                isActive: false))
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
