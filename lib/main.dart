import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import './helper/bind.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'view/controlView.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent,)
  );
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  ).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mega Store',
      home: ControlView(),
      initialBinding: Bind(),
    );
  }
}
