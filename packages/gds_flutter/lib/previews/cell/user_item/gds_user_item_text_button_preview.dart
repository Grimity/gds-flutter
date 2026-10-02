import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:gds_flutter/previews/preview.dart';

/// [GdsUserItem.textButton]에 대한 프리뷰 위젯.
class GdsUserItemTextButtonPreview extends PreviewWidget {
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

  final buttonTypeControl = PreviewControl.select<GdsTextButtonType>(
    defaultValue: .outlined,
    displayName: 'Button Type',
    values: GdsTextButtonType.values,
  );

  final buttonCountControl = PreviewControl.integer(
    defaultValue: 1,
    displayName: 'Button Count',
    minValue: 0,
    maxValue: 2,
  );

  @override
  String get displayName => 'Text Button';

  @override
  List<String> get groups => ['Cell', 'User Item'];

  @override
  Widget build(BuildContext context) {
    final nickname = nicknameControl.of(context);
    final handle = handleControl.of(context);
    final profileUrl = profileUrlControl.of(context);
    final buttonType = buttonTypeControl.of(context);
    final buttonCount = buttonCountControl.of(context);

    final actions = List.generate(buttonCount.value, (index) {
      final type = buttonType.value;

      return GdsTextButtonAction(
        type: type,
        variant: type.supportsVariant ? .primary : null,
        label: 'Label',
        onTap: () => debugPrint('Button onTap() called'),
      );
    });

    return GdsUserItem.textButton(
      nickname: nickname.value,
      handle: handle.mayBeValue,
      profileUrl: profileUrl.mayBeValue,
      onUser: () => debugPrint('onUser() called'),
      actions: actions,
    );
  }
}
