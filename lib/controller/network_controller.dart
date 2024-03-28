import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:modon_web_app/home_page.dart';
import 'package:modon_web_app/no_internet_screen.dart';

class NetworkController extends GetxController with StateMixin{
  final Connectivity _connectivity = Connectivity();
  var isInternetAvailable = true.obs;

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      isInternetAvailable.value = false;
      Get.off(() => const NoInternetScreen());
      // Get.rawSnackbar(
      //     messageText: const Text('PLEASE CONNECT TO THE INTERNET',
      //         style: TextStyle(color: Colors.white, fontSize: 14)),
      //     isDismissible: false,
      //     duration: const Duration(days: 1),
      //     backgroundColor: Colors.red[400]!,
      //     icon: const Icon(
      //       Icons.wifi_off,
      //       color: Colors.white,
      //       size: 35,
      //     ),
      //     margin: EdgeInsets.zero,
      //     snackStyle: SnackStyle.GROUNDED);
    } else {
      isInternetAvailable.value = true;

      Get.to(() => const MyHomePage());

      // if (Get.isSnackbarOpen) {
      //   Get.closeCurrentSnackbar();
      // }
    }
  }
}
