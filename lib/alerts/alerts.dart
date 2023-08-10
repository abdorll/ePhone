import 'package:flutter_easyloading/flutter_easyloading.dart';

class Alerts {
  static showLoading({double progress = 0.0, String status = ""}) {
    EasyLoading.showProgress(progress, status: status);
  }

  static showSuccess({required String text}) {
    EasyLoading.showSuccess(text);
  }

  static close() {
    EasyLoading.dismiss();
  }
}
