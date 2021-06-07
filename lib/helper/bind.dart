import '../core/viewModel/categoriesViewModel.dart';
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
    Get.lazyPut(() => CategoriesViewModel());
  }
}
