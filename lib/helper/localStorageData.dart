import 'dart:convert';
import 'package:ecommerce/model/productModel.dart';

import '../model/userModel.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageData extends GetxController {
  setUserData(UserModel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userData', jsonEncode(user.toJson()));
  }

  _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userData = prefs.getString('userData');
    return UserModel.fromJson(jsonDecode(userData));
  }

  Future<UserModel> get getUser async {
    try {
      UserModel user = await _getUserData();
      if (user == null) {
        return null;
      }
      return user;
    } catch (e) {
      return null;
    }
  }

  deleteUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
  }

  setrecentlyViewedProductsData(List<ProductModel> prods) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'recentlyViewedProductsData', ProductModel.encode(prods));
  }

  _getrecentlyViewedProductsData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var recentlyViewedProductsData =
        prefs.getString('recentlyViewedProductsData');
    return ProductModel.decode(recentlyViewedProductsData);
  }

  Future<List<ProductModel>> get getrecentlyViewedProducts async {
    try {
      List<ProductModel> recentlyViewedProducts =
          await _getrecentlyViewedProductsData();
      if (recentlyViewedProducts == null) {
        return null;
      }
      return recentlyViewedProducts;
    } catch (e) {
      return null;
    }
  }

  deleterecentlyViewedProductsData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('recentlyViewedProductsData');
  }
}
