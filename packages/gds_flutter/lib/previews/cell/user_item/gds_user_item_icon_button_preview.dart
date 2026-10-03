import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:gds_flutter/previews/preview.dart';

/// [GdsUserItem.iconButton]에 대한 프리뷰 위젯.
class GdsUserItemIconButtonPreview extends PreviewWidget {
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

  final iconButtonCountControl = PreviewControl.integer(
    defaultValue: 1,
    displayName: 'Icon Button Count',
    minValue: 0,
    maxValue: 2,
  );

  final iconControl = PreviewControl.select<GdsIcon>(
    defaultValue: .blank,
    displayName: 'Icon',
    values: GdsIcon.values,
  );

  @override
  String get displayName => 'Icon Button';

  @override
  List<String> get groups => ['Cell', 'User Item'];

  @override
  Widget build(BuildContext context) {
    final nickname = nicknameControl.of(context);
    final handle = handleControl.of(context);
    final profileUrl = profileUrlControl.of(context);
    final iconButtonCount = iconButtonCountControl.of(context);
    final icon = iconControl.of(context);

    final actions = List.generate(iconButtonCount.value, (index) {
      return GdsIconButtonAction(
        icon: icon.value,
        onTap: () => debugPrint('GdsIconButtonAction.onTap() called with index: $index'),
      );
    });

    return GdsUserItem.iconButton(
      nickname: nickname.value,
      handle: handle.mayBeValue,
      profile: profileUrl.mayBeValue?.networkImage,
      onUser: () => debugPrint('Profile onTap() called'),
      actions: actions,
    );
  }
}
