// dart format off

import 'package:gds_flutter/gds_flutter.dart';

/// 라이트 테마에 대한 시맨틱 색상.
class GdsSemanticLightColor extends GdsSemanticColor {
  // Background
  @override get bgPrimary => GdsAtomicColor.white;
  @override get bgSecondary => GdsAtomicColor.gray10;
  @override get bgTertiary => GdsAtomicColor.gray30;
  @override get bgBlack => GdsAtomicColor.black;
  @override get bgOverlayBlack => GdsAtomicColor.black.opacity40;

  // Surface
  @override get surfaceBase => GdsAtomicColor.white;
  @override get surfaceWhite => GdsAtomicColor.white;
  @override get surfaceBlack => GdsAtomicColor.black;
  @override get surfaceInverse => GdsAtomicColor.gray100;
  @override get surfaceGrayBold => GdsAtomicColor.gray80;
  @override get surfaceGrayNormal => GdsAtomicColor.gray60;
  @override get surfaceGraySubtle => GdsAtomicColor.gray40;
  @override get surfaceGraySubtler => GdsAtomicColor.gray20;
  @override get surfaceGraySubtlest => GdsAtomicColor.gray10;
  @override get surfacePrimaryNormal => GdsAtomicColor.green60;
  @override get surfacePrimarySubtler => GdsAtomicColor.green30;
  @override get surfacePrimarySubtlest => GdsAtomicColor.green10;

  // Text
  @override get textWhite => GdsAtomicColor.white;
  @override get textBlack => GdsAtomicColor.black;
  @override get textInverse => GdsAtomicColor.white;
  @override get textGrayBold => GdsAtomicColor.gray90;
  @override get textGrayNormal => GdsAtomicColor.gray70;
  @override get textGraySubtle => GdsAtomicColor.gray50;
  @override get textGraySubtler => GdsAtomicColor.gray30;
  @override get textPrimaryNormal => GdsAtomicColor.green60;
  @override get textPrimarySubtler => GdsAtomicColor.green30;

  // Icon
  @override get iconWhite => GdsAtomicColor.white;
  @override get iconBase => GdsAtomicColor.black;
  @override get iconInverse => GdsAtomicColor.white;
  @override get iconGrayBold => GdsAtomicColor.gray90;
  @override get iconGrayNormal => GdsAtomicColor.gray70;
  @override get iconGraySubtle => GdsAtomicColor.gray50;
  @override get iconGraySubtler => GdsAtomicColor.gray30;
  @override get iconGraySubtlest => GdsAtomicColor.gray20;
  @override get iconPrimaryNormal => GdsAtomicColor.green60;
  @override get iconPrimarySubtler => GdsAtomicColor.green30;
  @override get iconPrimarySubtlest => GdsAtomicColor.green10;

  // Border
  @override get borderGrayBold => GdsAtomicColor.gray40;
  @override get borderGrayNormal => GdsAtomicColor.gray40;
  @override get borderGraySubtle => GdsAtomicColor.gray30;
  @override get borderGraySubtler => GdsAtomicColor.gray20;
  @override get borderPrimaryNormal => GdsAtomicColor.green60;
  @override get borderPrimarySubtler => GdsAtomicColor.green30;
  @override get borderPrimarySubtlest => GdsAtomicColor.green10;

  // Status
  @override get statusPositive => GdsAtomicColor.green60;
  @override get statusInfo => GdsAtomicColor.blue60;
  @override get statusNegative => GdsAtomicColor.red70;
  @override get statusCautionary => GdsAtomicColor.orange60;
  @override get statusNotification => GdsAtomicColor.red60;
  @override get statusRed => GdsAtomicColor.red80;

  // Graphic
  @override get graphicWhite => GdsAtomicColor.white;
  @override get graphicPrimary => GdsAtomicColor.green60;
  @override get graphicBold => GdsAtomicColor.gray90;
  @override get graphicNormal => GdsAtomicColor.gray80;
  @override get graphicSubtle => GdsAtomicColor.gray60;
  @override get graphicSubtler => GdsAtomicColor.gray40;

  // Layout
  @override get refreshLoading1 => GdsAtomicColor.gray80;
  @override get refreshLoading2 => GdsAtomicColor.gray70;
  @override get refreshLoading3 => GdsAtomicColor.gray60;
  @override get refreshLoading4 => GdsAtomicColor.gray50;
  @override get refreshLoading5 => GdsAtomicColor.gray40;
  @override get refreshLoading6 => GdsAtomicColor.gray30;
  @override get refreshLoading7 => GdsAtomicColor.gray20;
  @override get refreshLoading8 => GdsAtomicColor.gray10;
}

// dart format on
