import '../../../view/widgets/customText.dart';
import '../../../core/viewModel/authViewModel.dart';
import 'package:get/get.dart';
import '../../widgets/customElevatedButton.dart';
import '../../widgets/customRichText.dart';
import '../../widgets/customTextField.dart';
import '../../../const.dart';
import 'package:flutter/material.dart';

class SignInView extends StatelessWidget {
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
                        img: 'assets/auth/password.png',
                        lableTxt: 'PASSWORD',
                        hintTxt: '************************',
                        valid: (val) {
                          if (val=='') {
                            return 'The Feild is empty';
                          }
                          return null;
                        },
                        controller:
                            TextEditingController(text: controller.password),
                        onSave: (val) => controller.password = val,
                        isScure: true,
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
                        txt: 'LOG IN',
                        onPress: () {
                          _key.currentState!.save();
                          if (_key.currentState!.validate()) {
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
        ),
      ),
    );
  }
}
