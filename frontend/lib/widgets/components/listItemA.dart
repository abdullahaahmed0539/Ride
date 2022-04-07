// ignore_for_file: file_names
import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function handler;
  const ListItem(
      {Key? key, required this.text, required this.icon, required this.handler})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => handler(),
            child: Icon(
              icon,
              color: Colors.white,
              size: 40,
            ),
          ),
          TextButton(
              onPressed: () => handler(),
              child: Text(
                text,
                style: Theme.of(context).textTheme.titleMedium,
              ))
        ],
      ),
    );
  }
}
