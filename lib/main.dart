import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riding_information_app/lendingPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: Get.key, // contextless navigation용
      debugShowCheckedModeBanner: false,
      home: const LendingPage(),
    );
  }
}
