import '../../const.dart';
import '../../view/widgets/customRichText.dart';
import '../../view/widgets/customRaisedButton.dart';
import '../../view/widgets/customTextField.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatelessWidget {
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
          img: 'assets/icons/mail.png',
          lableTxt: 'USERNAME',
          hintTxt: 'janedoe12345',
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
          signState: 'SIGN UP',
        ),
        SizedBox(
          height: 20,
        ),
        CustomRichText(
          txt1: 'By creating an account, you agree to our ',
          txt1color: Colors.black,
          txt2: 'Terms of Service ',
          txt2color: priColor,
          txt3: 'and ',
          txt3color: Colors.black,
          txt4: 'Privacy Policy',
          txt4color: priColor,
        ),
      ],
    );
  }
}
