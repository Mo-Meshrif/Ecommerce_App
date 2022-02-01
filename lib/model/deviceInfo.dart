import '../const.dart';

class DeviceInfo {
  final DeviceType deviceType;
  final double screenWidth;
  final double screenHeight;
  final double localWidth;
  final double localHeight;
  final double widgetScaleFactor;
  DeviceInfo({
    this.deviceType,
    this.screenWidth,
    this.screenHeight,
    this.localWidth,
    this.localHeight,
    this.widgetScaleFactor,
  });
}
