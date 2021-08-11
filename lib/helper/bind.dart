import '../core/viewModel/moreViewModel.dart';
import '../core/viewModel/cartViewModel.dart';
import '../core/viewModel/filterViewModel.dart';
import '../core/viewModel/searchViewModel.dart';
import '../core/viewModel/homeViewModel.dart';
import '../helper/localStorageData.dart';
import '../core/viewModel/authViewModel.dart';
import 'package:get/get.dart';

class Bind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthViewModel());
    Get.lazyPut(() => LocalStorageData());
    Get.lazyPut(() => HomeViewModel());
    Get.lazyPut(() => SearchViewModel());
    Get.lazyPut(() => FilterViewModel());
    Get.lazyPut(() => CartViewModel());
    Get.lazyPut(() => MoreViewModel());
  }
}
