// ignore_for_file: must_be_immutable

import 'package:ephoneandsystems/utils/colors.dart';
import 'package:ephoneandsystems/widgets/text.dart';
import 'package:flutter/material.dart';

class MajorButton extends StatelessWidget {
  MajorButton({
    required this.text,
    required this.onTap,
    required this.enabled,
    Key? key,
  }) : super(key: key);
  String text;
  Function onTap;
  bool enabled;
  @override
  Widget build(BuildContext context) {
    return enabled == true
        ? GestureDetector(
            onTap: () {
              onTap();
            },
            child: btn(text, enabled),
          )
        : btn(text, enabled);
  }
}

SizedBox btn(String text, bool enabled) {
  return SizedBox(
    height: 45,
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: enabled == true ? primaryColor : primaryColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(10)),
      child: Center(
          child: TextOf(
              text: text, size: 16, weight: FontWeight.w500, color: white)),
    ),
  );
}
