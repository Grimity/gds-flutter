import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsUserItem.commentDeleted]에 대한 프리뷰 위젯.
class GdsUserItemCommentDeletedPreview extends PreviewWidget {
  @override
  String get displayName => 'Comment Deleted';

  @override
  List<String> get groups => ['Cell', 'User Item'];

  @override
  Widget build(BuildContext context) {
    return GdsUserItem.commentDeleted();
  }
}
