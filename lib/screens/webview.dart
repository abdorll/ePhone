// ignore_for_file: avoid_print, void_checks

import 'dart:async';

import 'package:ephoneandsystems/screens/device_not_connected.dart';
import 'package:ephoneandsystems/screens/progress_screen.dart';
import 'package:ephoneandsystems/utils/colors.dart';
import 'package:ephoneandsystems/utils/constants.dart';
import 'package:ephoneandsystems/utils/image_path.dart';
import 'package:ephoneandsystems/utils/instances.dart';
import 'package:ephoneandsystems/widgets/spacing.dart';
import 'package:ephoneandsystems/widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:ephoneandsystems/utils/constants.dart';

class ViewWebPage extends ConsumerStatefulWidget {
  const ViewWebPage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ViewWebPageState();
}

class _ViewWebPageState extends ConsumerState<ViewWebPage> {
  StreamSubscription<ConnectivityResult>? connectivitySubscription;

  Color? backColor, forwardColor;

  bool firstTime = true;
  late final WebViewController webViewController;
  @override
  void initState() {
    hasSeen();
    setState(() {
      firstTime = true;
    });
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String uri) {
            // Alerts.showLoading(progress: 2, status: "Please wait");

            setState(() {
              loaded = false;
              progress = 0;
              uri = url;
            });
          },
          onProgress: (int value) {
            setState(() {
              progress = value;
            });
          },
          onPageFinished: (String uri) async {
            var user = await Hive.openBox(USER_BOX);
            user.put(HAS_SEEN, false);
            setState(() {
              url = uri;
              loaded = true;
              progress = 100;
            });
          },
          onWebResourceError: (WebResourceError error) async {
            var user = await Hive.openBox(USER_BOX);
            user.get(HAS_SEEN);
            webViewController.reload();
            setState(() {
              deviceConnectedToInternet = false;
              // user.get(HAS_SEEN) == true ? () {} : webViewController.reload();
            });

            // Future.delayed(const Duration(days: 1));
            // webViewController.reload();
          },
        ),
      )
      ..addJavaScriptChannel(
        'Message',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse(url));
    init();
    super.initState();
  }

  int progress = 0;
  bool loaded = false;
  webViewInitialized() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const ViewWebPage()),
        (route) => false);
  }

  hasSeen() async {
    var user = await Hive.openBox(USER_BOX);
    user.put(HAS_SEEN, true);
  }

  ConnectivityResult connectivityResult = ConnectivityResult.none;
  Future init() async {
    connectivityResult = await internetConnectivity.checkConnectivity();
    setState(() {
      connectivitySubscription = internetConnectivity.onConnectivityChanged
          .listen((ConnectivityResult result) async {
        connectivityResult = result;
        setState(() {
          (connectivityResult == ConnectivityResult.mobile ||
                  connectivityResult == ConnectivityResult.wifi)
              ? deviceConnectedToInternet = true
              : deviceConnectedToInternet = false;
        });
      });
    });
  }

  @override
  void dispose() {
    connectivitySubscription!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   setState(() {});
    // });
    Future.delayed(Duration(seconds: 10));
    loadBackColor().then((value) => backColor = value);
    loadForwardColor().then((value) => forwardColor = value);
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
            barrierColor: primaryColor.withOpacity(0.3),
            context: context,
            builder: (context) {
              return Dialog(
                insetPadding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.6,
                  padding: const EdgeInsets.fromLTRB(15, 25, 15, 10),
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(imageName(Img.question)),
                      const YMargin(10),
                      TextOf(
                        text: "Quitting ePhone",
                        size: 17,
                        weight: FontWeight.w800,
                        color: black,
                        align: TextAlign.center,
                      ),
                      const YMargin(10),
                      TextOf(
                        text: 'Are you sure you want  to quit?',
                        size: 14,
                        weight: FontWeight.w500,
                        color: black,
                        align: TextAlign.center,
                      ),
                      const YMargin(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 40,
                            width: 100,
                            // padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10)),
                            child: InkWell(
                              child: Center(
                                child: TextOf(
                                  text: 'Yes',
                                  size: 12,
                                  weight: FontWeight.w700,
                                  color: black,
                                ),
                              ),
                              onTap: () => Navigator.of(context).pop(true),
                            ),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            // padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                            decoration: BoxDecoration(
                                color: primaryColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: InkWell(
                                child: TextOf(
                                    text: 'No',
                                    size: 12,
                                    weight: FontWeight.w700,
                                    color: primaryColor),
                                onTap: () => Navigator.of(context).pop(false),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            });
        // return await showCupertinoDialog(
        //     context: context,
        //     builder: (BuildContext context) {
        //       return CupertinoAlertDialog(
        //           title:
        //               //TextOf('Quitting HalalVest', 15, black, FontWeight.w700)
        //               TextOf(
        //             text: "Quitting ePhone...",
        //             size: 17,
        //             weight: FontWeight.w700,
        //             color: black,
        //             align: TextAlign.center,
        //           ),
        //           content: TextOf(
        //             text: 'Are you sure you want  to quit ePhone?',
        //             size: 12,
        //             weight: FontWeight.w500,
        //             color: black,
        //             align: TextAlign.center,
        //           ),
        //           actions: [
        //             CupertinoDialogAction(
        //               child: TextOf(
        //                 text: 'Yes',
        //                 size: 10,
        //                 weight: FontWeight.w700,
        //                 color: black,
        //               ),
        //               onPressed: () => Navigator.of(context).pop(true),
        //             ),
        // CupertinoDialogAction(
        //   child: TextOf(
        //       text: 'No',
        //       size: 10,
        //       weight: FontWeight.w700,
        //       color: primaryColor),
        //   onPressed: () => Navigator.of(context).pop(false),
        // ),
        //           ]);
        //     });
      },
      child: Stack(
        children: [
          Scaffold(
              body: deviceConnectedToInternet == false
                  ? DeviceNotConnected(webViewController: webViewController)
                  : SafeArea(
                      child: WebViewWidget(controller: webViewController)),
              bottomNavigationBar: Container(
                height: 60,
                decoration: BoxDecoration(color: white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: deviceConnectedToInternet == true
                      ? [
                          eachIcon(
                              icon: Icons.home_outlined,
                              text: 'Home',
                              callback: () {
                                webViewInitialized();
                              },
                              path: Img.home),
                          eachIcon(
                              icon: Icons.arrow_back_ios_new_rounded,
                              text: 'Back',
                              color: backColor,
                              callback: () {
                                canGoBack() == true ? goBack() : null;
                              },
                              path: Img.back),
                          eachIcon(
                              icon: Icons.arrow_forward_ios_rounded,
                              color: forwardColor,
                              text: 'Forward',
                              callback: () {
                                canGoForward() == true ? goForward() : null;
                              },
                              path: Img.forward),
                          eachIcon(
                              icon: Icons.refresh,
                              text: 'Refresh',
                              callback: () {
                                webViewController.reload();
                              },
                              path: Img.refresh),
                        ]
                      : [],
                ),
              )),
          if (progress < 100 && deviceConnectedToInternet == true)
            ProgressScreen(progress: progress)
        ],
      ),
    );
  }

  Future<void> goBack() async {
    await webViewController.goBack();
  }

  Future<void> goForward() async {
    await webViewController.goForward();
  }

  Future<bool> checkCanGoBack() async {
    return await webViewController.canGoBack();
  }

  Future<bool> checkCanGoForward() async {
    return await webViewController.canGoForward();
  }

  bool userCanGoBack = false;
  bool canGoBack() {
    checkCanGoBack().then((value) {
      setState(() {
        userCanGoBack = value;
      });
      print('go back $value');
    });
    return userCanGoBack;
  }

  bool userCanGoForward = false;
  bool canGoForward() {
    checkCanGoForward().then((value) {
      setState(() {
        userCanGoForward = value;
      });
      print('can go forward $value');
    });
    return userCanGoForward;
  }

  Future<Color> loadBackColor() async {
    Color color = await webViewController.canGoBack()
        ? primaryColor
        : Colors.grey.withOpacity(0.6);
    return color;
  }

  Future<Color> loadForwardColor() async {
    Color color = await webViewController.canGoForward()
        ? primaryColor
        : Colors.grey.withOpacity(0.6);
    return color;
  }
}

eachIcon(
    {required IconData icon,
    required String text,
    required Function callback,
    String? path,
    Color? color}) {
  return InkWell(
    onTap: () {
      callback();
    },
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ImageIcon(
          AssetImage(imageName(path!)),
          color: color ?? primaryColor,
        ),
        const YMargin(5),
        TextOf(
            text: text,
            size: 10,
            weight: FontWeight.w800,
            color: color ?? primaryColor)
      ],
    ),
  );
}
//--no-tree-shake-icons