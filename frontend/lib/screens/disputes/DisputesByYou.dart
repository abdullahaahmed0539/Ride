import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/screens/disputes/DisputeDetail.dart';
import 'package:frontend/widgets/ui/CardItem.dart';
import 'package:frontend/widgets/ui/spinner.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import '../../api calls/Dispute.dart';
import '../../models/User.dart';
import '../../providers/User.dart';

class DisputesByYou extends StatefulWidget {
  const DisputesByYou({
    Key? key,
  }) : super(key: key);

  @override
  State<DisputesByYou> createState() => _DisputesByYou();
}

class _DisputesByYou extends State<DisputesByYou> {
  List<dynamic> myDisputes = [];
  bool isLoading = true;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      User user = Provider.of<UserProvider>(context, listen: false).user;

      final response =
          await fetchMyDisputes(user.id, user.phoneNumber, user.token);
      fetchDisputesResponseHandler(response);
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  void fetchDisputesResponseHandler(Response response) {
    if (response.statusCode != 404 && response.statusCode != 200) {}

    if (response.statusCode == 200) {
      setState(() {
        myDisputes = json.decode(response.body)['data']['disputes'];
      });
    }

    if (response.statusCode == 404) {
      setState(() {
        myDisputes = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final pendingDisputes =
        myDisputes.where((dispute) => dispute['status'] == 'pending').toList();
    final activeDisputes =
        myDisputes.where((dispute) => dispute['status'] == 'active').toList();
    final completeDisputes = myDisputes
        .where((dispute) => dispute['status'] == 'completed')
        .toList();
    return !isLoading
        ? SingleChildScrollView(
            child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child:
                    (activeDisputes.isNotEmpty ||
                            completeDisputes.isNotEmpty ||
                            pendingDisputes.isNotEmpty)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                                pendingDisputes.isNotEmpty
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
                                pendingDisputes.isNotEmpty
                                    ? Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        child: Column(
                                          children: [
                                            ...pendingDisputes.map((dispute) {
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
                                activeDisputes.isNotEmpty
                                    ? Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        child: Text(
                                          'Active',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                      )
                                    : Container(),
                                activeDisputes.isNotEmpty
                                    ? Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        child: Column(
                                          children: [
                                            ...activeDisputes.map((dispute) {
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
                                completeDisputes.isNotEmpty
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
                                completeDisputes.isNotEmpty
                                    ? Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        child: Column(
                                          children: [
                                            ...completeDisputes.map((dispute) {
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
                              'There are no disputes created by you',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          )))
        : Spinner(text: 'Fetching your disputes', height: 0);
  }
}
