import 'package:csec/colors_dimensions/dimensions.dart';
import 'package:csec/text_icons/normal_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ScrollableIcons extends StatelessWidget {
  final String name;
  final IconData icons;

  const ScrollableIcons({super.key, required this.name, required this.icons});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.screenHeight * 0.1)),
      width: Dimensions.screenWidth * 0.32,
      height: Dimensions.screenHeight * 0.12,
      child: Card(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(icons), NormalText(text: name)],
          ),
        ),
      ),
    );
  }
}
