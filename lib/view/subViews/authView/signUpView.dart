import '../../../view/widgets/customText.dart';
import '../../../core/viewModel/authViewModel.dart';
import 'package:get/get.dart';
import '../../../const.dart';
import '../../widgets/customRichText.dart';
import '../../widgets/customElevatedButton.dart';
import '../../widgets/customTextField.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _key = GlobalKey<FormState>();
    return GetBuilder<AuthViewModel>(
      builder: (controller) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Form(
          key: _key,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      CustomTextField(
                        img: 'assets/auth/mail.png',
                        lableTxt: 'EMAIL',
                        hintTxt: 'janedoe123@email.com',
                        controller: TextEditingController(text: controller.email),
                        onSave: (val) => controller.email = val,
                        valid: (val) {
                          if (val=='') {
                            return 'The Feild is empty';
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        img: 'assets/auth/Profile.png',
                        lableTxt: 'USERNAME',
                        hintTxt: 'janedoe12345',
                        controller:
                            TextEditingController(text: controller.userName),
                        onSave: (val) => controller.userName = val,
                        valid: (val) {
                          if (val=='') {
                            return 'The Feild is empty';
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        img: 'assets/auth/password.png',
                        lableTxt: 'PASSWORD',
                        hintTxt: '************************',
                        controller:
                            TextEditingController(text: controller.password),
                        onSave: (val) => controller.password = val,
                        isScure: true,
                        valid: (val) {
                          if (val=='') {
                            return 'The Feild is empty';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                controller.loading.value
                    ? CustomText(
                        txt: 'Loading',
                        fSize: 18,
                        txtColor: priColor,
                      )
                    : CustomElevatedButton(
                        imgUrl: 'assets/auth/right_arrow.png',
                        txt: 'SIGN UP',
                        onPress: () {
                          _key.currentState!.save();
                          if (_key.currentState!.validate()) {
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
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
