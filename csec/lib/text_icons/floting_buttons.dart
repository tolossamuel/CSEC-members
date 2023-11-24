import 'package:csec/colors_dimensions/dimensions.dart';
import 'package:flutter/material.dart';

class FloatingButtons extends StatelessWidget {
  const FloatingButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      left: Dimensions.screenWidth * 0.8,
      child: Ink(
        decoration: const ShapeDecoration(
          color: Colors.blue,
          shape: CircleBorder(),
        ),
        child: IconButton(
          onPressed: () {
            // Your onPressed logic here
            Navigator.pushNamed(context, "/register");
          },
          icon: const Icon(Icons.add),
          // Set the icon color
        ),
      ),
    );
  }
}
