import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

extension WidgetExt on Widget {
  Widget skeletonMask({
    Color? baseColor,
    Color? highlightColor,
    BorderRadiusGeometry? borderRadius,
  }) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: highlightColor ?? Colors.white,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius ?? BorderRadius.circular(30),
        ),
        child: this,
      ),
    );
  }
}
