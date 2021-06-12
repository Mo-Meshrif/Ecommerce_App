import '../../../core/viewModel/authViewModel.dart';
import 'package:get/get.dart';

import '../../widgets/customRaisedButton.dart';
import '../../widgets/customRichText.dart';
import '../../widgets/customTextField.dart';
import '../../../const.dart';
import 'package:flutter/material.dart';

class SignInView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _key = GlobalKey<FormState>();
    return GetBuilder<AuthViewModel>(
      builder: (controller) => Form(
        key: _key,
        child: Column(
          children: <Widget>[
            CustomTextField(
              img: 'assets/auth/Profile.png',
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
              img: 'assets/auth/password.png',
              lableTxt: 'PASSWORD',
              hintTxt: '************************',
              valid: (val) {
                if (val.isEmpty) {
                  return 'The Feild is empty';
                }
                return null;
              },
              onSave: (val) => controller.password = val,
              isScure: true,
            ),
            SizedBox(
              height: 20,
            ),
            CustomRaisedButton(
              txt: 'LOG IN',
              onPress: () {
                _key.currentState.save();
                if (_key.currentState.validate()) {
                  controller.signIn();
                }
              },
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
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}