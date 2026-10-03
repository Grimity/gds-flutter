import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

export 'theme/gds_dark_theme.dart';
export 'theme/gds_light_theme.dart';

/// 디자인 시스템에서 사용하는 테마를 정의하는 인터페이스.
abstract class GdsTheme {
  const new();

  factory light() = GdsLightTheme;
  factory dark() = GdsDarkTheme;

  /// 테마의 이름 혹은 식별자.
  String get name;

  /// 테마에 따른 시맨틱 색상.
  GdsSemanticColor get semantic;

  /// 기본 이미지에 표시할 플레이스홀더 이미지.
  ImageProvider get defaultPlaceholder;

  /// 프로필 이미지에 표시할 플레이스홀더 이미지.
  ImageProvider get profilePlaceholder;
}
