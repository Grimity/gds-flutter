import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook_components/widgetbook_components.dart';

const _samplePhotoUrl = 'https://picsum.photos/seed/grimity-avatar/400/400';

@widgetbook.UseCase(
  name: 'default',
  type: GdsPersonAvatar,
  path: '[component]/[avatar]',
)
Widget buildGdsPersonAvatarUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'PersonAvatar',
    description: '사람 프로필 아바타 컴포넌트입니다. photo/default 타입과 7개 사이즈를 지원합니다.',
    children: [
      _buildPlayground(context),
      _buildDemonstrationSection(context),
    ],
  );
}

Widget _buildPlayground(BuildContext context) {
  final type = context.knobs.list<_AvatarPreviewType>(
    label: 'type',
    options: _AvatarPreviewType.values,
    initialOption: _AvatarPreviewType.photo,
    labelBuilder: (t) => t.label,
  );
  final size = context.knobs.list<GdsAvatarSize>(
    label: 'size',
    options: GdsAvatarSize.values,
    labelBuilder: (s) => s.name,
  );
  final imageUrl = context.knobs.string(label: 'imageUrl', initialValue: _samplePhotoUrl);

  final resolvedImageUrl = type.resolveImageUrl(imageUrl);

  return WidgetbookPlayground(
    info: [
      'type: ${type.label}',
      'size: ${size.name}',
      'dimension: ${size.value.toInt()}x${size.value.toInt()}',
    ],
    child: GdsPersonAvatar(
      size: size,
      imageUrl: resolvedImageUrl,
    ),
  );
}

Widget _buildDemonstrationSection(BuildContext context) {
  return WidgetbookSection(
    title: 'PersonAvatar',
    children: [
      WidgetbookSubsection(
        title: 'photo',
        labels: ['${GdsAvatarSize.values.length} sizes'],
        content: const _AvatarSizeList(type: _AvatarPreviewType.photo),
      ),
      WidgetbookSubsection(
        title: 'default',
        labels: ['${GdsAvatarSize.values.length} sizes'],
        content: const _AvatarSizeList(type: _AvatarPreviewType.defaultValue),
      ),
    ],
  );
}

enum _AvatarPreviewType {
  photo,
  defaultValue;

  String get label => switch (this) {
    _AvatarPreviewType.photo => 'photo',
    _AvatarPreviewType.defaultValue => 'default',
  };

  String? resolveImageUrl(String photoUrl) => switch (this) {
    _AvatarPreviewType.photo => photoUrl,
    _AvatarPreviewType.defaultValue => null,
  };
}

class _AvatarSizeList extends StatelessWidget {
  const _AvatarSizeList({required this.type});

  final _AvatarPreviewType type;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final labelStyle = GdsTypography.caption1.copyWith(color: colors.text.graySubtle);
    final dimensionStyle = GdsTypography.caption1.copyWith(color: colors.text.grayNormal);

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        for (final size in GdsAvatarSize.values)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(size.name, style: labelStyle),
              Text('${size.value.toInt()}x${size.value.toInt()}', style: dimensionStyle),
              const SizedBox(height: 4),
              GdsPersonAvatar(
                size: size,
                imageUrl: type.resolveImageUrl(_samplePhotoUrl),
              ),
            ],
          ),
      ],
    );
  }
}
