import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/screens/voting/VotingGuidelines.dart';
import 'package:frontend/widgets/ui/spinner.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../../api calls/Dispute.dart';
import '../../models/User.dart';
import '../../providers/User.dart';
import '../../widgets/ui/CardItem.dart';
import 'DisputeDetail.dart';

class CommunityDisputes extends StatefulWidget {
  const CommunityDisputes({Key? key}) : super(key: key);

  @override
  State<CommunityDisputes> createState() => _CommunityDisputesState();
}

class _CommunityDisputesState extends State<CommunityDisputes> {
  List<dynamic> disputes = [];
  bool isLoading = true;

  @override
  void initState() {
    Future.delayed(Duration.zero, fetchDisputesForVotingFromServer);
    super.initState();
  }

  Future fetchDisputesForVotingFromServer() async {
    User user = Provider.of<UserProvider>(context, listen: false).user;
    final response =
        await fetchDisputesForVoting(user.id, user.phoneNumber, user.token);
    fetchDisputesResponseHandler(response);
    setState(() {
      isLoading = false;
    });
  }

  void fetchDisputesResponseHandler(Response response) {
    if (response.statusCode != 404 && response.statusCode != 200) {}

    if (response.statusCode == 200) {
      setState(() {
        disputes = json.decode(response.body)['data']['disputes'];
      });
    }

    if (response.statusCode == 404) {
      setState(() {
        disputes = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return !isLoading
        ? RefreshIndicator(
          onRefresh: () => fetchDisputesForVotingFromServer(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
              child: disputes.isNotEmpty? Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10,bottom: 10),
                          child: Text(
                            'Help your community by voting on their disputes.',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        ...disputes.map((dispute) {
                          return CardItem(
                              dispute['subject'],
                              dispute['shortDescription'],
                              'View and vote',
                              0,
                              5,
                              () => Navigator.of(context).pushNamed(
                                  VotingGuidelines.routeName,
                                  arguments: {
                                    'disputeId': dispute['_id'],
                                    'from': 'communityDisputes'
                                    }));
                        }).toList()
                      ])): Container(
                        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        child: Center(
                                  child: Text(
                                    'There are no disputes to vote on',
                                    style: Theme.of(context).textTheme.titleSmall,
                                  ),
                                ),
                      )),
        )
        : Spinner(text: 'Fetching disputes', height: 0);
  }
}
