import 'package:gds_tokens/gds_tokens.dart';

/// Grimity Design System 스크린
///
/// ## 사용 예시
/// ```dart
/// GdsScreen.artboard.webDesktop
/// GdsScreen.breakpoint.sm
/// ```
class GdsScreen {
  const GdsScreen._();

  static const artboard = GdsAtomicScreenArtboard;
  static const breakpoint = GdsAtomicScreenBreakpoint;

  static const double tableMinWidth = GdsAtomicScreenBreakpoint.sm;
}
