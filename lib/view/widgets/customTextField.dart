import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String lableTxt;
  final String hintTxt;
  final String img;

  CustomTextField({this.lableTxt, this.hintTxt, this.img});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: <Widget>[
          Image.asset(img),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: lableTxt,
                  hintText: hintTxt,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
