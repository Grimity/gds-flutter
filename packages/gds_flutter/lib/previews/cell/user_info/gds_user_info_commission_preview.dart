import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/components/cell/gds_user_info.dart';

/// [GdsUserInfo.commission] preview widget.
class GdsUserInfoCommissionPreview extends PreviewWidget {
  final nicknameControl = PreviewControl.string(
    defaultValue: 'Nickname',
    displayName: 'Nickname',
  );

  final priceCountControl = PreviewControl.integer(
    defaultValue: 100000,
    displayName: 'Price Count',
    minValue: 0,
  );

  @override
  String get displayName => 'Commission';

  @override
  List<String> get groups => ['Cell', 'User Info'];

  @override
  Widget build(BuildContext context) {
    return GdsUserInfo.commission(
      nickname: nicknameControl.of(context).value,
      priceCount: priceCountControl.of(context).value,
    );
  }
}
