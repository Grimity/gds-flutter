import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:gds_flutter/previews/preview.dart';

/// [GdsUserItem.radio]에 대한 프리뷰 위젯.
class GdsUserItemRadioPreview extends PreviewWidget {
  final nicknameControl = PreviewControl.string(
    defaultValue: 'Nickname',
    displayName: 'Nickname',
  );

  final handleControl = PreviewControl.string(
    initialValue: 'handle',
    displayName: 'Handle',
  );

  final profileUrlControl = PreviewControl.string(
    initialValue: previewProfileUrl,
    displayName: 'Profile URL',
  );

  final valueControl = PreviewControl.boolean(
    defaultValue: false,
    displayName: 'Value',
  );

  @override
  String get displayName => 'Radio';

  @override
  List<String> get groups => ['Cell', 'User Item'];

  @override
  Widget build(BuildContext context) {
    final nickname = nicknameControl.of(context);
    final handle = handleControl.of(context);
    final profileUrl = profileUrlControl.of(context);
    final value = valueControl.of(context);

    return GdsUserItem.radio(
      value: value.value,
      nickname: nickname.value,
      handle: handle.mayBeValue,
      profileUrl: profileUrl.mayBeValue,
      onTap: () => value.value = !value.value,
    );
  }
}
