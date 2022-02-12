
import 'dart:async';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkManager extends GetxController {
  late bool isConnected;
  //Stream to keep listening to network change state
  late StreamSubscription _streamSubscription;

  @override
  void onInit() {
    _streamSubscription =
        InternetConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          isConnected = true;
          update();
          break;
        case InternetConnectionStatus.disconnected:
          isConnected = false;
          update();
          Get.snackbar(
            'Network Error',
            'There is no internet connection !',
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 2),
          );
          break;
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    _streamSubscription.cancel();
  }
}
