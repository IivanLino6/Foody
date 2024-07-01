import 'package:flutter/material.dart';

class PostCategoryItem extends StatelessWidget {
  String txt;
   PostCategoryItem({required this.txt});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        txt,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
