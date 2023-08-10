// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:ephoneandsystems/utils/colors.dart';
import 'package:ephoneandsystems/widgets/spacing.dart';
import 'package:ephoneandsystems/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProgressScreen extends StatefulWidget {
  ProgressScreen({required this.progress, super.key});
  int progress = 0;
  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) => widget.progress == 100
    //     ? Navigator.pushAndRemoveUntil(
    //         context,
    //         MaterialPageRoute(builder: (context) => ViewWebPage()),
    //         (route) => false)
    //     : () {});
    return Scaffold(
      backgroundColor: white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularPercentIndicator(
              radius: 90.0,
              lineWidth: 10,
              backgroundColor: Colors.grey.shade300,
              curve: Curves.bounceOut,
              percent: widget.progress.toDouble() / 100.0,
              center: TextOf(
                  text: "${widget.progress.toString()}%",
                  size: 20,
                  weight: FontWeight.w600,
                  color: black),
              progressColor: primaryColor,
            ),
            YMargin(10),
            TextOf(
                text: "Please wait...",
                size: 12,
                weight: FontWeight.w500,
                color: black)
          ],
        ),
      ),
    );
  }
}
