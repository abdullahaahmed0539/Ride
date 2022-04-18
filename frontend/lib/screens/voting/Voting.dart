// ignore_for_file: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/api%20calls/Dispute.dart';
import 'package:frontend/screens/disputes/DisputeTabs.dart';
import 'package:frontend/widgets/ui/TextView.dart';
import 'package:frontend/widgets/ui/spinner.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../../models/User.dart';
import '../../providers/User.dart';
import '../../services/user_alert.dart';
import '../../widgets/ui/LongButton.dart';
import '../Home.dart';

class Voting extends StatefulWidget {
  static const routeName = '/voting';
  const Voting({Key? key}) : super(key: key);

  @override
  State<Voting> createState() => _VotingState();
}

class _VotingState extends State<Voting> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  late dynamic disputeDetail = {};
  bool isLoading = true;
  int? _groupValue = 0;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      User user = Provider.of<UserProvider>(context, listen: false).user;
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      final disputeId = routeArgs['disputeId'];
      Response response =
          await fetchDisputeDetail(disputeId, user.phoneNumber, user.token);
      fetchDisputeDetailResponseHandler(response);
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  void fetchDisputeDetailResponseHandler(Response response) {
    if (response.statusCode != 404 && response.statusCode != 200) {
      snackBar(scaffoldKey, 'Internal Server Error');
    }

    if (response.statusCode == 200) {
      setState(() {
        disputeDetail = json.decode(response.body)['data']['disputeDetails'];
      });
    }
  }

  void voteResponseHandler(Response response) {
    if (response.statusCode != 201 && response.statusCode != 401) {
      snackBar(scaffoldKey, 'Internal Server Error');
    }

    if (response.statusCode == 201) {
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      if (routeArgs['from'] == 'communityDisputes') {
        Navigator.of(context)
            .popUntil(ModalRoute.withName(DisputeTabs.routeName));
        Navigator.of(context).pushReplacementNamed(DisputeTabs.routeName,
            arguments: {'initialIndex': 2});
      } else {
        Navigator.of(context).popUntil(ModalRoute.withName(Home.routeName));
        Navigator.of(context).pushReplacementNamed(Home.routeName,
            arguments: {'initialIndex': 2});
      }
    }

    if (response.statusCode == 401) {
      snackBar(scaffoldKey, 'You have already voted on the following dispute');
    }
  }

  void vote() async {
    User user = Provider.of<UserProvider>(context, listen: false).user;
    Response response = await addVote(user.id, disputeDetail['_id'],
        _groupValue, user.phoneNumber, user.token);
    voteResponseHandler(response);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            key: scaffoldKey,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text('Voting'),
            ),
            backgroundColor: Theme.of(context).backgroundColor,
            body: SingleChildScrollView(
                child: !isLoading
                    ? Container(
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
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  )),
                              Container(
                                  margin: const EdgeInsets.only(top: 2),
                                  child:
                                      TextView(text: disputeDetail['subject'])),
                              Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  child: Text(
                                    'Initiator\'s claim',
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  )),
                              Container(
                                  margin: const EdgeInsets.only(top: 2),
                                  child: TextView(
                                      text: disputeDetail['initiatorsClaim'])),
                              Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  child: Text(
                                    'Defendent\'s claim',
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  )),
                              Container(
                                  margin: const EdgeInsets.only(top: 2),
                                  child: TextView(
                                      text: disputeDetail['defendentsClaim'])),
                              Container(
                                  margin: const EdgeInsets.only(top: 40),
                                  child: Text(
                                    'Who do you think is right?',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  )),
                              Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  child: Row(
                                    children: [
                                      Radio(
                                        fillColor:
                                            MaterialStateColor.resolveWith(
                                                (states) => Colors.white),
                                        toggleable: false,
                                        value: 0,
                                        groupValue: _groupValue,
                                        onChanged: (int? newValue) {
                                          setState(
                                              () => _groupValue = newValue);
                                        },
                                      ),
                                      Text(
                                        'Defendent',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                ],
                              ),
                              Container(
                                  margin: const EdgeInsets.only(top: 150),
                                  child: LongButton(
                                      buttonText: 'Publish for voting',
                                      handler: vote,
                                      isActive: true))
                            ]),
                      )
                    : Spinner(text: 'Fetching dispute', height: 300))));
  }
}
