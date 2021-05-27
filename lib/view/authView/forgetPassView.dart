import '../../core/viewModel/authViewModel.dart';
import 'package:get/get.dart';

import '../../view/widgets/customRaisedButton.dart';
import '../../view/widgets/customRichText.dart';
import '../../view/widgets/customTextField.dart';
import 'package:flutter/material.dart';

class ForgetPassView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _key = GlobalKey<FormState>();
    return GetBuilder<AuthViewModel>(
      builder: (controller) => Form(
        key: _key,
        child: Column(
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
              valid: (val) {
                if (val.isEmpty) {
                  return 'The Feild is empty';
                }
                return null;
              },
              onSave: (val) => controller.email = val,
            ),
            SizedBox(
              height: 20,
            ),
            CustomRaisedButton(
              signState: 'SEND EMAIL',
              onPress: () {
                _key.currentState.save();
                if (_key.currentState.validate()) {
                  controller.forgetPassword();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
