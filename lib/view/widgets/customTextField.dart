import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? lableTxt;
  final String? hintTxt;
  final TextEditingController? controller;
  final String? img;
  final void Function(String?)? onSave;
  final String? Function(String?)? valid;
  final bool isScure;

  CustomTextField({
    this.lableTxt,
    this.hintTxt,
    this.img,
    this.onSave,
    this.valid,
    this.isScure = false,
    this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: <Widget>[
          Image.asset(img!),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: controller,
                obscureText: isScure,
                onSaved: onSave,
                validator: valid,
                decoration: InputDecoration(
                    labelText: lableTxt,
                    hintText: hintTxt,
                    border: InputBorder.none),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
