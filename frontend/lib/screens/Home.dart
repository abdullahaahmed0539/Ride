// ignore: file_names
import 'package:flutter/material.dart';
import 'package:frontend/services/error.dart';
import 'package:frontend/widgets/components/DisputesOnYouShortcut.dart';
import 'package:frontend/widgets/components/MyDisputesShortcut.dart';
import '../widgets/components/NavigationMenu.dart';
import '../widgets/components/VotingShortcut.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import '../../api calls/Dispute.dart';
import '../../models/User.dart';
import '../../providers/User.dart';

class Home extends StatefulWidget {
  static const routeName = '/home';
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  List<dynamic> disputesOnMe = [];
  List<dynamic> disputesByMe = [];

  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      fetchDisputeOnYouFromServer,
    );
    super.initState();
  }

  Future fetchDisputeOnYouFromServer() async {
    User user = Provider.of<UserProvider>(context, listen: false).user;

    final response =
        await fetchActiveDisputesOnMe(user.id, user.phoneNumber, user.token);
    fetchDisputesResponseHandler(response, 1);
  }

  Future fetchDisputeByYouFromServer() async {
    User user = Provider.of<UserProvider>(context, listen: false).user;

    final response =
        await fetchMyCompletedDisputes(user.id, user.phoneNumber, user.token);
    fetchDisputesResponseHandler(response, 2);
  }

  void fetchDisputesResponseHandler(Response response, int whichFunction) {
    //incase of internal server error
    if (response.statusCode != 404 && response.statusCode != 200) {
      snackBar(scaffoldKey,
          'Internal Server Error. Problem which fetching disputes.');
    }

    //incase of successful fetch
    if (response.statusCode == 200) {
      if (whichFunction == 1) {
        setState(() {
          disputesOnMe = json.decode(response.body)['data']['disputes'];
        });
      } else if (whichFunction == 2) {
        setState(() {
          disputesByMe = json.decode(response.body)['data']['disputes'];
        });
      }
    }
    //incase of no fetch
    if (response.statusCode == 404) {
      if (whichFunction == 1) {
        setState(() {
          disputesOnMe = [];
        });
      } else if (whichFunction == 2) {
        setState(() {
          disputesByMe = [];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: const Text(
            'Ride',
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            fetchDisputeByYouFromServer();
            fetchDisputeOnYouFromServer();
          },
          child: SingleChildScrollView(
            child: Column(children: [
              const NavigationMenu(),
              DisputesOnYouShortCut(
                disputesOnMe: disputesOnMe,
              ),
              VotingShortcut(),
              MyDisputesShortcut(
                myDisputes: disputesByMe,
              )
            ]),
          ),
        ));
  }
}
