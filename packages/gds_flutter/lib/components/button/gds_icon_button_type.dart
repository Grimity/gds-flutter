import 'package:gds_flutter/components/button/gds_button_style.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 아이콘 버튼의 크기와 시각적 스타일을 나타내는 열거형.
enum GdsIconButtonType {
  sm(
    iconSize: 16,
    size: .xs,
    enabled: .new(iconColor: .iconGrayBold),
    disabled: .new(iconColor: .iconGraySubtler),
    loading: .new(),
  ),
  normal(
    iconSize: 24,
    size: .sm,
    enabled: .new(iconColor: .iconGrayBold),
    disabled: .new(iconColor: .iconGraySubtler),
    loading: .new(),
  ),
  outlined(
    iconSize: 16,
    size: .sm,
    enabled: .new(backgroundColor: .surfaceBase, borderColor: .borderGraySubtle, iconColor: .iconGrayBold),
    disabled: .new(backgroundColor: .surfaceGraySubtlest, borderColor: .borderGraySubtler, iconColor: .iconGraySubtler),
    loading: .new(borderColor: .borderGraySubtle),
  ),
  solid(
    iconSize: 16,
    size: .sm,
    enabled: .new(backgroundColor: .bgOverlayBlack, iconColor: .iconWhite),
    disabled: .new(backgroundColor: .bgOverlayBlack, iconColor: .iconGraySubtler),
    loading: .new(backgroundColor: .bgOverlayBlack),
  );

  const GdsIconButtonType({
    required this.iconSize,
    required this.size,
    required this.enabled,
    required this.disabled,
    required this.loading,
  });

  final double iconSize;
  final GdsControlSize size;
  final GdsButtonStyle enabled;
  final GdsButtonStyle disabled;
  final GdsButtonStyle loading;
}
