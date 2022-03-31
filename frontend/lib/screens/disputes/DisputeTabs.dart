import 'package:flutter/material.dart';
import 'package:frontend/screens/disputes/CommunityDisputes.dart';
import 'package:frontend/screens/disputes/DisputesByYou.dart';
import 'package:frontend/screens/disputes/DisputesOnYou.dart';

class DisputeTabs extends StatefulWidget {
  static const routeName = '/dispute_tabs';
  const DisputeTabs({Key? key}) : super(key: key);

  @override
  State<DisputeTabs> createState() => _DisputeTabsState();
}

class _DisputeTabsState extends State<DisputeTabs> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, int>;
    int? initialIndexParam = routeArgs['initialIndex'];
    int initialIndex = 0;
    if (initialIndexParam == 1) {
      initialIndex = 1;
    } else if (initialIndexParam == 2) {
      initialIndex = 2;
    }

    return DefaultTabController(
        initialIndex: initialIndex,
        length: 3,
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            resizeToAvoidBottomInset: false,
            backgroundColor: Theme.of(context).backgroundColor,
            appBar: AppBar(
              title: const Text('Disputes'),
              bottom: TabBar(
                indicatorColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 3,
                labelStyle: Theme.of(context).textTheme.bodyMedium,
                tabs: const <Widget>[
                  Tab(text: 'By you'),
                  Tab(text: 'On you'),
                  Tab(text: 'Others')
                ],
              ),
            ),
            body: const TabBarView(
              children: [
                DisputesByYou(),
                DisputeOnYou(),
                CommunityDisputes(),
              ],
            ),
          ),
        ));
  }
}
