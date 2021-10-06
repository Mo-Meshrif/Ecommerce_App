import 'cartViewModel.dart';
import 'moreViewModel.dart';
import 'package:flutter/material.dart';
import '../../helper/localStorageData.dart';
import '../../view/controlView.dart';
import '../../core/service/fireStore_user.dart';
import '../../model/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthViewModel extends GetxController {
  int currentIndex = 0;
  ValueNotifier<bool> _loading = ValueNotifier(false);
  ValueNotifier<bool> get loading => _loading;
  List<UserModel> _users = [];
  List<UserModel> get users => _users;
  Rxn<User> _user = Rxn<User>();
  String get user => _user.value?.email;
  @override
  void onInit() {
    _user.bindStream(_auth.authStateChanges());
    getUsers();
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
      _loading.value = true;
      update();
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) async {
        _loading.value = false;
        if (user != null) {
          UserModel userModel = UserModel(
              id: user.user.uid,
              userName: userName,
              email: email,
              isOnline: true);
          await FireStoreUser().addUserToFireStore(userModel);
          setUser(userModel);
          Get.to(() => ControlView());
        }
        update();
      });
    } catch (e) {
      _loading.value = false;
      update();
      handleAuthErrors(e);
    }
  }

  Future<void> getUsers() async {
    FireStoreUser().getUsersFromFireStore().then((usersData) {
      usersData.forEach((element) {
        Map data = element.data();
        var index = _users.indexWhere((element) => element.id == data['id']);
        if (index >= 0) {
          _users.removeAt(index);
          _users.add(UserModel.fromJson(data));
        } else {
          _users.add(UserModel.fromJson(data));
        }
      });
      update();
    });
  }

  signIn() async {
    _loading.value = true;
    update();
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .onError((error, stackTrace) {
      _loading.value = false;
      update();
      return handleAuthErrors(error);
    }).then((user) async {
      _loading.value = false;
      if (user != null) {
        FireStoreUser().updateOnlineState(user.user.uid, true);
        UserModel userData =
            _users.firstWhere((element) => element.id == user.user.uid);
        setUser(userData);
        Get.to(() => ControlView());
      }
      update();
    });
  }

  forgetPassword() async {
    try {
      _loading.value = true;
      update();
      await _auth.sendPasswordResetEmail(email: email).then((_) {
        _loading.value = false;
        update();
        Get.snackbar(
          'Congratulations',
          'Check you email !',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 5),
        );
        clearAuthData();
      });
    } catch (e) {
      _loading.value = false;
      update();
      handleAuthErrors(e);
    }
  }

  clearAuthData() {
    userName = email = password = null;
    update();
  }

  handleAuthErrors(error) {
    Get.snackbar(
      'AuthError',
      error.message.toString(),
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 5),
    );
  }

  logout() {
    _localStorageData.deleteUserData();
    _auth.signOut();
    currentIndex = 1;
    clearAuthData();
    Get.delete<CartViewModel>();
    Get.delete<MoreViewModel>();
    update();
  }
}
