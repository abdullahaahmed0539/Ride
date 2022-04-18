import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/global/global.dart';
import 'package:frontend/services/string_extension.dart';

import '../../widgets/ui/DriverCard.dart';

class SelectNearestActiveDrivers extends StatefulWidget {
  static const routeName = '/select_nearest_active_drivers';
  const SelectNearestActiveDrivers({Key? key}) : super(key: key);

  @override
  State<SelectNearestActiveDrivers> createState() =>
      _SelectNearestActiveDriversState();
}

class _SelectNearestActiveDriversState
    extends State<SelectNearestActiveDrivers> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text('Available nearby drivers'),
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  //delete ride request from db
                  Navigator.of(context).pop();
                },
              ),
            ),
            backgroundColor: Theme.of(context).backgroundColor,
            body: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                
                child: Column(
                  children: [
                    ...driversList.map((driver) => DriverCard(
                      firstName: driver['firstName'],
                       lastName: driver['lastName'],
                        carModel: driver['carModel'],
                         color: driver['color'],
                          registrationNumber: driver['registrationNumber'],
                           rating: driver['ratings'],
                            bottom: 0, top: 12)).toList(),
                  ],
                ))));
  }
}