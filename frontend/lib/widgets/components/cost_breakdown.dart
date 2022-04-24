import 'package:flutter/material.dart';

class CostBreakdown extends StatelessWidget {
  final String milesCost, waitTimeCost, disputeFees, total;
  final double top, bottom;
  const CostBreakdown(
      {Key? key,
      required this.milesCost,
      required this.disputeFees,
      required this.waitTimeCost,
      required this.total,
      required this.bottom,
      required this.top})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: top, bottom: bottom),
        padding: const EdgeInsets.only(top: 12, bottom: 12, left: 12, right: 30),
        width: double.infinity,
        decoration: ShapeDecoration(
          color: const Color(0xff43444B),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Cost breakdown',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Container(
                margin: const EdgeInsets.only(top: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Cost for distance travelled',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      milesCost,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                )),
                Container(
                margin: const EdgeInsets.only(top: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Cost for driver\'s wait time',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      waitTimeCost,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                )),
                Container(
                margin: const EdgeInsets.only(top: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Dispute fees',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      disputeFees,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                )),
                const Divider(color: Colors.white,),
                Container(
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total (RideCoins)',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      total,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                )),
            
          ],
        ));
  }
}
