import 'package:gds_flutter/gds_flutter.dart';

/// 칩의 시각적 스타일을 나타내는 열거형.
enum GdsChipVariant {
  primary(
    backgroundColor: .surfacePrimarySubtlest,
    borderColor: .borderPrimarySubtler,
    labelColor: .textPrimaryNormal,
    labelStyle: .label6,
  ),
  assistive(
    backgroundColor: .surfaceGraySubtlest,
    borderColor: .borderGraySubtler,
    labelColor: .textGrayNormal,
    labelStyle: .label5,
  );

  const new({
    required this.backgroundColor,
    required this.borderColor,
    required this.labelColor,
    required this.labelStyle,
  });

  final GdsColor backgroundColor;
  final GdsColor borderColor;
  final GdsColor labelColor;
  final GdsTypography labelStyle;
}
