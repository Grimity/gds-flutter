import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

export 'theme/gds_semantic_dark_color.dart';
export 'theme/gds_semantic_light_color.dart';

/// 특정 테마에 대응하는 시맨틱 색상을 정의하는 인터페이스.
abstract class GdsSemanticColor {
  const GdsSemanticColor();

  factory GdsSemanticColor.light() = GdsSemanticLightColor;
  factory GdsSemanticColor.dark() = GdsSemanticDartColor;

  // Background
  Color get bgPrimary;
  Color get bgSecondary;
  Color get bgTertiary;
  Color get bgBlack;
  Color get bgOverlayBlack;

  // Surface
  Color get surfaceBase;
  Color get surfaceWhite;
  Color get surfaceBlack;
  Color get surfaceInverse;
  Color get surfaceGrayBold;
  Color get surfaceGrayNormal;
  Color get surfaceGraySubtle;
  Color get surfaceGraySubtler;
  Color get surfaceGraySubtlest;
  Color get surfacePrimaryNormal;
  Color get surfacePrimarySubtler;
  Color get surfacePrimarySubtlest;

  // Text
  Color get textWhite;
  Color get textBlack;
  Color get textInverse;
  Color get textGrayBold;
  Color get textGrayNormal;
  Color get textGraySubtle;
  Color get textGraySubtler;
  Color get textPrimaryNormal;
  Color get textPrimarySubtler;

  // Icon
  Color get iconWhite;
  Color get iconBase;
  Color get iconInverse;
  Color get iconGrayBold;
  Color get iconGrayNormal;
  Color get iconGraySubtle;
  Color get iconGraySubtler;
  Color get iconGraySubtlest;
  Color get iconPrimaryNormal;
  Color get iconPrimarySubtler;
  Color get iconPrimarySubtlest;

  // Border
  Color get borderGrayBold;
  Color get borderGrayNormal;
  Color get borderGraySubtle;
  Color get borderGraySubtler;
  Color get borderPrimaryNormal;
  Color get borderPrimarySubtler;
  Color get borderPrimarySubtlest;

  // Status
  Color get statusPositive;
  Color get statusInfo;
  Color get statusNegative;
  Color get statusCautionary;
  Color get statusNotification;
  Color get statusRed;

  // Graphic
  Color get graphicWhite;
  Color get graphicPrimary;
  Color get graphicBold;
  Color get graphicNormal;
  Color get graphicSubtle;
  Color get graphicSubtler;

  // Layout
  Color get refreshLoading1;
  Color get refreshLoading2;
  Color get refreshLoading3;
  Color get refreshLoading4;
  Color get refreshLoading5;
  Color get refreshLoading6;
  Color get refreshLoading7;
  Color get refreshLoading8;

  /// [val]에 대응하는 현재 테마의 시맨틱 색상을 반환합니다.
  Color fromEnum(GdsColor val) => switch (val) {
    .bgPrimary => bgPrimary,
    .bgSecondary => bgSecondary,
    .bgTertiary => bgTertiary,
    .bgBlack => bgBlack,
    .bgOverlayBlack => bgOverlayBlack,
    .surfaceBase => surfaceBase,
    .surfaceWhite => surfaceWhite,
    .surfaceBlack => surfaceBlack,
    .surfaceInverse => surfaceInverse,
    .surfaceGrayBold => surfaceGrayBold,
    .surfaceGrayNormal => surfaceGrayNormal,
    .surfaceGraySubtle => surfaceGraySubtle,
    .surfaceGraySubtler => surfaceGraySubtler,
    .surfaceGraySubtlest => surfaceGraySubtlest,
    .surfacePrimaryNormal => surfacePrimaryNormal,
    .surfacePrimarySubtler => surfacePrimarySubtler,
    .surfacePrimarySubtlest => surfacePrimarySubtlest,
    .textWhite => textWhite,
    .textBlack => textBlack,
    .textInverse => textInverse,
    .textGrayBold => textGrayBold,
    .textGrayNormal => textGrayNormal,
    .textGraySubtle => textGraySubtle,
    .textGraySubtler => textGraySubtler,
    .textPrimaryNormal => textPrimaryNormal,
    .textPrimarySubtler => textPrimarySubtler,
    .iconWhite => iconWhite,
    .iconBase => iconBase,
    .iconInverse => iconInverse,
    .iconGrayBold => iconGrayBold,
    .iconGrayNormal => iconGrayNormal,
    .iconGraySubtle => iconGraySubtle,
    .iconGraySubtler => iconGraySubtler,
    .iconGraySubtlest => iconGraySubtlest,
    .iconPrimaryNormal => iconPrimaryNormal,
    .iconPrimarySubtler => iconPrimarySubtler,
    .iconPrimarySubtlest => iconPrimarySubtlest,
    .borderGrayBold => borderGrayBold,
    .borderGrayNormal => borderGrayNormal,
    .borderGraySubtle => borderGraySubtle,
    .borderGraySubtler => borderGraySubtler,
    .borderPrimaryNormal => borderPrimaryNormal,
    .borderPrimarySubtler => borderPrimarySubtler,
    .borderPrimarySubtlest => borderPrimarySubtlest,
    .statusPositive => statusPositive,
    .statusInfo => statusInfo,
    .statusNegative => statusNegative,
    .statusCautionary => statusCautionary,
    .statusNotification => statusNotification,
    .statusRed => statusRed,
    .graphicWhite => graphicWhite,
    .graphicPrimary => graphicPrimary,
    .graphicBold => graphicBold,
    .graphicNormal => graphicNormal,
    .graphicSubtle => graphicSubtle,
    .graphicSubtler => graphicSubtler,
    .refreshLoading1 => refreshLoading1,
    .refreshLoading2 => refreshLoading2,
    .refreshLoading3 => refreshLoading3,
    .refreshLoading4 => refreshLoading4,
    .refreshLoading5 => refreshLoading5,
    .refreshLoading6 => refreshLoading6,
    .refreshLoading7 => refreshLoading7,
    .refreshLoading8 => refreshLoading8,
    .transparent => GdsAtomicColor.transparent,
    .white => GdsAtomicColor.white,
    .black => GdsAtomicColor.black,
    .gray => GdsAtomicColor.gray,
    .lightGray => GdsAtomicColor.lightGray,
    .red => GdsAtomicColor.red,
    .orange => GdsAtomicColor.orange,
    .yellow => GdsAtomicColor.yellow,
    .green => GdsAtomicColor.green,
    .blue => GdsAtomicColor.blue,
    .deepBlue => GdsAtomicColor.deepBlue,
    .magenta => GdsAtomicColor.magenta,
    .purple => GdsAtomicColor.purple,
    .brown => GdsAtomicColor.brown,
    .mint => GdsAtomicColor.mint,
  };
}
