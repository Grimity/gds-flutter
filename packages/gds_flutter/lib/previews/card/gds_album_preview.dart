import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:gds_flutter/previews/preview.dart';

/// [GdsAlbum] preview widget.
class GdsAlbumPreview extends PreviewWidget {
  final imageUrlControl = PreviewControl.string(
    initialValue: previewProfileUrl,
    displayName: 'Image URL',
  );

  final titleControl = PreviewControl.string(
    defaultValue: 'Main title here',
    displayName: 'Title',
  );

  final nicknameControl = PreviewControl.string(
    defaultValue: 'Nickname',
    displayName: 'Nickname',
  );

  final likeCountControl = PreviewControl.integer(
    defaultValue: 1234,
    displayName: 'Like Count',
    minValue: 0,
  );

  final viewCountControl = PreviewControl.integer(
    defaultValue: 5678,
    displayName: 'View Count',
    minValue: 0,
  );

  final showLikeControl = PreviewControl.boolean(
    defaultValue: true,
    displayName: 'Show Like',
  );

  final likeControl = PreviewControl.boolean(
    defaultValue: false,
    displayName: 'Like',
  );

  final rankControl = PreviewControl.integer(
    defaultValue: 0,
    displayName: 'Rank',
    minValue: 0,
    maxValue: 4,
  );

  final showCheckedControl = PreviewControl.boolean(
    defaultValue: false,
    displayName: 'Show Checked',
  );

  final checkedControl = PreviewControl.boolean(
    defaultValue: false,
    displayName: 'Checked',
  );

  @override
  String get displayName => 'Album';

  @override
  List<String> get groups => ['Card'];

  @override
  Widget build(BuildContext context) {
    final imageUrl = imageUrlControl.of(context);
    final title = titleControl.of(context);
    final nickname = nicknameControl.of(context);
    final likeCount = likeCountControl.of(context);
    final viewCount = viewCountControl.of(context);
    final showLike = showLikeControl.of(context);
    final like = likeControl.of(context);
    final rank = rankControl.of(context);
    final showChecked = showCheckedControl.of(context);
    final checked = checkedControl.of(context);

    return GdsAlbum(
      image: imageUrl.mayBeValue?.networkImage,
      title: title.value,
      nickname: nickname.value,
      likeCount: likeCount.value,
      viewCount: viewCount.value,
      rank: rank.value,
      like: showLike.value ? like.value : null,
      checked: showChecked.value ? checked.value : null,
      onTap: () => debugPrint('onTap() called'),
      onLike: showLike.value ? like.setter : null,
    );
  }
}
