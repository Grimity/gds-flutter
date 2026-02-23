import 'package:flutter/material.dart';
import 'package:gds_foundation/gds_foundation.dart';

class GdsRefreshLoading extends StatelessWidget {
  const GdsRefreshLoading({super.key, this.width, this.height});

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? GdsLottie.refreshLoadingBasic.build(width: width, height: height)
        : GdsLottie.refreshLoadingDark.build(width: width, height: height);
  }
}
