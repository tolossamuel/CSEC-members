import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NormalText extends StatelessWidget {
  Color? colors;
  final String text;
  double? fontSize;
  TextOverflow? textOverflows;
  FontWeight? fontWeights;
  NormalText({
    super.key,
    this.colors,
    required this.text,
    this.fontWeights = FontWeight.normal,
    this.fontSize = 20,
    this.textOverflows = TextOverflow.ellipsis,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: colors == null ? null : colors,
        fontSize: fontSize,
        fontFamily: "RobotoCondensed",
        fontWeight: fontWeights,
      ),
      overflow: textOverflows,
      maxLines: 1,
    );
  }
}

// ignore: must_be_immutable
class SmallText extends StatelessWidget {
  Color? colors;
  final String text;
  double? fontSize;
  SmallText({
    super.key,
    this.colors = const Color(0xFFa9a29f),
    required this.text,
    this.fontSize = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        textBaseline: null,
        color: colors,
        fontSize: fontSize,
        fontFamily: "RobotoCondensed",
      ),
    );
  }
}
