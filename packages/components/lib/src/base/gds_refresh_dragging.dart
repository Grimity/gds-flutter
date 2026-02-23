import 'package:flutter/material.dart';
import 'package:gds_foundation/gds_foundation.dart';

class GdsRefreshDragging extends StatelessWidget {
  const GdsRefreshDragging({super.key, this.width, this.height});

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? GdsLottie.refreshDraggingBasic.build(width: width, height: height)
        : GdsLottie.refreshDraggingDark.build(width: width, height: height);
  }
}
