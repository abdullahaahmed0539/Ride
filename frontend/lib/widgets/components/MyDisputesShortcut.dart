// ignore_for_file: file_names
import 'package:flutter/material.dart';

import '../../screens/disputes/DisputeDetail.dart';
import '../../screens/disputes/DisputeTabs.dart';
import '../ui/CardItem.dart';
import '../ui/LongButton.dart';

// ignore: must_be_immutable
class MyDisputesShortcut extends StatelessWidget {
  dynamic myDisputes = [];
  MyDisputesShortcut({Key? key, required this.myDisputes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return myDisputes.isNotEmpty
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
              myDisputes.isNotEmpty
                  ? Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          ...myDisputes.map((dispute) {
                            return CardItem(
                                dispute['subject'],
                                dispute['shortDescription'],
                                'View results',
                                10,
                                3,
                                () => Navigator.of(context).pushNamed(
                                    DisputeDetail.routeName,
                                    arguments: {'disputeId': dispute['_id']}));
                          }).toList()
                        ],
                      ))
                  : Container(),
              Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                  child: LongButton(
                      handler: () => Navigator.of(context).pushNamed(
                          DisputeTabs.routeName,
                          arguments: {'initialIndex': 0}),
                      buttonText: 'More',
                      isActive: true))
            ]))
        : Container();
  }
}
