// ignore_for_file: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/api%20calls/dispute.dart';
import 'package:frontend/screens/disputes/dispute_tabs.dart';
import 'package:frontend/services/user_alert.dart';
import 'package:frontend/widgets/ui/grey_block.dart';
import 'package:frontend/widgets/ui/long_button.dart';
import 'package:frontend/widgets/ui/text_area.dart';
import 'package:frontend/widgets/ui/spinner.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pie_chart/pie_chart.dart';
import '../../models/user.dart';
import '../../providers/user.dart';

class DisputeDetail extends StatefulWidget {
  static const routeName = 'dispute_detail';
  const DisputeDetail({Key? key}) : super(key: key);

  @override
  State<DisputeDetail> createState() => _DisputeDetailState();
}

class _DisputeDetailState extends State<DisputeDetail> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  bool isLoading = true;
  late dynamic disputeDetail;
  late dynamic voteMap;
  late User user;
  String yourClaim = '';
  dynamic disputeId = '';

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      user = Provider.of<UserProvider>(context, listen: false).user;
      final routeArg =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      setState(() {
        disputeId = routeArg['disputeId'];
      });
      final response =
          await fetchDisputeDetail(disputeId, user.phoneNumber, user.token);
      fetchDisputeDetailResponseHandler(response);

      isLoading = false;
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
      disputeDetail['status'] == 'completed'
          ? voteMap = <String, double>{
              "Initiator": disputeDetail['initiatorsVote'].toDouble(),
              "Defendent": disputeDetail['defendentsVote'].toDouble(),
            }
          : null;
    }

    if (response.statusCode == 404) {
      setState(() {
        disputeDetail = {};
      });
    }
  }

  void addClaimHandler(Response response) {
    if (response.statusCode != 201 &&
        response.statusCode != 204 &&
        response.statusCode != 401 &&
        response.statusCode != 404 &&
        response.statusCode != 406) {
      snackBar(scaffoldKey, 'Internal Server Error');
    }

    if (response.statusCode == 201 || response.statusCode == 204) {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.of(context)
          .pushNamed(DisputeTabs.routeName, arguments: {'initialIndex': 1});
          
    }

    if (response.statusCode == 404) {
      snackBar(scaffoldKey, 'Dispute not found. Please try later');
    }

    if (response.statusCode == 401) {
      snackBar(scaffoldKey, 'Not your dispute to add claim to');
    }

    if (response.statusCode == 406) {
      snackBar(scaffoldKey, 'Parameter missing');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            key: scaffoldKey,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text('Dispute Details'),
            ),
            backgroundColor: Theme.of(context).backgroundColor,
            body: !isLoading
                ? SingleChildScrollView(
                    child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              disputeDetail['status'] == 'completed'
                                  ? Container(
                                      margin: const EdgeInsets.only(top: 15),
                                      child: Text(
                                        'Here are the votes for your dispute',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                    )
                                  : Container(),
                              disputeDetail['status'] == 'completed'
                                  ? Container(
                                      margin: const EdgeInsets.only(
                                          top: 20, bottom: 40),
                                      child: PieChart(
                                          chartValuesOptions:
                                              const ChartValuesOptions(
                                                  showChartValuesInPercentage:
                                                      true),
                                          dataMap: voteMap))
                                  : Container(),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: Text(
                                    'Here are some details regarding the dispute',
                                    style:
                                        Theme.of(context).textTheme.titleLarge),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 15),
                                child: Text(
                                  'Subject',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ),
                              GreyBlock(
                                text: disputeDetail['subject'],
                                top: 5,
                                bottom: 0,
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 15),
                                child: Text(
                                  'Date published',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ),
                              GreyBlock(
                                text: formatter.format(DateTime.parse(disputeDetail['publishedOn'])),
                                top: 5,
                                bottom: 0,
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                child: Text(
                                  'Initiator\'s claim',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ),
                              GreyBlock(
                                text: disputeDetail['initiatorsClaim'],
                                top: 5,
                                bottom: 0,
                              ),
                              disputeDetail['defendentsClaim'] != null
                                  ? Container(
                                      margin: const EdgeInsets.only(top: 20),
                                      child: Text(
                                        'Defender\'s claim',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                    )
                                  : Container(),
                              disputeDetail['defendentsClaim'] != null
                                  ? GreyBlock(
                                      text: disputeDetail['defendentsClaim'],
                                      top: 5,
                                      bottom: 0,
                                    )
                                  : Container(),
                              disputeDetail['defenderId'] == user.id &&
                                      disputeDetail['status'] == 'pending'
                                  ? Container(
                                      margin: const EdgeInsets.only(top: 20),
                                      child: Text(
                                        'Defender\'s Claim',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                    )
                                  : Container(),
                              disputeDetail['defenderId'] == user.id &&
                                      disputeDetail['status'] == 'pending'
                                  ? Container(
                                      margin: const EdgeInsets.only(top: 5),
                                      child: TextArea(
                                          label: '',
                                          radius: 8,
                                          placeholder:
                                              'Please enter your claim here.',
                                          onChangeHandler: (val) => setState(
                                                () => yourClaim = val,
                                              )),
                                    )
                                  : Container(),
                              disputeDetail['defenderId'] == user.id &&
                                      disputeDetail['status'] == 'pending'
                                  ? yourClaim != ''
                                      ? Container(
                                          margin: const EdgeInsets.only(
                                              top: 20, bottom: 20),
                                          child: LongButton(
                                              handler: () async {
                                                setState(() {
                                                  isLoading = true;
                                                });
                                                Response response =
                                                    await addClaim(
                                                        disputeId,
                                                        yourClaim,
                                                        user.id,
                                                        user.phoneNumber,
                                                        user.token);
                                                setState(() {
                                                  isLoading = false;
                                                });
                                                addClaimHandler(response);
                                              },
                                              buttonText: 'Add claim',
                                              isActive: true),
                                        )
                                      : Container(
                                          margin: const EdgeInsets.only(
                                              top: 20, bottom: 20),
                                          child: LongButton(
                                              handler: () {},
                                              buttonText: 'Add claim',
                                              isActive: false),
                                        )
                                  : Container()
                            ])))
                : Spinner(text: 'Loading', height: 0)));
  }
}
