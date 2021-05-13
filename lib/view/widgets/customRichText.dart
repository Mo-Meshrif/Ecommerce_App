import 'package:flutter/material.dart';

class CustomRichText extends StatelessWidget {
  final String txt1, txt2, txt3, txt4;
  final Color txt1color, txt2color, txt3color, txt4color;

  const CustomRichText({
    this.txt1,
    this.txt2,
    this.txt3,
    this.txt4,
    this.txt1color,
    this.txt2color,
    this.txt3color,
    this.txt4color,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 60),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(children: [
          TextSpan(
            text: txt1 ?? null,
            style: TextStyle(color: txt1color ?? null),
          ),
          TextSpan(
            text: txt2 ?? null,
            style: TextStyle(color: txt2color ?? null),
          ),
          TextSpan(
            text: txt3 ?? null,
            style: TextStyle(color: txt3color ?? null),
          ),
          TextSpan(
            text: txt4 ?? null,
            style: TextStyle(color: txt4color ?? null),
          ),
        ]),
      ),
    );
  }
}
