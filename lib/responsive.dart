import 'package:flutter/material.dart';
import 'const.dart';
import 'model/deviceInfo.dart';

class Responsive extends StatelessWidget {
  final Widget Function(BuildContext context, DeviceInfo deviceInfo) builder;
  Responsive({@required this.builder});

  @override
  Widget build(BuildContext context) {
    DeviceType getDeviceType(MediaQueryData mediaQueryData) {
      double width = mediaQueryData.size.width;
      if (width >= 950) {
        return DeviceType.Desktop;
      }
      if (width >= 600) {
        return DeviceType.Tablet;
      }
      return DeviceType.Mobile;
    }

    return LayoutBuilder(
      builder: (context, constrains) {
        var mediaQueryData = MediaQuery.of(context);
        var deviceInfo = DeviceInfo(
          deviceType: getDeviceType(mediaQueryData),
          screenWidth: mediaQueryData.size.width,
          screenHeight: mediaQueryData.size.height,
          localHeight: constrains.maxHeight,
          localWidth: constrains.maxWidth,
          widgetScaleFactor: mediaQueryData.size.width / 411.42,
        );
        return builder(context, deviceInfo);
      },
    );
  }
}
