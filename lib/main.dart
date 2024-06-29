import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modon_web_app/splash_screen.dart';
import 'injection/dependency_injection.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await requestLocationPermission();
  runApp(const MyApp());
  DependencyInjection.init();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nasirabad',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}

Future<void> requestLocationPermission() async {
  var status = await Permission.storage.request();

  if (status.isGranted) {
    debugPrint('Location permission granted');
  } else if (status.isDenied) {
    debugPrint('Location permission denied');

    // Request location permission again
    var secondStatus = await Permission.location.request();
    if (secondStatus.isGranted) {
      debugPrint('Location permission granted on second attempt');
    } else if (secondStatus.isPermanentlyDenied) {
      // The user has permanently denied the permission, navigate to app settings
      openAppSettings();
    }
  } else if (status.isPermanentlyDenied) {
    // The user has permanently denied the permission, navigate to app settings
    openAppSettings();
  }
}
