import 'package:flutter/material.dart';
import 'package:gds_foundation/gds_foundation.dart';

class GdsCircularLoading extends StatelessWidget {
  const GdsCircularLoading({super.key, this.width, this.height});

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? GdsLottie.circularLoadingBasic.build(width: width, height: height)
        : GdsLottie.circularLoadingDark.build(width: width, height: height);
  }
}
