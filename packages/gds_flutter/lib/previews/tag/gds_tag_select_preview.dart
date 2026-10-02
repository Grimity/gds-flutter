import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsTagSelect]에 대한 프리뷰 위젯.
class GdsTagSelectPreview extends PreviewWidget {
  final sizeControl = PreviewControl.select<GdsSize>(
    defaultValue: .md,
    displayName: 'Size',
    values: const [.md, .xs],
  );

  final tagsControl = PreviewControl.string(
    defaultValue: '일러스트, 캐릭터, 드로잉',
    displayName: 'Tags',
  );

  @override
  String get displayName => 'Tag Select';

  @override
  List<String> get groups => ['Tag'];

  @override
  Widget build(BuildContext context) {
    final size = sizeControl.of(context);
    final tags = tagsControl.of(context);
    final tagList = tags.value.split(',').map((tag) => tag.trim()).where((tag) => tag.isNotEmpty).toList();

    void setTags(VoidCallback callback) {
      callback();
      tags.value = tagList.join(', ');
    }

    return GdsTagSelect(
      size: size.value,
      tags: tagList,
      onAdded: (value) {
        debugPrint('onChanged($value) called');
        setTags(() => tagList.add(value));
      },
      onRemoved: (value) {
        debugPrint('onRemoved($value) called');
        setTags(() => tagList.remove(value));
      },
    );
  }
}
