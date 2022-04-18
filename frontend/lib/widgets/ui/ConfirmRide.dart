import 'package:flutter/material.dart';
import 'package:frontend/widgets/ui/LongButton.dart';
import 'package:frontend/widgets/ui/TextualButton.dart';
import 'package:provider/provider.dart';

import '../../providers/Location.dart';

class ConfirmRide extends StatelessWidget {
  final Function searchDrivers;
  final Function editTripDetails;
  const ConfirmRide({
    required this.searchDrivers,
    required this.editTripDetails,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.all(12),
            width: double.infinity,
            decoration: ShapeDecoration(
              color: const Color.fromARGB(255, 36, 37, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Estimated fair',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      'R20',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 2),
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Buy RideCoins',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 15,
                              fontFamily: "SF-Pro-Display"),
                        ),
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                    )
                  ],
                ),
                const Divider(color: Colors.white, thickness: 1),
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.blue,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Flexible(
                            child: Text(
                              Provider.of<LocationProvider>(context,
                                      listen: false)
                                  .userPickupLocation!
                                  .locationName!,
                              style: Theme.of(context).textTheme.titleMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.red,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Flexible(
                            child: Text(
                              Provider.of<LocationProvider>(context,
                                      listen: false)
                                  .userDropLocation!
                                  .locationName!,
                              style: Theme.of(context).textTheme.titleMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total distance',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Text(
                            '10Km',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 2, bottom: 7),
                      child: TextButton(
                        onPressed: () => editTripDetails(),
                        child: Text(
                          'Edit location',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 15,
                              fontFamily: "SF-Pro-Display"),
                        ),
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                    )
                  ],
                ),
                LongButton(
                    handler: () => searchDrivers(),
                    buttonText: 'Confirm',
                    isActive: true)
              ],
            )),
      ],
    );
  }
}
