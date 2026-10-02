// dart format off

import 'package:gds_flutter/gds_flutter.dart';

/// 다크 테마에 대한 시맨틱 색상.
class GdsSemanticDartColor extends GdsSemanticColor {
  // Background
  @override get bgPrimary => GdsAtomicColor.gray100;
  @override get bgSecondary => GdsAtomicColor.gray90;
  @override get bgTertiary => GdsAtomicColor.gray70;
  @override get bgBlack => GdsAtomicColor.black;
  @override get bgOverlayBlack => GdsAtomicColor.black.opacity80;

  // Surface
  @override get surfaceBase => GdsAtomicColor.gray100;
  @override get surfaceWhite => GdsAtomicColor.white;
  @override get surfaceBlack => GdsAtomicColor.black;
  @override get surfaceInverse => GdsAtomicColor.white;
  @override get surfaceGrayBold => GdsAtomicColor.gray20;
  @override get surfaceGrayNormal => GdsAtomicColor.gray40;
  @override get surfaceGraySubtle => GdsAtomicColor.gray60;
  @override get surfaceGraySubtler => GdsAtomicColor.gray80;
  @override get surfaceGraySubtlest => GdsAtomicColor.gray90;
  @override get surfacePrimaryNormal => GdsAtomicColor.green70;
  @override get surfacePrimarySubtler => GdsAtomicColor.green80;
  @override get surfacePrimarySubtlest => GdsAtomicColor.green100;

  // Text
  @override get textWhite => GdsAtomicColor.white;
  @override get textBlack => GdsAtomicColor.black;
  @override get textInverse => GdsAtomicColor.gray90;
  @override get textGrayBold => GdsAtomicColor.gray20;
  @override get textGrayNormal => GdsAtomicColor.gray40;
  @override get textGraySubtle => GdsAtomicColor.gray60;
  @override get textGraySubtler => GdsAtomicColor.gray80;
  @override get textPrimaryNormal => GdsAtomicColor.green70;
  @override get textPrimarySubtler => GdsAtomicColor.green80;

  // Icon
  @override get iconWhite => GdsAtomicColor.white;
  @override get iconBase => GdsAtomicColor.white;
  @override get iconInverse => GdsAtomicColor.black;
  @override get iconGrayBold => GdsAtomicColor.gray20;
  @override get iconGrayNormal => GdsAtomicColor.gray40;
  @override get iconGraySubtle => GdsAtomicColor.gray60;
  @override get iconGraySubtler => GdsAtomicColor.gray80;
  @override get iconGraySubtlest => GdsAtomicColor.gray90;
  @override get iconPrimaryNormal => GdsAtomicColor.green70;
  @override get iconPrimarySubtler => GdsAtomicColor.green80;
  @override get iconPrimarySubtlest => GdsAtomicColor.green100;

  // Border
  @override get borderGrayBold => GdsAtomicColor.gray70;
  @override get borderGrayNormal => GdsAtomicColor.gray70;
  @override get borderGraySubtle => GdsAtomicColor.gray80;
  @override get borderGraySubtler => GdsAtomicColor.gray90;
  @override get borderPrimaryNormal => GdsAtomicColor.green70;
  @override get borderPrimarySubtler => GdsAtomicColor.green80;
  @override get borderPrimarySubtlest => GdsAtomicColor.green90;

  // Status
  @override get statusPositive => GdsAtomicColor.green50;
  @override get statusInfo => GdsAtomicColor.blue50;
  @override get statusNegative => GdsAtomicColor.red60;
  @override get statusCautionary => GdsAtomicColor.orange50;
  @override get statusNotification => GdsAtomicColor.red50;
  @override get statusRed => GdsAtomicColor.red70;

  // Graphic
  @override get graphicWhite => GdsAtomicColor.gray100; 
  @override get graphicPrimary => GdsAtomicColor.green50;
  @override get graphicBold => GdsAtomicColor.gray10;
  @override get graphicNormal => GdsAtomicColor.gray30;
  @override get graphicSubtle => GdsAtomicColor.gray50;
  @override get graphicSubtler => GdsAtomicColor.gray80;

  // Component
  @override get refreshLoading1 => GdsAtomicColor.gray90;
  @override get refreshLoading2 => GdsAtomicColor.gray80;
  @override get refreshLoading3 => GdsAtomicColor.gray70;
  @override get refreshLoading4 => GdsAtomicColor.gray60;
  @override get refreshLoading5 => GdsAtomicColor.gray50;
  @override get refreshLoading6 => GdsAtomicColor.gray40;
  @override get refreshLoading7 => GdsAtomicColor.gray30;
  @override get refreshLoading8 => GdsAtomicColor.gray20;
}

// dart format on
