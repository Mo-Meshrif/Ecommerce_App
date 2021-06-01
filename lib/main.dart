import 'package:firebase_core/firebase_core.dart';
import './helper/bind.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'view/controlView.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: ControlView(),
      initialBinding: Bind(),
    );
  }
}
