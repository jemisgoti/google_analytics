import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeadLine extends StatelessWidget {
  const HeadLine(this.title, {super.key});
  final String title;
  @override
  Widget build(BuildContext context) => Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      );
}

class TitleText extends StatelessWidget {
  const TitleText(this.title, {super.key});
  final String title;
  @override
  Widget build(BuildContext context) => Text(
        title,
        style: GoogleFonts.openSans(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      );
}

class Paragraph extends StatelessWidget {
  const Paragraph(this.title, {this.color, super.key});
  final String title;
  final Color? color;
  @override
  Widget build(BuildContext context) => Text(
        title,
        style: GoogleFonts.ubuntu(
          fontSize: 16,
          color: color ?? Colors.black.withOpacity(0.65),
        ),
      );
}
