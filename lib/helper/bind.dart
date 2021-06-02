import 'package:ecommerce/core/viewModel/homeViewModel.dart';
import 'package:ecommerce/helper/localStorageData.dart';

import '../core/viewModel/authViewModel.dart';
import 'package:get/get.dart';

class Bind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthViewModel());
    Get.lazyPut(() => LocalStorageData());
    Get.lazyPut(() => HomeViewModel());
  }
}
