// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:frontend/screens/booking/scheduled.dart';
import 'package:frontend/screens/booking/history.dart';

class Activities extends StatefulWidget {
  static const routeName = '/activities';
  const Activities({Key? key}) : super(key: key);

  @override
  State<Activities> createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            resizeToAvoidBottomInset: false,
            backgroundColor: Theme.of(context).backgroundColor,
            appBar: AppBar(
              title: const Text('Your activities'),
              bottom: TabBar(
                indicatorColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 3,
                labelStyle: Theme.of(context).textTheme.bodyMedium,
                tabs: const <Widget>[
                  Tab(text: 'Scheduled'),
                  Tab(text: 'History'),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                Scheduled(scaffoldKey: scaffoldKey),
                History(scaffoldKey:scaffoldKey),
              ],
            ),
          ),
        ));
  }
}
