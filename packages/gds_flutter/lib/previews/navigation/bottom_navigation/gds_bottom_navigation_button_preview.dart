import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsBottomNavigationButton]에 대한 프리뷰 위젯.
class GdsBottomNavigationPreview extends PreviewWidget {
  @override
  String get displayName => 'Button';

  @override
  List<String> get groups => ['Navigation', 'Bottom Navigation'];

  @override
  Widget build(BuildContext context) {
    return GdsBottomNavigationButton(
      onTap: () => debugPrint('onTap() called'),
    );
  }
}
