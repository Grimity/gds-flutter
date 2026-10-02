import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsInput.community]에 대한 프리뷰 위젯.
class GdsCommunityInputPreview extends PreviewWidget {
  final userNameControl = PreviewControl.string(displayName: 'User Name');

  @override
  String get displayName => 'Input · Community';

  @override
  List<String> get groups => ['Input'];

  @override
  Widget build(BuildContext context) {
    final userName = userNameControl.of(context);

    return GdsInput.community(
      userName: userName.mayBeValue,
      field: .new(placeholder: '댓글 입력'),
      button: .new(
        onTap: () => debugPrint('onTap() called'),
        label: '등록',
      ),
    );
  }
}
