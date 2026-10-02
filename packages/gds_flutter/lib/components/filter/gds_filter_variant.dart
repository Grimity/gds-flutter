import 'package:gds_flutter/components/filter/gds_filter_style.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 필터의 시각적 스타일과 크기를 나타내는 열거형.
enum GdsFilterVariant {
  outline(
    enabled: .new(border: .all(color: .borderGraySubtle)),
    disabled: .new(
      border: .all(color: .borderGraySubtler),
      iconColor: .iconGraySubtler,
      textColor: .textGraySubtler,
    ),
    size: .md,
    radius: .sm,
  ),
  text(
    enabled: .new(),
    disabled: .new(
      iconColor: .iconGraySubtler,
      textColor: .textGraySubtler,
    ),
    size: .sm,
  );

  const GdsFilterVariant({
    required this.enabled,
    required this.disabled,
    required this.size,
    this.radius,
  });

  final GdsFilterStyle enabled;
  final GdsFilterStyle disabled;
  final GdsControlSize size;
  final GdsRadius? radius;
}
