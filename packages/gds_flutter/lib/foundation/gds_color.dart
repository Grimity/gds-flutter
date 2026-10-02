import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// SVG 요소 ID에 적용할 디자인 시스템 색상 맵.
typedef GdsColorMap = Map<String, GdsColor>;

/// 디자인 시스템에서 사용하는 시맨틱 색상을 나타내는 유형.
enum GdsColor {
  // Background
  bgPrimary,
  bgSecondary,
  bgTertiary,
  bgBlack,
  bgOverlayBlack,

  // Surface
  surfaceBase,
  surfaceWhite,
  surfaceBlack,
  surfaceInverse,
  surfaceGrayBold,
  surfaceGrayNormal,
  surfaceGraySubtle,
  surfaceGraySubtler,
  surfaceGraySubtlest,
  surfacePrimaryNormal,
  surfacePrimarySubtler,
  surfacePrimarySubtlest,

  // Text
  textWhite,
  textBlack,
  textInverse,
  textGrayBold,
  textGrayNormal,
  textGraySubtle,
  textGraySubtler,
  textPrimaryNormal,
  textPrimarySubtler,

  // Icon
  iconWhite,
  iconBase,
  iconInverse,
  iconGrayBold,
  iconGrayNormal,
  iconGraySubtle,
  iconGraySubtler,
  iconGraySubtlest,
  iconPrimaryNormal,
  iconPrimarySubtler,
  iconPrimarySubtlest,

  // Border
  borderGrayBold,
  borderGrayNormal,
  borderGraySubtle,
  borderGraySubtler,
  borderPrimaryNormal,
  borderPrimarySubtler,
  borderPrimarySubtlest,

  // Status
  statusPositive,
  statusInfo,
  statusNegative,
  statusCautionary,
  statusNotification,
  statusRed,

  // Graphic
  graphicWhite,
  graphicPrimary,
  graphicBold,
  graphicNormal,
  graphicSubtle,
  graphicSubtler,

  // Component
  refreshLoading1,
  refreshLoading2,
  refreshLoading3,
  refreshLoading4,
  refreshLoading5,
  refreshLoading6,
  refreshLoading7,
  refreshLoading8,

  transparent,
  white,
  black,
  gray,
  lightGray,
  red,
  orange,
  yellow,
  green,
  blue,
  deepBlue,
  magenta,
  purple,
  brown,
  mint;

  /// 현재 테마 기준의 색상 인스턴스를 반환합니다.
  Color of(BuildContext context) => context.theme.semantic.fromEnum(this);

  /// 주어진 이름에 해당하는 디자인 시스템 색상을 반환합니다.
  static GdsColor fromName(String name) => GdsColor.values.byName(name);
}
