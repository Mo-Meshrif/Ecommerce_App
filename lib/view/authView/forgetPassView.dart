import '../../view/widgets/customRaisedButton.dart';
import '../../view/widgets/customRichText.dart';
import '../../view/widgets/customTextField.dart';
import 'package:flutter/material.dart';

class ForgetPassView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CustomRichText(
          txt1:
              'Enter the email address you used to create your account and we will email you a link to reset your password',
          txt1color: Colors.black,
        ),
        SizedBox(
          height: 20,
        ),
        CustomTextField(
          img: 'assets/icons/Profile.png',
          lableTxt: 'EMAIL',
          hintTxt: 'janedoe123@email.com',
        ),
        SizedBox(
          height: 20,
        ),
        CustomRaisedButton(
          signState: 'SEND EMAIL',
        ),
      ],
    );
  }
}
