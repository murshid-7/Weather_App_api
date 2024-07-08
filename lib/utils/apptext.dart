import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  String? text;
  double? size;
  Color? color;
  FontWeight? fw;
  TextAlign? align;
  AppText({
    super.key,
    required this.text,
    this.size,
    this.color,
    this.fw,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toString(),
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: fw,
      ),
    );
  }
}
