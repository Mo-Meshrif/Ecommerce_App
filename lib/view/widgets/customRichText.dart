import 'package:flutter/material.dart';

class CustomRichText extends StatelessWidget {
  final String txt1, txt2, txt3, txt4;
  final Color txt1color, txt2color, txt3color, txt4color;
  final double txt1Size, txt2Size, txt3Size, txt4Size;

  const CustomRichText({
    this.txt1,
    this.txt2,
    this.txt3,
    this.txt4,
    this.txt1color,
    this.txt2color,
    this.txt3color,
    this.txt4color,
    this.txt1Size,
    this.txt2Size,
    this.txt3Size,
    this.txt4Size,
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
            style: TextStyle(
              color: txt1color ?? null,
              fontSize: txt1Size ?? null,
            ),
          ),
          TextSpan(
            text: txt2 ?? null,
            style: TextStyle(
              color: txt2color ?? null,
              fontSize: txt2Size ?? null,
            ),
          ),
          TextSpan(
            text: txt3 ?? null,
            style: TextStyle(
              color: txt3color ?? null,
              fontSize: txt3Size ?? null,
            ),
          ),
          TextSpan(
            text: txt4 ?? null,
            style: TextStyle(
              color: txt4color ?? null,
              fontSize: txt4Size ?? null,
            ),
          ),
        ]),
      ),
    );
  }
}
