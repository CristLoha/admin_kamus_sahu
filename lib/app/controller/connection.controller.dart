import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConnectivityController extends GetxController
    with WidgetsBindingObserver {
  var hasConnection = false.obs;
  bool _isPaused = false;
  bool _hasNoInternetNotificationShown = false;

  @override
  void onInit() {
    super.onInit();
    checkInternetConnection();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        _isPaused = true;
        break;
      case AppLifecycleState.resumed:
        _isPaused = false;
        checkInternetConnection();
        break;
      default:
        break;
    }
  }

  Future<void> checkInternetConnection() async {
    if (_isPaused) {
      return; // do nothing if the app is paused
    }

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      hasConnection.value = true;
      if (_hasNoInternetNotificationShown) {
        showInternetNotification();
        _hasNoInternetNotificationShown = false;
      }
    } else {
      hasConnection.value = false;
      if (!_hasNoInternetNotificationShown) {
        showNoInternetNotification();
        _hasNoInternetNotificationShown = true;
      }
    }

    Connectivity().onConnectivityChanged.listen((result) {
      if (_isPaused) {
        return; // do nothing if the app is paused
      }

      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        hasConnection.value = true;
        if (_hasNoInternetNotificationShown) {
          showInternetNotification();
          _hasNoInternetNotificationShown = false;
        }
      } else {
        hasConnection.value = false;
        if (!_hasNoInternetNotificationShown) {
          showNoInternetNotification();
          _hasNoInternetNotificationShown = true;
        }
      }
    });
  }

  void showInternetNotification() {
    Get.snackbar(
      "Connected to Internet",
      "You are now connected to the internet",
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 3),
      backgroundColor: Colors.green,
      colorText: Colors.white,
      icon: Icon(
        Icons.check_circle,
        color: Colors.white,
      ),
    );
  }

  void showNoInternetNotification() {
    Get.snackbar(
      "No Internet",
      "Please check your internet connection",
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 3),
      backgroundColor: Colors.red,
      colorText: Colors.white,
      icon: Icon(
        Icons.warning,
        color: Colors.white,
      ),
    );
  }
}
