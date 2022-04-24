import 'package:flutter/material.dart';
import 'package:frontend/screens/voting/voting.dart';

import '../../widgets/ui/long_button.dart';

class VotingGuidelines extends StatefulWidget {
  static const routeName = '/voting_guidelines';
  const VotingGuidelines({Key? key}) : super(key: key);

  @override
  State<VotingGuidelines> createState() => _VotingGuidelinesState();
}

class _VotingGuidelinesState extends State<VotingGuidelines> {
  bool agreed = false;

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    
    
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Voting guidelines'),
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
                    margin: const EdgeInsets.only(top: 40),
                    child: Text(
                      'Did you know you can earn with voting? Here are guidelines for casting a vote.',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: Text(
                      '• Each user can cast only one vote in 24 hours.\n\n• Your vote can help those in need for justice. Vote wisely and help your community members.\n\n• You will get x RideCoins after you cast your vote, as a Reward for helping Ride community.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 250),
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
                        'I have read the terms and agreement and I hereby pledge an honour that I will vote as an honest member of the community.',
                        style: TextStyle(fontSize: 14),
                      ))
                    ]),
                  ),
                  agreed
                      ? Container(
                          margin: const EdgeInsets.only(top: 20, bottom: 40),
                          child: LongButton(
                              buttonText: 'Next',
                              handler: () => Navigator.of(context).pushNamed(
                                  Voting.routeName,
                                  arguments: {
                                    'disputeId': routeArgs['disputeId'],
                                    'from': routeArgs['from']
                                    }),
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
    );
  }
}
