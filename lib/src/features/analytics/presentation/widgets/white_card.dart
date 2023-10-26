import 'package:flutter/material.dart';
import 'package:test_app/src/core/theme/colors.dart';
import 'package:test_app/src/core/theme/dimension.dart';

class WhiteCard extends StatelessWidget {
  const WhiteCard({required this.child, this.padding = 14, super.key});
  final Widget child;
  final double padding;
  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(mainMarginHalf),
        ),
        child: child,
      );
}
