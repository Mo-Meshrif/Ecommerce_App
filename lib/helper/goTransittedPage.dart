import 'dart:io';
import 'package:get/get.dart';

class Go {
  static Future<dynamic> to(
    dynamic page, {
    dynamic arguments,
    Transition transition,
    Duration duration,
  }) async {
    Get.to(
      page,
      arguments: arguments,
      transition: transition != null
          ? transition
          : Platform.isIOS
              ? Transition.rightToLeft
              : Transition.size,
      duration: duration != null
          ? duration
          : Duration(milliseconds: Platform.isIOS ? 500 : 1000),
    );
  }
}
