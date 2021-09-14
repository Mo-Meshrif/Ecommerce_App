import '../../core/service/fireStore_order.dart';
import '../../view/subViews/cartView/orderPlacedView.dart';
import '../../model/orderModel.dart';
import 'moreViewModel.dart';
import '../../helper/cartDatabaseHelper.dart';
import '../../model/cartProductModel.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

enum paymentMethod { cashOnDelivery, masterCard }

class CartViewModel extends GetxController {
  @override
  void onInit() {
    getOrders();
    super.onInit();
  }

  var db = CartDataBaseHelper.db;
  final MoreViewModel _moreViewModel = Get.find();
  List<CartProductModel> cartProds = [];
  double totalPrice = 0;
  String promoCode = '';
  addProduct({
    @required CartProductModel cartProd,
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

  getProducts() async {
    if (_moreViewModel.savedUser == null) {
      return;
    }
    List<CartProductModel> tempList = await db.getAllProducts();
    cartProds = tempList
        .where((element) => element.sellerId == _moreViewModel.savedUser.id)
        .toList();
    getTotalPrice();
    update();
  }

  getTotalPrice() {
    totalPrice = 0;
    update();
    for (var i = 0; i < cartProds.length; i++) {
      totalPrice += (double.parse(cartProds[i].price) * cartProds[i].quantity);
    }
    update();
  }

  increaseQuantity(index) async {
    if (cartProds[index].quantity >= 1) {
      cartProds[index].quantity++;
      totalPrice += double.parse(cartProds[index].price);
      await db.updateProduct(cartProds[index]);
    }
    update();
  }

  decreaseQuantity(index, fromProdDetails) async {
    if (cartProds[index].quantity > 1) {
      cartProds[index].quantity--;
      totalPrice -= double.parse(cartProds[index].price);
      await db.updateProduct(cartProds[index]);
    } else if (cartProds[index].quantity == 1 && fromProdDetails == true) {
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

  deleteAll() async {
    await db.deleteAll();
    cartProds = [];
    totalPrice = 0;
    update();
  }

  addPromoCode(val) {
    promoCode = val;
    update();
  }

  //order
  paymentMethod pay = paymentMethod.cashOnDelivery;
  ValueNotifier<bool> _orderLoading = ValueNotifier(false);
  ValueNotifier<bool> get orderloading => _orderLoading;
  List<OrderModel> _orders = [];
  List<OrderModel> get orders => _orders;
  changePay(val) {
    pay = val;
    update();
  }

  addOrder(OrderModel order) async {
    _orderLoading.value = true;
    update();
    await FireStoreOrder()
        .addOrderToFireStore(order)
        .then((_) async => await getOrders().then((_) {
              _orderLoading.value = false;
              update();
              Get.offAll(() => OrderPlacedView());
            }));
  }

  Future<void> getOrders() async {
    _orders = [];
    await FireStoreOrder().getOrdersFromFireStore().then((value) {
      for (int i = 0; i < value.length; i++) {
        _orders.add(OrderModel.fromJson(value[i].data()));
      }
      update();
    });
  }
}
