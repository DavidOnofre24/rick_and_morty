import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BoxSimmer extends StatelessWidget {
  final double? height;
  final double width;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? baseColor;
  final Color? highlightColor;
  final double borderRadius;
  const BoxSimmer({
    Key? key,
    this.height,
    this.padding,
    this.margin,
    this.baseColor,
    this.highlightColor,
    this.width = double.infinity,
    this.borderRadius = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      height: height,
      width: width,
      child: Shimmer.fromColors(
        baseColor: baseColor ?? Colors.grey[300]!,
        highlightColor: highlightColor ?? Colors.grey[200]!,
        period: const Duration(seconds: 1),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
    );
  }
}
