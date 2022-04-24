// ignore_for_file: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/api%20calls/dispute.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../providers/user.dart';
import '../../widgets/ui/card_item.dart';
import '../../widgets/ui/spinner.dart';
import 'dispute_detail.dart';

class DisputeOnYou extends StatefulWidget {
  const DisputeOnYou({Key? key}) : super(key: key);

  @override
  State<DisputeOnYou> createState() => _DisputeOnYouState();
}

class _DisputeOnYouState extends State<DisputeOnYou> {
  List<dynamic> disputeOnMe = [];
  bool isLoading = true;

  @override
  void initState() {
    Future.delayed(Duration.zero, fetchDisputeOnMeFromServer);
    super.initState();
  }

  Future fetchDisputeOnMeFromServer() async {
    User user = Provider.of<UserProvider>(context, listen: false).user;

    final response =
        await fetchDisputesOnMe(user.id, user.phoneNumber, user.token);
    fetchDisputesOnMeHandler(response);
    setState(() {
      isLoading = false;
    });
  }

  void fetchDisputesOnMeHandler(Response response) {
    if (response.statusCode != 404 && response.statusCode != 200) {}

    if (response.statusCode == 200) {
      setState(() {
        disputeOnMe = json.decode(response.body)['data']['disputes'];
      });
    }

    if (response.statusCode == 404) {
      setState(() {
        disputeOnMe = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final pendingDispute =
        disputeOnMe.where((dispute) => dispute['status'] == 'pending').toList();
    final activeDispute =
        disputeOnMe.where((dispute) => dispute['status'] == 'active').toList();
    final completeDispute = disputeOnMe
        .where((dispute) => dispute['status'] == 'completed')
        .toList();
    return !isLoading
        ? RefreshIndicator(
            onRefresh: () => fetchDisputeOnMeFromServer(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
                child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: (pendingDispute.isNotEmpty ||
                            completeDispute.isNotEmpty ||
                            pendingDispute.isNotEmpty)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                                pendingDispute.isNotEmpty
                                    ? Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        child: Text(
                                          'Pending',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                      )
                                    : Container(),
                                pendingDispute.isNotEmpty
                                    ? Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        child: Column(
                                          children: [
                                            ...pendingDispute.map((dispute) {
                                              return CardItem(
                                                  dispute['subject'],
                                                  dispute['shortDescription'],
                                                  'View details',
                                                  0,
                                                  5,
                                                  () => Navigator.of(context)
                                                          .pushNamed(
                                                              DisputeDetail
                                                                  .routeName,
                                                              arguments: {
                                                            'disputeId':
                                                                dispute['_id']
                                                          }));
                                            }).toList()
                                          ],
                                        ))
                                    : Container(),
                                activeDispute.isNotEmpty
                                    ? Container(
                                        margin: const EdgeInsets.only(top: 30),
                                        child: Text(
                                          'Active',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                      )
                                    : Container(),
                                activeDispute.isNotEmpty
                                    ? Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        child: Column(
                                          children: [
                                            ...activeDispute.map((dispute) {
                                              return CardItem(
                                                  dispute['subject'],
                                                  dispute['shortDescription'],
                                                  'View details',
                                                  0,
                                                  5,
                                                  () => Navigator.of(context)
                                                          .pushNamed(
                                                              DisputeDetail
                                                                  .routeName,
                                                              arguments: {
                                                            'disputeId':
                                                                dispute['_id']
                                                          }));
                                            }).toList()
                                          ],
                                        ))
                                    : Container(),
                                completeDispute.isNotEmpty
                                    ? Container(
                                        margin: const EdgeInsets.only(top: 30),
                                        child: Text(
                                          'Completed',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                      )
                                    : Container(),
                                completeDispute.isNotEmpty
                                    ? Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        child: Column(
                                          children: [
                                            ...completeDispute.map((dispute) {
                                              return CardItem(
                                                  dispute['subject'],
                                                  dispute['shortDescription'],
                                                  'View details',
                                                  0,
                                                  5,
                                                  () => Navigator.of(context)
                                                          .pushNamed(
                                                              DisputeDetail
                                                                  .routeName,
                                                              arguments: {
                                                            'disputeId':
                                                                dispute['_id']
                                                          }));
                                            }).toList()
                                          ],
                                        ))
                                    : Container(),
                              ])
                        : Center(
                            child: Text(
                              'There are no disputes on you',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ))),
          )
        : Spinner(text: 'Fetching your disputes', height: 0);
  }
}
