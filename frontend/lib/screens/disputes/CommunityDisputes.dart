import 'package:flutter/material.dart';

class CommunityDisputes extends StatefulWidget {
  const CommunityDisputes({Key? key}) : super(key: key);

  @override
  State<CommunityDisputes> createState() => _CommunityDisputesState();
}

class _CommunityDisputesState extends State<CommunityDisputes> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Text('Help your community by voting on their disputes.', style: Theme.of(context).textTheme.titleLarge,),
                  )
                ])));
  }
}
