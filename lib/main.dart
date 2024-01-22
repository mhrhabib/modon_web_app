import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modon_web_app/splash_screen.dart';
import 'injection/dependency_injection.dart';

Future<void> main() async {
  runApp(const MyApp());
  DependencyInjection.init();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Taskly',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
