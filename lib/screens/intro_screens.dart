// ignore_for_file: must_be_immutable, prefer_const_constructors_in_immutables
import 'package:ephoneandsystems/main.dart';
import 'package:ephoneandsystems/utils/colors.dart';
import 'package:ephoneandsystems/utils/image_path.dart';
import 'package:ephoneandsystems/widgets/intro_screen.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  IntroScreen({Key? key}) : super(key: key);

  PageController pageController = PageController();
  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final pageViewController = PageController();
  int onboardingItemIndex = 0;

  @override
  void initState() {
    determineUser();
    super.initState();
  }

  @override
  void dispose() {
    widget.pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    List<IntroPageIntems> onboardingItems = [
      IntroPageIntems(
          imagePath: imageName(Img.bestDeal),
          controller: widget.pageController,
          currenIndedx: 0,
          title: "Welcome to EphonesandSystems",
          subtitle: "Discover the Best Deals on Phones and Laptops"),
      IntroPageIntems(
          imagePath: imageName(Img.technology),
          controller: widget.pageController,
          currenIndedx: 1,
          title: "EphonesandSystems: Elevating Your Digital Experience",
          subtitle:
              "Unleash the Power of Technology with a Vast Selection of Top-Notch Phones and Laptops"),
      IntroPageIntems(
          imagePath: imageName(Img.browse),
          controller: widget.pageController,
          currenIndedx: 2,
          title: "Browse Trending Devices",
          subtitle:
              "Stay Up-to-Date with the Latest Phones and Laptops in the Market"),
      IntroPageIntems(
          imagePath: imageName(Img.qualityAssurance),
          controller: widget.pageController,
          currenIndedx: 3,
          title: "Quality Assurance",
          subtitle:
              "Buy with Confidence - We Guarantee Authentic and Reliable Devices"),

      //
    ];

    return WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: Scaffold(
            backgroundColor: white,
            body: PageView(
              controller: widget.pageController,
              onPageChanged: pageChanged,
              children: onboardingItems,
            )));
  }

  void pageChanged(int value) {
    setState(() {
      onboardingItemIndex = value;
    });
  }
}
