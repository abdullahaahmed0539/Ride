import 'package:flutter/material.dart';
import 'package:frontend/screens/voting/Voting.dart';
import 'package:frontend/screens/voting/VotingGuidelines.dart';

import '../../screens/disputes/DisputeTabs.dart';
import '../ui/CardItem.dart';
import '../ui/LongButton.dart';

class VotingShortcut extends StatelessWidget {
  dynamic disputes = [];
  VotingShortcut({Key? key, required this.disputes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return disputes.isNotEmpty
        ? Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            color: const Color(0xff333439),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 12, left: 12, bottom: 15),
                child: Text(
                  'THERE MIGHT BE SOME DISPUTES ON YOU',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              disputes.isNotEmpty
                  ? Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          ...disputes.map((dispute) {
                            return CardItem(
                                dispute['subject'],
                                dispute['shortDescription'],
                                'View and vote',
                                10,
                                3,
                                () => Navigator.of(context).pushNamed(
                                    VotingGuidelines.routeName,
                                    arguments: {'disputeId': dispute['_id'], 'from': 'home'}));
                          }).toList()
                        ],
                      ))
                  : Container(),
              Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                  child: LongButton(
                      handler: () => Navigator.of(context).pushNamed(
                          VotingGuidelines.routeName,
                          arguments: {'initialIndex': 2}),
                      buttonText: 'More',
                      isActive: true))
            ]))
        : Container();
  }
}
