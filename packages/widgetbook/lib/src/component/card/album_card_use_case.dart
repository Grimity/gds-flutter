import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook_components/widgetbook_components.dart';

const _defaultTitle = 'Main title is here Main title is here Main title is here';
const _defaultNickname = 'Nickname';

@widgetbook.UseCase(
  name: 'default',
  type: GdsAlbumCard,
  path: '[component]/[card]',
)
Widget buildGdsAlbumCardUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'AlbumCard',
    description: 'Figma 기준 MainTitle / Check / Rank / Image / ImageUpload 변형을 포함하는 카드입니다. 타이틀은 모든 변형에서 1줄 말줄임 처리됩니다.',
    children: [
      _buildPlaygroundSection(context),
      const _AlbumVariantSection(),
    ],
  );
}

Widget _buildPlaygroundSection(BuildContext context) {
  final type = context.knobs.list<GdsAlbumCardType>(
    label: 'type',
    options: GdsAlbumCardType.values,
    initialOption: GdsAlbumCardType.mainTitle,
    labelBuilder: (value) => value.name,
  );
  final state = context.knobs.list<GdsAlbumCardState>(
    label: 'state',
    options: GdsAlbumCardState.values,
    initialOption: GdsAlbumCardState.defaultType,
    labelBuilder: (value) => value.name,
  );
  final imageSize = context.knobs.list<GdsAlbumCardImageSize>(
    label: 'imageSize',
    options: GdsAlbumCardImageSize.values,
    initialOption: GdsAlbumCardImageSize.large,
    labelBuilder: (value) => value.name,
  );
  final title = context.knobs.string(label: 'title', initialValue: _defaultTitle);
  final nickname = context.knobs.string(label: 'nickname', initialValue: _defaultNickname);
  final heartCount = context.knobs.int.input(label: 'heartCount', initialValue: 32);
  final viewCount = context.knobs.int.input(label: 'viewCount', initialValue: 123);
  final isLiked = context.knobs.boolean(label: 'isLiked', initialValue: false);
  final rank = context.knobs.int.slider(label: 'rank', min: 1, max: 4, initialValue: 1);
  final isImageType = type == GdsAlbumCardType.image || type == GdsAlbumCardType.imageUpload;
  final resolvedState = type == GdsAlbumCardType.imageUpload ? GdsAlbumCardState.defaultType : state;

  return WidgetbookPlayground(
    info: [
      'type: ${type.name}',
      'state: ${resolvedState.name}',
      if (isImageType) 'imageSize: ${imageSize.name}',
      'title: 1 line @fixed',
    ],
    child: Align(
      alignment: Alignment.centerLeft,
      child: GdsAlbumCard(
        imageUrl: '',
        title: switch (type) {
          GdsAlbumCardType.album || GdsAlbumCardType.imageUpload => null,
          _ => title,
        },
        nickname: switch (type) {
          GdsAlbumCardType.mainTitle || GdsAlbumCardType.check || GdsAlbumCardType.rank => nickname,
          _ => null,
        },
        heartCount: switch (type) {
          GdsAlbumCardType.mainTitle || GdsAlbumCardType.check || GdsAlbumCardType.rank => heartCount,
          _ => null,
        },
        viewCount: switch (type) {
          GdsAlbumCardType.mainTitle || GdsAlbumCardType.check || GdsAlbumCardType.rank => viewCount,
          _ => null,
        },
        state: resolvedState,
        type: type,
        imageSize: imageSize,
        rank: rank,
        isLiked: isLiked,
        albumBadgeText: 'N',
        onHeartTap: () {},
        onCloseTap: () {},
        onPrimaryBadgeTap: () {},
      ),
    ),
  );
}

class _AlbumVariantSection extends StatelessWidget {
  const _AlbumVariantSection();

  @override
  Widget build(BuildContext context) {
    return WidgetbookSection(
      title: 'AlbumCard',
      children: const [
        WidgetbookSubsection(
          title: 'variants',
          labels: ['MainTitle', 'Check', 'Rank', 'Image', 'ImageUpload'],
          content: _AlbumVariantGrid(),
        ),
        WidgetbookSubsection(
          title: 'image_upload x size',
          labels: ['fallback only', 'medium + large'],
          content: _ImageUploadSizeGrid(),
        ),
      ],
    );
  }
}

