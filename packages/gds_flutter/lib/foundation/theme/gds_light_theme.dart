import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 라이트 모드에 사용할 테마.
class GdsLightTheme extends GdsTheme {
  const GdsLightTheme();

  @override
  String get name => 'light';

  @override
  GdsSemanticColor get semantic => .light();

  @override
  ImageProvider get defaultPlaceholder => AssetImage(
    'assets/images/placeholder/light.png',
    package: 'gds_flutter',
  );

  @override
  ImageProvider get profilePlaceholder => AssetImage(
    'assets/images/placeholder/profile/light.png',
    package: 'gds_flutter',
  );
}
