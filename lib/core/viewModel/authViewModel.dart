import 'package:ecommerce/view/homeView/homeView.dart';

import '../../core/service/fireStore_user.dart';
import '../../model/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthViewModel extends GetxController {
  int currentIndex = 0;
  getPageIndex(int selectedIndex) {
    currentIndex = selectedIndex;
    update();
  }

  String userName, email, password;
  FirebaseAuth _auth = FirebaseAuth.instance;
  signUp() async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) {
        Get.to(() => HomeView());
        FireStoreUser().addUserToFireStore(UserModel(
          id: user.user.uid,
          userName: userName,
          email: email,
        ));
      });
    } catch (e) {
      handleAuthErrors(e);
    }
  }

  signIn() async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((_) => Get.to(() => HomeView()));
    } catch (e) {
      handleAuthErrors(e);
    }
  }

  forgetPassword() async {
    try {
      await _auth.sendPasswordResetEmail(email: email).then((_) => Get.snackbar(
            'Congratulations',
            'Check you email !',
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 5),
          ));
    } catch (e) {
      handleAuthErrors(e);
    }
  }

  handleAuthErrors(error) {
    Get.snackbar(
      'AuthError',
      error.message.toString(),
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 5),
    );
  }
}
