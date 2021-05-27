import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String lableTxt;
  final String hintTxt;
  final String img;
  final void Function(String) onSave;
  final String Function(String) valid;

  CustomTextField(
      {this.lableTxt, this.hintTxt, this.img, this.onSave, this.valid});
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
                onSaved: onSave,
                validator: valid,
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
