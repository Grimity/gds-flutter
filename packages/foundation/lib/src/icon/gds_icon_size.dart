part of '../gds_icon.dart';

/// GdsIcon에서 사용하는 아이콘 사이즈
///
/// ## 사용 가능한 사이즈
/// - [v12]: 12px
/// - [v16]: 16px
/// - [v20]: 20px
/// - [v24]: 24px (기본값)
/// - [v32]: 32px
///
/// ## 사용 예시
/// ```dart
/// GdsIcon.heartFill.build(
///   width: GdsIconSize.v16,
///   height: GdsIconSize.v16,
/// )
/// ```
class GdsIconSize {
  const GdsIconSize._();

  static const double v12 = GdsAtomicIconSize.v12;
  static const double v16 = GdsAtomicIconSize.v16;
  static const double v20 = GdsAtomicIconSize.v20;
  static const double v24 = GdsAtomicIconSize.v24;
  static const double v32 = GdsAtomicIconSize.v32;

  static const double defaultSize = GdsAtomicIconSize.v24;
}
