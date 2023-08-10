// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:ephoneandsystems/main.dart';
import 'package:ephoneandsystems/screens/intro_screens.dart';
import 'package:ephoneandsystems/screens/webview.dart';
import 'package:ephoneandsystems/utils/constants.dart';
import 'package:ephoneandsystems/utils/image_path.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SplashSceen extends StatefulWidget {
  const SplashSceen({super.key});

  @override
  State<SplashSceen> createState() => _SplashSceenState();
}

class _SplashSceenState extends State<SplashSceen> {
  Widget screen = IntroScreen();
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      getUserStatus();
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return screen;
      }), (_) => false);
    });
    super.initState();
  }

  getUserStatus() async {
    var box = await Hive.openBox(USER_BOX);
    bool? data;
    setState(() {
      data = box.get(REGISTERED_USER_KEY) as bool;
    });

    print("data....... $data!");
    data! == true ? screen = ViewWebPage() : screen = IntroScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              imageName(Img.logo),
              height: 150,
            )
          ],
        ),
      ),
    );
  }
}
