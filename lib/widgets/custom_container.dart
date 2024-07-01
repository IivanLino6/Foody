import 'package:flutter/material.dart'; 

class MyContainer extends StatelessWidget {

  final double width;
  final double height;
  final Widget child;
  const MyContainer({this.height = 120, this.width =double.infinity, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height:height,
      width: width,
      decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(12.0), // Set radius for rounded corners
              color: Colors.white, // Set background color
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1), // Shadow color
                  offset: Offset(0, 3), // Shadow offset
                  blurRadius: 5.0, // Shadow blur radius
                  spreadRadius: 2.0, // Shadow spread radius
                ),
              ],
            ),
            child: child,
    );
  }
}