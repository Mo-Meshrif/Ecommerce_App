import '../../helper/localStorageData.dart';
import '../../view/controlView.dart';
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

  bool isLoading = false;
  Rxn<User> _user = Rxn<User>();
  String get user => _user.value?.email;
  @override
  void onInit() {
    _user.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  String userName, email, password;
  FirebaseAuth _auth = FirebaseAuth.instance;
  final LocalStorageData _localStorageData = Get.find();

  setUser(UserModel user) {
    _localStorageData.setUserData(user);
  }

  signUp() async {
    try {
      isLoading = true;
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) async {
        isLoading = false;
        Get.to(() => ControlView());
        UserModel userModel = UserModel(
          id: user.user.uid,
          userName: userName,
          email: email,
        );
        await FireStoreUser().addUserToFireStore(userModel);
        setUser(userModel);
      });
    } catch (e) {
      handleAuthErrors(e);
    }
  }

  signIn() async {
    try {
      isLoading = true;
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((user) async {
        isLoading = false;
        Get.to(() => ControlView());
        await FireStoreUser()
            .getUserFromFireStore(user.user.uid)
            .then((userData) => setUser(UserModel.fromJson(userData.data())));
      });
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
