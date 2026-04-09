import 'package:flutter/material.dart';
import 'package:gds_foundation/gds_foundation.dart';

enum GdsCounterSize {
  lg,
  md,
}

/// 페이지네이션에서 현재 페이지와 총 페이지 수를 표시하는 컴포넌트입니다.
class GdsCounter extends StatelessWidget {
  const GdsCounter({
    super.key,
    required this.count,
    required this.maxCount,
    this.size = GdsCounterSize.lg,
  });

  final int count;
  final int maxCount;
  final GdsCounterSize size;

  TextStyle get textStyle {
    return switch (size) {
      GdsCounterSize.lg => GdsTypography.label2,
      GdsCounterSize.md => GdsTypography.label5,
    };
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: GdsSpacing.spacing4,
        horizontal: GdsSpacing.spacing12,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(GdsRadius.full),
        color: GdsColors.black.withAlpha((GdsOpacity.opacity60 * 255).toInt()),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: GdsSpacing.spacing2,
        children: [
          Text('$count', style: textStyle.copyWith(color: colors.text.white)),
          Text('/', style: textStyle.copyWith(color: colors.text.white)),
          Text('$maxCount', style: textStyle.copyWith(color: colors.text.white)),
        ],
      ),
    );
  }
}
