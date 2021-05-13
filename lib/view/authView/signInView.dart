import '../../view/widgets/customRaisedButton.dart';
import '../../view/widgets/customRichText.dart';
import '../../view/widgets/customTextField.dart';
import '../../const.dart';
import 'package:flutter/material.dart';

class SignInView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CustomTextField(
          img: 'assets/icons/Profile.png',
          lableTxt: 'EMAIL',
          hintTxt: 'janedoe123@email.com',
        ),
        SizedBox(
          height: 20,
        ),
        CustomTextField(
          img: 'assets/icons/password.png',
          lableTxt: 'PASSWORD',
          hintTxt: '************************',
        ),
        SizedBox(
          height: 20,
        ),
        CustomRaisedButton(
          signState: 'LOG IN',
        ),
        SizedBox(
          height: 20,
        ),
        CustomRichText(
          txt1: 'Don’t have an account? Swipe Left to ',
          txt1color: Colors.black,
          txt2: 'create a new account.',
          txt2color: priColor,
        ),
      ],
    );
  }
}