class _AlbumVariantGrid extends StatelessWidget {
  const _AlbumVariantGrid();

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final headerStyle = GdsTypography.caption1.copyWith(color: colors.text.graySubtle);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _VariantColumn(
            title: 'MainTitle',
            headerStyle: headerStyle,
            children: const [
              GdsAlbumCard(
                imageUrl: '',
                type: GdsAlbumCardType.mainTitle,
                title: _defaultTitle,
                nickname: _defaultNickname,
                heartCount: 32,
                viewCount: 123,
              ),
            ],
          ),
          const SizedBox(width: 24),
          _VariantColumn(
            title: 'Check',
            headerStyle: headerStyle,
            children: const [
              GdsAlbumCard(
                imageUrl: '',
                type: GdsAlbumCardType.check,
                state: GdsAlbumCardState.defaultType,
                title: _defaultTitle,
                nickname: _defaultNickname,
                heartCount: 32,
                viewCount: 123,
              ),
              SizedBox(height: 20),
              GdsAlbumCard(
                imageUrl: '',
                type: GdsAlbumCardType.check,
                state: GdsAlbumCardState.checked,
                title: _defaultTitle,
                nickname: _defaultNickname,
                heartCount: 32,
                viewCount: 123,
              ),
            ],
          ),
          const SizedBox(width: 24),
          _VariantColumn(
            title: 'Rank',
            headerStyle: headerStyle,
            children: const [
              GdsAlbumCard(
                imageUrl: '',
                type: GdsAlbumCardType.rank,
                rank: 1,
                title: _defaultTitle,
                nickname: _defaultNickname,
                heartCount: 32,
                viewCount: 123,
              ),
            ],
          ),
          const SizedBox(width: 24),
          _VariantColumn(
            title: 'Image',
            headerStyle: headerStyle,
            children: const [
              GdsAlbumCard(
                imageUrl: '',
                type: GdsAlbumCardType.image,
                imageSize: GdsAlbumCardImageSize.large,
                state: GdsAlbumCardState.defaultType,
                title: _defaultTitle,
              ),
              SizedBox(height: 20),
              GdsAlbumCard(
                imageUrl: '',
                type: GdsAlbumCardType.image,
                imageSize: GdsAlbumCardImageSize.large,
                state: GdsAlbumCardState.checked,
                title: _defaultTitle,
              ),
            ],
          ),
          const SizedBox(width: GdsSpacing.spacing24),
          _VariantColumn(
            title: 'ImageUpload',
            headerStyle: headerStyle,
            children: const [
              GdsAlbumCard(
                imageUrl: '',
                type: GdsAlbumCardType.imageUpload,
                imageSize: GdsAlbumCardImageSize.large,
                state: GdsAlbumCardState.defaultType,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _VariantColumn extends StatelessWidget {
  const _VariantColumn({
    required this.title,
    required this.headerStyle,
    required this.children,
  });

  final String title;
  final TextStyle headerStyle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: headerStyle),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }
}

class _ImageUploadSizeGrid extends StatelessWidget {
  const _ImageUploadSizeGrid();

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final sectionLabelStyle = GdsTypography.caption1.copyWith(color: colors.text.graySubtle);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _VariantColumn(
            title: 'ImageUpload / Medium (160)',
            headerStyle: sectionLabelStyle,
            children: [
              Text('fallback', style: sectionLabelStyle),
              const SizedBox(height: 8),
              const GdsAlbumCard(
                imageUrl: '',
                type: GdsAlbumCardType.imageUpload,
                imageSize: GdsAlbumCardImageSize.medium,
                state: GdsAlbumCardState.defaultType,
              ),
            ],
          ),
          const SizedBox(width: 24),
          _VariantColumn(
            title: 'ImageUpload / Large (200)',
            headerStyle: sectionLabelStyle,
            children: [
              Text('fallback', style: sectionLabelStyle),
              const SizedBox(height: 8),
              const GdsAlbumCard(
                imageUrl: '',
                type: GdsAlbumCardType.imageUpload,
                imageSize: GdsAlbumCardImageSize.large,
                state: GdsAlbumCardState.defaultType,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
