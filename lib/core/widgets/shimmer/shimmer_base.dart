import 'package:bookia/core/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerBase extends StatelessWidget {
  final Widget child;
  const ShimmerBase({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.secondaryColor,
      highlightColor: AppColors.backgroundColor.withValues(alpha: 0.5),
      child: child,
    );
  }
}
