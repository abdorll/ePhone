// import 'dart:async';
// import 'package:ephoneandsystems/alerts/alerts.dart';
// import 'package:ephoneandsystems/utils/constants.dart';
// import 'package:ephoneandsystems/utils/instances.dart';
// import 'package:get/get.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class Logics extends GetxController {
//   //------------Web View Logic-----------
//   static webViewInitialized() {
//     webViewController = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(const Color(0x00000000))
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             if (progress < 100) {
//               Alerts.showLoading(
//                   progress: progress.toDouble(), status: "Please wait");
//             } else {
//               Alerts.showSuccess(text: "Success");
//               Future.delayed(const Duration(seconds: 1), () {
//                 Alerts.close();
//               });
//             }
//           },
//           onPageStarted: (String url) {
//             Alerts.showLoading(progress: 2, status: "Please wait");
//           },
//           onPageFinished: (String url) {},
//           onWebResourceError: (WebResourceError error) {
//             deviceConnectedToInternet = false;
//             webViewController.reload();
//           },
//           onNavigationRequest: (NavigationRequest request) {
//             if (request.url.startsWith('https://tailwindui.com/')) {
//               return NavigationDecision.prevent;
//             }
//             return NavigationDecision.navigate;
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse('https://tailwindui.com/'));
//   }

//   //------------------Get Internet connectioon result type---------
//   static ConnectivityResult connectivityResult = ConnectivityResult.none;

//   // //------------- Listen to connection status------------
//   // void deviceConnectedOrNot() {
//   //   (connectivityResult == ConnectivityResult.mobile) ||
//   //           (connectivityResult == ConnectivityResult.wifi)
//   //       ? deviceConnectedToInternet = true
//   //       : false;
//   //   update();

//   //   print("status: $deviceConnectedToInternet");
//   // }

//   // static StreamSubscription<ConnectivityResult>? connectivitySubscription;
//   // //--------------------Got connection status stream pipeline
//   // void connectionStatusStream() {
//   //   connectivitySubscription = internetConnectivity.onConnectivityChanged
//   //       .listen((ConnectivityResult result) {
//   //     connectivityResult = result;
//   //     update();
//   //   });
//   //   update();
//   //   // return connectivitySubscription!;
//   // }

//   // //-------------Close Connectiin Stream when done
//   // static closeConnectionStreamWhenDone() {
//   //   connectivitySubscription!.cancel();
//   // }
// }
