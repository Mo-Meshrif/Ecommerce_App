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
        if (user.user!.uid.isNotEmpty) {
          _loading.value = false;
          UserModel userModel = UserModel(
              id: user.user!.uid,
              userName: userName,
              email: email,
              role: 'Customer',
              isOnline: true);
          await FireStoreUser().addUserToFireStore(userModel);
          setUser(userModel);
          Get.to(() => ControlView());
          update();
        }
      });
    } catch (e) {
      _loading.value = false;
      update();
      handleAuthErrors(e.toString());
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
          if (user.user!.uid.isNotEmpty) {
            _loading.value = false;
            FireStoreUser().updateOnlineState(user.user!.uid, true);
            UserModel userData =
                _users.firstWhere((element) => element.id == user.user!.uid);
            setUser(userData);
            Get.to(() => ControlView());
            update();
          }
        });
      } catch (e) {
        _loading.value = false;
        update();
        handleAuthErrors(e.toString());
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
    } catch (e) {
      _loading.value = false;
      update();
      handleAuthErrors(e.toString());
    }
  }

  clearAuthData() {
    userName = email = password = null;
    update();
  }

  handleAuthErrors(String error) {
    Get.snackbar(
      'AuthError',
      error,
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
