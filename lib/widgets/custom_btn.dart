import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final Function onFcn;
  final String txt;
  final Color color;
  const CustomBtn({super.key, required this.onFcn, required this.txt, this.color = Colors.blue});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        onFcn();
      },
      icon: const Icon(Icons.check_sharp, color: Colors.white),
      label: Text(
        txt,
        style: const TextStyle(color: Colors.white),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(color)),
    );
  }
}
