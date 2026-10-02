import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:gds_flutter/previews/preview.dart';

/// [GdsUserItem.follow]에 대한 프리뷰 위젯.
class GdsUserItemFollowPreview extends PreviewWidget {
  final nicknameControl = PreviewControl.string(
    defaultValue: 'Nickname',
    displayName: 'Nickname',
  );

  final profileUrlControl = PreviewControl.string(
    initialValue: previewProfileUrl,
    displayName: 'Profile URL',
  );

  final followerCountControl = PreviewControl.integer(
    defaultValue: 1234,
    displayName: 'Follower Count',
    minValue: 0,
  );

  final followingCountControl = PreviewControl.integer(
    defaultValue: 567,
    displayName: 'Following Count',
    minValue: 0,
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
  String get displayName => 'Follow';

  @override
  List<String> get groups => ['Cell', 'User Item'];

  @override
  Widget build(BuildContext context) {
    final nickname = nicknameControl.of(context);
    final profileUrl = profileUrlControl.of(context);
    final followerCount = followerCountControl.of(context);
    final followingCount = followingCountControl.of(context);
    final buttonType = buttonTypeControl.of(context);
    final buttonCount = buttonCountControl.of(context);

    final actions = List.generate(buttonCount.value, (_) {
      final type = buttonType.value;

      return GdsTextButtonAction(
        type: type,
        variant: type.supportsVariant ? .primary : null,
        label: 'Label',
        onTap: () => debugPrint('Button onTap() called'),
      );
    });

    return GdsUserItem.follow(
      followerCount: followerCount.value,
      followingCount: followingCount.value,
      nickname: nickname.value,
      profileUrl: profileUrl.mayBeValue,
      onUser: () => debugPrint('onUser() called'),
      actions: actions,
    );
  }
}
