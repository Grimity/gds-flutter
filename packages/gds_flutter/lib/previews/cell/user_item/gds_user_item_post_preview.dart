import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:gds_flutter/previews/preview.dart';

/// [GdsUserItem.post] preview widget.
class GdsUserItemPostPreview extends PreviewWidget {
  final typeControl = PreviewControl.string(
    defaultValue: '자유 게시판',
    displayName: 'Type',
  );

  final titleControl = PreviewControl.string(
    defaultValue: '게시글 제목이 여기에 표시됩니다.',
    displayName: 'Title',
  );

  final hoursAgoControl = PreviewControl.integer(
    defaultValue: 1,
    displayName: 'Hours Ago',
    minValue: 0,
  );

  final contentControl = PreviewControl.string(
    initialValue: '게시글 내용의 일부가 여기에 표시됩니다.',
    displayName: 'Content',
  );

  final nicknameControl = PreviewControl.string(
    initialValue: 'Nickname',
    displayName: 'Nickname',
  );

  final viewCountControl = PreviewControl.integer(
    initialValue: 1234,
    displayName: 'View Count',
    minValue: 0,
  );

  final commentCountControl = PreviewControl.integer(
    initialValue: 12,
    displayName: 'Comment Count',
    minValue: 0,
  );

  final likeControl = PreviewControl.boolean(
    defaultValue: false,
    displayName: 'Like',
  );

  final onLikeControl = PreviewControl.boolean(
    defaultValue: true,
    displayName: 'On Like',
  );

  final showImageControl = PreviewControl.boolean(
    defaultValue: false,
    displayName: 'Show Image',
  );

  final imageUrlControl = PreviewControl.string(
    initialValue: previewProfileUrl,
    displayName: 'Image URL',
  );

  final chipVariantControl = PreviewControl.select<GdsChipVariant>(
    defaultValue: .assistive,
    displayName: 'Chip Variant',
    values: GdsChipVariant.values,
  );

  @override
  String get displayName => 'Post';

  @override
  List<String> get groups => ['Cell', 'User Item'];

  @override
  Widget build(BuildContext context) {
    final type = typeControl.of(context);
    final title = titleControl.of(context);
    final hoursAgo = hoursAgoControl.of(context);
    final content = contentControl.of(context);
    final nickname = nicknameControl.of(context);
    final viewCount = viewCountControl.of(context);
    final commentCount = commentCountControl.of(context);
    final like = likeControl.of(context);
    final onLike = onLikeControl.of(context);
    final showImage = showImageControl.of(context);
    final imageUrl = imageUrlControl.of(context);
    final chipVariant = chipVariantControl.of(context);

    return GdsUserItem.post(
      type: type.value,
      title: title.value,
      createdAt: DateTime.now().subtract(Duration(hours: hoursAgo.value)),
      content: content.mayBeValue,
      nickname: nickname.mayBeValue,
      viewCount: viewCount.mayBeValue,
      commentCount: commentCount.mayBeValue,
      like: like.value,
      showImage: showImage.value,
      image: imageUrl.mayBeValue?.networkImage,
      chipVariant: chipVariant.value,
      onTap: () => debugPrint('onTap() called'),
      onLike: onLike.value ? like.toogle : null,
    );
  }
}
