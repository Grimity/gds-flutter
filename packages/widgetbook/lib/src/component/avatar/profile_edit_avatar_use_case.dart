import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook_components/widgetbook_components.dart';

const _sampleImageUrl = 'https://picsum.photos/seed/profile-edit-avatar/400/400';

enum _ProfileEditAvatarSize {
  xl,
  ml;

  String get label => switch (this) {
    _ProfileEditAvatarSize.xl => 'xl',
    _ProfileEditAvatarSize.ml => 'ml',
  };

  String get dimension => switch (this) {
    _ProfileEditAvatarSize.xl => '80x80',
    _ProfileEditAvatarSize.ml => '48x48',
  };
}

@widgetbook.UseCase(
  name: 'default',
  type: GdsProfileEditAvatar,
  path: '[component]/[avatar]',
)
Widget buildGdsProfileEditAvatarUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'ProfileEditAvatar',
    description: '프로필 편집 아바타 컴포넌트입니다. xl은 편집 버튼이 표시되고, ml은 아바타만 표시됩니다.',
    children: [
      _buildPlayground(context),
      _buildDemonstrationSection(context),
    ],
  );
}

Widget _buildPlayground(BuildContext context) {
  final size = context.knobs.list<_ProfileEditAvatarSize>(
    label: 'size',
    options: _ProfileEditAvatarSize.values,
    initialOption: _ProfileEditAvatarSize.xl,
    labelBuilder: (value) => value.label,
  );
  final imageUrl = context.knobs.string(
    label: 'imageUrl',
    initialValue: _sampleImageUrl,
  );

  return WidgetbookPlayground(
    info: [
      'type: edit',
      'size: ${size.label}',
      'dimension: ${size.dimension}',
      'editButton: ${size == _ProfileEditAvatarSize.xl ? 'visible' : 'hidden'}',
    ],
    child: _buildAvatar(size: size, imageUrl: imageUrl),
  );
}

Widget _buildDemonstrationSection(BuildContext context) {
  final colors = context.gdsColors;
  final labelStyle = GdsTypography.caption1.copyWith(color: colors.text.graySubtle);

  return WidgetbookSection(
    title: 'ProfileEdit',
    children: [
      WidgetbookSubsection(
        title: 'edit × size',
        labels: const ['xl', 'ml'],
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final size in _ProfileEditAvatarSize.values)
              Padding(
                padding: const EdgeInsets.only(right: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(size.label, style: labelStyle),
                    Text(size.dimension, style: labelStyle),
                    const SizedBox(height: 12),
                    _buildAvatar(size: size, imageUrl: _sampleImageUrl),
                  ],
                ),
              ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildAvatar({
  required _ProfileEditAvatarSize size,
  required String imageUrl,
}) {
  return switch (size) {
    _ProfileEditAvatarSize.xl => GdsProfileEditAvatar.xl(
      imageUrl: imageUrl,
      onTap: () => debugPrint('GdsProfileEditAvatar.xl edit tapped'),
    ),
    _ProfileEditAvatarSize.ml => GdsProfileEditAvatar.ml(
      imageUrl: imageUrl,
      onTap: () => debugPrint('GdsProfileEditAvatar.ml edit tapped'),
    ),
  };
}
