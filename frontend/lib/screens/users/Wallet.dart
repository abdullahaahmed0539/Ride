// ignore_for_file: file_names
import 'package:flutter/material.dart';

class Wallet extends StatefulWidget {
  static const routeName = '/wallet';
  const Wallet({ Key? key }) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text('Wallet'),
            ),
            backgroundColor: Theme.of(context).backgroundColor,
            body: const SingleChildScrollView(child: null)));
  }
}