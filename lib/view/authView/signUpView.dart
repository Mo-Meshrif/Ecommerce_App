import '../../core/viewModel/authViewModel.dart';
import 'package:get/get.dart';

import '../../const.dart';
import '../../view/widgets/customRichText.dart';
import '../../view/widgets/customRaisedButton.dart';
import '../../view/widgets/customTextField.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _key = GlobalKey<FormState>();
    return GetBuilder<AuthViewModel>(
      builder: (controller) => Form(
        key: _key,
        child: Column(
          children: <Widget>[
            CustomTextField(
              img: 'assets/icons/Profile.png',
              lableTxt: 'EMAIL',
              hintTxt: 'janedoe123@email.com',
              onSave: (val) => controller.email = val,
              valid: (val) {
                if (val.isEmpty) {
                  return 'The Feild is empty';
                }
                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              img: 'assets/icons/mail.png',
              lableTxt: 'USERNAME',
              hintTxt: 'janedoe12345',
              onSave: (val) => controller.userName = val,
              valid: (val) {
                if (val.isEmpty) {
                  return 'The Feild is empty';
                }
                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              img: 'assets/icons/password.png',
              lableTxt: 'PASSWORD',
              hintTxt: '************************',
              onSave: (val) => controller.password = val,
              valid: (val) {
                if (val.isEmpty) {
                  return 'The Feild is empty';
                }
                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            CustomRaisedButton(
              signState: 'SIGN UP',
              onPress: () {
                _key.currentState.save();
                if (_key.currentState.validate()) {
                  controller.signUp();
                }
              },
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
        ),
      ),
    );
  }
}
