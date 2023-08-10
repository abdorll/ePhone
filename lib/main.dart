// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages

import 'package:bot_toast/bot_toast.dart';
import 'package:ephoneandsystems/screens/splash_screen.dart';
import 'package:ephoneandsystems/utils/colors.dart';
import 'package:ephoneandsystems/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
  determineUser();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: primaryColor,
  ));

  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..indicatorColor = primaryColor
    ..backgroundColor = primaryColor
    ..progressColor = primaryColor
    ..backgroundColor = primaryColor
    ..indicatorColor = primaryColor
    ..textColor = white
    ..maskColor = primaryColor.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

determineUser() async {
  WidgetsFlutterBinding.ensureInitialized();
  var path = await getApplicationDocumentsDirectory();
  // var path = Directory.current.path;
  Hive.init(path.path);
  await Hive.openBox(USER_BOX);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashSceen(),
      builder: (context, child) {
        return botToastBuilder(context, child);
      },
      navigatorObservers: [
        BotToastNavigatorObserver(),
      ],
    );
  }
}
