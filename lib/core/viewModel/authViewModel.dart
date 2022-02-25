import 'searchViewModel.dart';
import 'cartViewModel.dart';
import 'moreViewModel.dart';
import 'chatViewModel.dart';
import '../../helper/localStorageData.dart';
import '../../view/controlView.dart';
import '../../core/service/fireStore_user.dart';
import '../../model/userModel.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthViewModel extends GetxController {
  int currentIndex = 0;
  ValueNotifier<bool> _loading = ValueNotifier(false);
  ValueNotifier<bool> get loading => _loading;
  List<UserModel> _users = [];
  List<UserModel> get users => _users;
  Rxn<User> _user = Rxn<User>();
  String? get user => _user.value?.email;
  @override
  void onInit() {
    _user.bindStream(_auth.authStateChanges());
    getUsers();
    super.onInit();
  }

  String? userName, email, password;
  FirebaseAuth _auth = FirebaseAuth.instance;
  final LocalStorageData _localStorageData = Get.find();

  setUser(UserModel user) {
    _localStorageData.setUserData(user);
  }

  Future<void> getUsers() async {
    FireStoreUser().getUsersFromFireStore().then((usersData) {
      usersData.forEach((element) {
        Map data = element.data() as Map<dynamic, dynamic>;
        var index = _users.indexWhere((element) => element.id == data['id']);
        if (index >= 0) {
          _users.removeAt(index);
          _users.add(UserModel.fromJson(data as Map<String, dynamic>));
        } else {
          _users.add(UserModel.fromJson(data as Map<String, dynamic>));
        }
      });
      update();
    });
  }

  bool isCustomer(String? loginEmail) {
    var _index = _users.indexWhere((element) => element.email == loginEmail);
    return _index == -1
        ? true
        : _users.firstWhere((element) => element.email == loginEmail).role ==
            'Customer';
  }

  signUp() async {
    try {
      _loading.value = true;
      update();
      await _auth
          .createUserWithEmailAndPassword(email: email!, password: password!)
          .then((user) async {
        if (user.user?.uid != '') {
          _loading.value = false;
          UserModel userModel = UserModel(
            id: user.user!.uid,
            userName: userName,
            email: email,
            role: 'Customer',
            isOnline: true,
          );
          await FireStoreUser().addUserToFireStore(userModel);
          setUser(userModel);
          Get.to(() => ControlView());
          update();
        }
      });
    } on FirebaseAuthException catch (e) {
      _loading.value = false;
      update();
      handleAuthErrors(e.code);
    }
  }

  signIn() async {
    _loading.value = true;
    update();
    if (isCustomer(email)) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email!, password: password!)
            .then((user) async {
          if (user.user?.uid != '') {
            _loading.value = false;
            FireStoreUser().updateOnlineState(user.user!.uid, true);
            UserModel userData =
                _users.firstWhere((element) => element.id == user.user!.uid);
            setUser(userData);
            Get.to(() => ControlView());
            update();
          }
        });
      } on FirebaseAuthException catch (e) {
        _loading.value = false;
        update();
        handleAuthErrors(e.code);
      }
    } else {
      _loading.value = false;
      update();
      handleAuthErrors('Only customers are allowed to enter !');
    }
  }

  forgetPassword() async {
    try {
      _loading.value = true;
      update();
      await _auth.sendPasswordResetEmail(email: email!).then((_) {
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
    } on FirebaseAuthException catch (e) {
      _loading.value = false;
      update();
      handleAuthErrors(e.code);
    }
  }

  clearAuthData() {
    userName = email = password = null;
    update();
  }

  handleAuthErrors(String error) {
    late String errorMessage;
    switch (error) {
      case "email-already-in-use":
        errorMessage = "Email already used. Go to login page.";
        break;
      case "wrong-password":
        errorMessage = "Wrong email/password combination.";
        break;
      case "user-not-found":
        errorMessage = "No user found with this email.";
        break;
      case "user-disabled":
        errorMessage = "User disabled.";
        break;
      case "operation-not-allowed":
        errorMessage = "Too many requests to log into this account.";
        break;
      case "invalid-email":
        errorMessage = "Email address is invalid.";
        break;
      case "Only customers are allowed to enter !":
        errorMessage = "Only customers are allowed to enter !";
        break;
      default:
        errorMessage = "Login failed. Please try again.";
        break;
    }
    Get.snackbar(
      'AuthError',
      errorMessage,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 5),
    );
  }

  logout() {
    _localStorageData.deleteUserData();
    _auth.signOut();
    currentIndex = 1;
    clearAuthData();
    Get.delete<SearchViewModel>();
    Get.delete<CartViewModel>();
    Get.delete<MoreViewModel>();
    Get.delete<ChatViewModel>();
    update();
  }
}
