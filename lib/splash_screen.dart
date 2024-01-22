import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Connectivity _connectivity = Connectivity();

  bool isInternet = false;

  @override
  void initState() {
    _connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        setState(() {
          isInternet = true;
        });
        print(isInternet);

        navigateTo();
      } else if (result == ConnectivityResult.other) {
        setState(() {
          isInternet = false;
        });
      } else {
        setState(() {
          isInternet = false;
        });

        print(isInternet);
      }
    });
    super.initState();
  }

  navigateTo() async {
    await Future.delayed(const Duration(seconds: 2)).then((_) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const MyHomePage(),
      ));
    });
  }

  @override
  void dispose() {
    // streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: isInternet
            ? Lottie.asset('assets/Animation - 1704799112756.json')
            : Lottie.asset('assets/noInternet.json'),
      ),
    );
  }
}
