import '../../helper/cartDatabaseHelper.dart';
import '../../model/cartProductModel.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class CartViewModel extends GetxController {
  var db = CartDataBaseHelper.db;
  List<CartProductModel> cartProds = [];
  double totalPrice = 0;
  CartViewModel() {
    getProducts();
  }
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
    cartProds = await db.getAllProducts();
    getTotalPrice();
    update();
  }

  int getProductsLength() {
    return cartProds.length;
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

  decreaseQuantity(index) async {
    if (cartProds[index].quantity > 1) {
      cartProds[index].quantity--;
      totalPrice -= double.parse(cartProds[index].price);
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
}
