import '../../../view/widgets/customText.dart';
import '../../../const.dart';
import '../../../core/viewModel/authViewModel.dart';
import 'package:get/get.dart';
import '../../widgets/customElevatedButton.dart';
import '../../widgets/customRichText.dart';
import '../../widgets/customTextField.dart';
import 'package:flutter/material.dart';

class ForgetPassView extends StatelessWidget {
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
                CustomRichText(
                  txt1:
                      'Enter the email address you used to create your account and we will email you a link to reset your password',
                  txt1color: Colors.black,
                ),
                SizedBox(
                  height: 20,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: CustomTextField(
                    img: 'assets/auth/mail.png',
                    lableTxt: 'EMAIL',
                    hintTxt: 'janedoe123@email.com',
                    controller: TextEditingController(text: controller.email),
                    valid: (val) {
                      if (val=='') {
                        return 'The Feild is empty';
                      }
                      return null;
                    },
                    onSave: (val) => controller.email = val,
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
                        txt: 'SEND EMAIL',
                        onPress: () {
                          _key.currentState!.save();
                          if (_key.currentState!.validate()) {
                            controller.forgetPassword();
                          }
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
