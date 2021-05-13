import 'package:get/get.dart';

class AuthViewModel extends GetxController {
  int currentIndex = 0;
  getPageIndex(int selectedIndex) {
    currentIndex = selectedIndex;
    update();
  }
}
