import 'package:flutter/material.dart';

import 'package:frontend/widgets/ui/LongButton.dart';

class RiderDetails extends StatefulWidget {
  final String? duration, riderName, dropoff, pickup;
  const RiderDetails({
    this.dropoff,
    this.duration,
    this.pickup,
    this.riderName,
    Key? key,
  }) : super(key: key);

  @override
  State<RiderDetails> createState() => _RiderDetailsState();
}

class _RiderDetailsState extends State<RiderDetails> {
  String buttonText = 'Arrived';

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
                  children: [
                    const Icon(Icons.person, color: Colors.white,),
                    const SizedBox(
                        width: 4,
                      ),
                    Text(
                      widget.riderName!,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                const Divider(color: Colors.white, thickness: 1),
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
                          widget.pickup!,
                          style: Theme.of(context).textTheme.bodyMedium,
                          overflow: TextOverflow.clip,
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
                          widget.dropoff!,
                          style: Theme.of(context).textTheme.bodyMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                LongButton(
                    handler: () {}, buttonText: buttonText, isActive: true)
              ],
            )),
      ],
    );
  }
}
