import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:gds_flutter/previews/preview.dart';

/// [GdsTopNavigation.dm]에 대한 프리뷰 위젯.
class GdsDmTopNavigationPreview extends PreviewWidget {
  final nicknameControl = PreviewControl.string(
    defaultValue: 'Nickname',
    displayName: 'Nickname',
  );

  final handleControl = PreviewControl.string(
    defaultValue: 'Handle',
    displayName: 'Handle',
  );

  final profileUrlControl = PreviewControl.string(
    initialValue: previewProfileUrl,
    displayName: 'Profile URL',
  );

  @override
  String get displayName => 'DM';

  @override
  List<String> get groups => ['Navigation', 'Top Navigation'];

  @override
  Widget build(BuildContext context) {
    final nickname = nicknameControl.of(context);
    final handle = handleControl.of(context);
    final profileUrl = profileUrlControl.of(context);

    return GdsTopNavigation.dm(
      onBack: () => debugPrint('onBack() called'),
      onUser: () => debugPrint('onUser() called'),
      onExit: () => debugPrint('onExit() called'),
      onReport: () => debugPrint('onReport() called'),
      nickname: nickname.value,
      handle: handle.value,
      profileUrl: profileUrl.mayBeValue,
    );
  }
}
