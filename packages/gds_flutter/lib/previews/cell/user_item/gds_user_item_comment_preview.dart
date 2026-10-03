import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:gds_flutter/previews/preview.dart';

/// [GdsUserItem.comment]에 대한 프리뷰 위젯.
class GdsUserItemCommentPreview extends PreviewWidget {
  final sizeControl = PreviewControl.select<GdsSize>(
    defaultValue: .xs,
    displayName: 'Size',
    values: const [.md, .xs],
  );

  final nicknameControl = PreviewControl.string(
    defaultValue: 'Nickname',
    displayName: 'Nickname',
  );

  final likeCountControl = PreviewControl.integer(
    defaultValue: 12,
    displayName: 'Like Count',
    minValue: 0,
  );

  final isWriterControl = PreviewControl.boolean(
    defaultValue: true,
    displayName: 'Is Writer',
  );

  final isReplyControl = PreviewControl.boolean(
    defaultValue: false,
    displayName: 'Is Reply',
  );

  final isLikedControl = PreviewControl.boolean(
    defaultValue: false,
    displayName: 'Is Like',
  );

  final contentControl = PreviewControl.string(
    defaultValue: '댓글 내용이 여기에 표시됩니다.',
    displayName: 'Content',
  );

  final mentionControl = PreviewControl.string(
    initialValue: 'Mention',
    displayName: 'Mention',
  );

  final profileUrlControl = PreviewControl.string(
    initialValue: previewProfileUrl,
    displayName: 'Profile URL',
  );

  final hoursAgoControl = PreviewControl.integer(
    defaultValue: 1,
    displayName: 'Hours Ago',
    minValue: 0,
  );

  @override
  String get displayName => 'Comment';

  @override
  List<String> get groups => ['Cell', 'User Item'];

  @override
  Widget build(BuildContext context) {
    final size = sizeControl.of(context);
    final nickname = nicknameControl.of(context);
    final likeCount = likeCountControl.of(context);
    final isWriter = isWriterControl.of(context);
    final isReply = isReplyControl.of(context);
    final isLiked = isLikedControl.of(context);
    final content = contentControl.of(context);
    final mention = mentionControl.of(context);
    final profileUrl = profileUrlControl.of(context);
    final hoursAgo = hoursAgoControl.of(context);

    return GdsUserItem.comment(
      size: size.value,
      nickname: nickname.value,
      likeCount: likeCount.value,
      isWriter: isWriter.value,
      isReply: isReply.value,
      isLiked: isLiked.value,
      content: content.value,
      mention: mention.mayBeValue,
      profile: profileUrl.mayBeValue?.networkImage,
      createdAt: DateTime.now().subtract(Duration(hours: hoursAgo.value)),
      onMenu: () => debugPrint('onMenu() called'),
      onLike: () => debugPrint('onLike() called'),
      onReply: () => debugPrint('onReply() called'),
    );
  }
}
