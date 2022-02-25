import 'dart:io';
import '/helper/networkManager.dart';
import 'notificationViewModel.dart';
import '../../core/viewModel/cartViewModel.dart';
import '../../core/service/fireStore_rateApp.dart';
import '../../core/service/fireStore_user.dart';
import '../../helper/localStorageData.dart';
import '../../model/userModel.dart';
import '../../helper/paymentHelper/paymentDatabaseHelper.dart';
import '../../model/paymentMethodModel.dart';
import '../../helper/shippingDatabaseHelper.dart';
import '../../model/shippingAddressModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MoreViewModel extends GetxController {
  @override
  void onInit() {
    getAllShipping();
    getAllPayments();
    getUserData();
    super.onInit();
  }

  //userData
  final LocalStorageData _localStorageData = Get.find();
  UserModel? savedUser;
  late File image;
  final picker = ImagePicker();
  Future<void> getUserImage({required UserModel user}) async {
    if (Get.find<NetworkManager>().isConnected) {
      final pickedImage = await picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        image = File(pickedImage.path);
        FireStoreUser().uploadProfilePic(image, user).then((_) =>
            FireStoreUser().getUserFromFireStore(user.id).then((userData) {
              Map x = userData.data() as Map<dynamic, dynamic>;
              _localStorageData.setUserData(UserModel(
                  id: user.id,
                  userName: user.userName,
                  email: user.email,
                  pic: x['pic']));
            }));
      }
      update();
    } else {
      Get.snackbar(
        'Network Error',
        'There is no internet connection !',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
      );
    }
  }

  Future<void> getUserData() async {
    await _localStorageData.getUser.then((user) async {
      if (user != null) {
        savedUser = user;
        update();
        Get.find<CartViewModel>().getProducts(user);
        Get.find<NotificationViewModel>().addDeviceToken(user.id);
        getAppRateValue();
      }
    });
  }

  //ShippingAddress
  final ShippingDatabaseHelper dbShippingClient = ShippingDatabaseHelper.db;
  List<ShippingAddressModel>? _shippingList;
  List<ShippingAddressModel>? get shippingList => _shippingList;
  GlobalKey<FormState> _shippingKey = GlobalKey<FormState>();
  GlobalKey<FormState> get shippingKey => _shippingKey;

  String? fullName,
      mobileNumber,
      state = 'Select State',
      city = 'Select City',
      street;
  getState(val) {
    state = val;
    update();
  }

  getCity(val) {
    city = val;
    update();
  }

  addAddress(ShippingAddressModel shipping) {
    dbShippingClient.insert(shipping).then((_) {
      getAllShipping();
      Get.back();
    });
  }

  getAllShipping() async {
    _shippingList = await dbShippingClient.getAllShipping();
    update();
  }

  deleteOneShipping(id) {
    dbShippingClient.deleteOneShipping(id).then((_) => getAllShipping());
  }

  updateSelectedShippingParameter(id) {
    dbShippingClient.updateSelected(id).then((_) => getAllShipping());
  }

  clearShippingData() {
    fullName = mobileNumber = street = null;
    state = 'Select State';
    city = 'Select City';
    update();
  }

  //paymentMethod
  String cardImage = 'assets/more/visa.png';
  final PaymentDatabaseHelper dbPaymentClient = PaymentDatabaseHelper.db;
  GlobalKey<FormState> _paymentKey = GlobalKey<FormState>();
  GlobalKey<FormState> get paymentKey => _paymentKey;
  List<PaymentMehodModel>? _paymentsList;
  List<PaymentMehodModel>? get paymentsList => _paymentsList;
  getSelectedCardImg(cardImg) {
    cardImage = cardImg;
    update();
  }

  String cardNumber = '', expireDate = '', cvv = '', cardHolderName = '';
  getCardNumber(val) {
    cardNumber = val;
    update();
  }

  getExpireDate(val) {
    expireDate = val;
    update();
  }

  getCvv(val) {
    cvv = val;
    update();
  }

  getCardHolderName(val) {
    cardHolderName = val;
    update();
  }

  addPayment(PaymentMehodModel payment) {
    dbPaymentClient.insert(payment).then((_) {
      getAllPayments();
      Get.back();
    });
  }

  getAllPayments() async {
    _paymentsList = await dbPaymentClient.getAllPayments();
    update();
  }

  deleteOnePayment(id) {
    dbPaymentClient.deleteOnePayment(id).then((_) => getAllPayments());
  }

  updateSelectedPaymentsParameter(id) {
    dbPaymentClient.updateSelected(id).then((_) => getAllPayments());
  }

  clearPaymentData() {
    cardNumber = expireDate = cvv = cardHolderName = '';
    cardImage = 'assets/more/visa.png';
    update();
  }

  //rateOurApp
  double? appRateValue = 0;
  setAppRateValue(rateVal) {
    appRateValue = rateVal;
    update();
    FireStoreRateApp().addAppRateToFireStore(rateVal, savedUser!.id);
  }

  getAppRateValue() {
    FireStoreRateApp().getAppRateFromFireStore(savedUser!.id).then((value) {
      if (value == null) {
        return;
      }
      appRateValue = value['rateValue'];
      update();
    });
  }
}
