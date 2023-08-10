// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextOf extends StatelessWidget {
  TextOf(
      {required this.text,
      required this.size,
      required this.weight,
      required this.color,
      this.align = TextAlign.left,
      this.height=0.0,
      super.key});
  String text = "";
  double size, height = 0.0;
  FontWeight weight;
  Color color;

  TextAlign align;
  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: align,
        style: GoogleFonts.mulish(
          height: height,
          fontSize: size,
          fontWeight: weight,
          color: color,
        ));
  }
}
