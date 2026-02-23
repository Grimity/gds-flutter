import 'package:gds_tokens/gds_tokens.dart';

/// Grimity Design System 레이아웃
///
/// ## 사용 예시
/// ```dart
/// GdsLayout.constraint.maxWidth
/// GdsLayout.mobile.margin
/// GdsLayout.desktop.lnb
/// ```
class GdsLayout {
  const GdsLayout._();

  static const constraint = GdsAtomicLayoutConstraint;
  static const mobile = GdsAtomicLayoutMobile;
  static const tablet = GdsAtomicLayoutTablet;
  static const tabletApp = GdsAtomicLayoutTabletApp;
  static const desktop = GdsAtomicLayoutDesktop;
}
