import 'package:flutter/material.dart';
import 'package:frontend/providers/App.dart';
import 'package:frontend/widgets/ui/LongButton.dart';
import 'package:provider/provider.dart';

import '../../screens/Rating.dart';

class FairCollectionDialog extends StatefulWidget {
  dynamic disputeCost;
  dynamic waitTimeCost;
  dynamic milesCost;
  dynamic total;
  final Function? customDispose;

  FairCollectionDialog(
      {this.disputeCost,
      this.milesCost,
      this.total,
      this.waitTimeCost,
      this.customDispose,
      Key? key})
      : super(key: key);

  @override
  State<FairCollectionDialog> createState() => _FairCollectionDialogState();
}

class _FairCollectionDialogState extends State<FairCollectionDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      backgroundColor: Colors.transparent,
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 52, 53, 56),
            borderRadius: BorderRadius.circular(6)),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(
            'Fare Amount Details',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Divider(
            color: Colors.white,
            thickness: 2,
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Cost for distance travelled:'),
              Text(widget.milesCost.toString())
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Waiting cost :'),
              Text(widget.waitTimeCost.toString())
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Dispute fees:'),
              Text(widget.disputeCost.toString())
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(color: Colors.white),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total(RideCoins):',
                  style: Theme.of(context).textTheme.titleMedium),
              Text(widget.total.toString(),
                  style: Theme.of(context).textTheme.titleMedium)
            ],
          ),
          const Divider(color: Colors.white),
          const SizedBox(
            height: 5,
          ),
          LongButton(
              handler: () {
                if (Provider.of<AppProvider>(context, listen: false)
                        .app
                        .getAppMode() ==
                    'rider') {
                  widget.customDispose!();
                }
                Navigator.of(context).pushNamedAndRemoveUntil(
                    Rating.routeName, (route) => false);
              },
              buttonText: 'Finish',
              isActive: true),
        ]),
      ),
    );
  }
}
