import 'dart:io';
import 'package:flutter/material.dart';
import '/helper/networkManager.dart';
import '../../model/userModel.dart';
import '../../core/service/fireStore_order.dart';
import '../../view/subViews/cartView/orderPlacedView.dart';
import '../../model/orderModel.dart';
import '../../helper/cartDatabaseHelper.dart';
import '../../model/cartProductModel.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'notificationViewModel.dart';

enum paymentMethod { cashOnDelivery, masterCard }

class CartViewModel extends GetxController {
  @override
  void onInit() {
    getOrders();
    super.onInit();
  }

  var db = CartDataBaseHelper.db;
  final NotificationViewModel _notificationViewModel = Get.find();
  List<CartProductModel> cartProds = [];
  double _totalPrice = 0;
  String get totalPrice => _totalPrice.toStringAsFixed(2);


  addProduct({
    required CartProductModel cartProd,
  }) {
    if (cartProds.length == 0) {
      db.insert(cartProd);
      cartProds.add(cartProd);
    } else {
      for (var i = 0; i < cartProds.length; i++) {
        if (cartProds[i].id == cartProd.id) {
          return;
        }
      }
      db.insert(cartProd);
      cartProds.add(cartProd);
    }
    update();
    getTotalPrice();
  }

  getProducts(UserModel user) async {
    List<CartProductModel> tempList = await db.getAllProducts();
    cartProds =
        tempList.where((element) => element.customerId == user.id).toList();
    getTotalPrice();
    update();
  }

  getTotalPrice() {
    _totalPrice = 0;
    update();
    for (var i = 0; i < cartProds.length; i++) {
      _totalPrice = _totalPrice +
          (double.parse(cartProds[i].price!) * cartProds[i].quantity!);
    }
    update();
  }

  increaseQuantity(index) async {
    if (cartProds[index].quantity! >= 1) {
      cartProds[index].quantity = cartProds[index].quantity! + 1;
      _totalPrice = _totalPrice + double.parse(cartProds[index].price!);
      await db.updateProduct(cartProds[index]);
    }
    update();
  }

  decreaseQuantity(index, fromProdDetails) async {
    if (cartProds[index].quantity! > 1) {
      cartProds[index].quantity = cartProds[index].quantity! - 1;
      _totalPrice = _totalPrice - double.parse(cartProds[index].price!);
      await db.updateProduct(cartProds[index]);
    } else if (cartProds[index].quantity == 1) {
      deleteProduct(index);
    }
    update();
  }

  deleteProduct(index) async {
    await db.deleteProduct(cartProds[index]);
    cartProds.removeAt(index);
    getTotalPrice();
    update();
  }

  int getCartProdIndex(id) {
    return cartProds.indexWhere((cartProd) => cartProd.id == id);
  }

  //order
  paymentMethod? pay = paymentMethod.cashOnDelivery;
  int? orderNumber;
  ValueNotifier<bool> _orderLoading = ValueNotifier(false);
  ValueNotifier<bool> get orderloading => _orderLoading;
  List<OrderModel> _orders = [];
  List<OrderModel> get allOrders => _orders;

  changePay(val) {
    pay = val;
    update();
  }

  setOrderNumber() {
    orderNumber = int.parse(
        DateFormat('yyMMdd').format(Timestamp.now().toDate()) +
            Random().nextInt(1000).toString());
    update();
  }

  addOrder(OrderModel order) async {
    if (Get.find<NetworkManager>().isConnected) {
      _orderLoading.value = true;
      update();
      await FireStoreOrder().addOrderToFireStore(order).then((_) async {
        _orderLoading.value = false;
        update();
        Get.offUntil(
          GetPageRoute(
            page: () => OrderPlacedView(),
            curve: Curves.linear,
            transition:
                Platform.isIOS ? Transition.rightToLeft : Transition.size,
            transitionDuration:
                Duration(milliseconds: Platform.isIOS ? 500 : 700),
          ),
          (route) => (route as GetPageRoute).routeName=='/ControlView',
        );
        deleteAll();
        _notificationViewModel.sendNotification([], 'New order ');
      });
    } else {
      Get.snackbar(
        'Network Error',
        'There is no internet connection !',
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 2),
      );
    }
  }

  Future<void> getOrders() async {
    _orders = [];
    await FireStoreOrder().getOrdersFromFireStore().then((value) {
      for (int i = 0; i < value.length; i++) {
        Map<String, dynamic> data = value[i].data() as Map<String, dynamic>;
        _orders.add(OrderModel(
          orderId: value[i].id,
          customerId: data['customerId'],
          status: data['status'],
          orderTrack: data['orderTrack'],
          orderNumber: data['orderNumber'],
          shippingAdress: data['shippingAdress'],
          paymentMehod: data['paymentMehod'],
          items: data['items'],
          rate: data['rate'],
        ));
      }
      update();
    });
  }

  getOrderRate(orderId, rateVal) async {
    await FireStoreOrder().changeOrderRateVal(orderId, rateVal);
  }

  deleteAll() async {
    await db.deleteAll();
    deleteSavedOrderNumber();
    cartProds = [];
    _totalPrice = 0;
    update();
  }

  deleteSavedOrderNumber() {
    orderNumber = null;
    update();
  }
}
