import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook_components/widgetbook_components.dart';

const _sampleDescription = '소개글 2줄이 노출됩니다. 내용이 길지 않을 경우 한줄만 차지하게 해주세요, 넘어가면 이렇게 처리해주세요.';

@widgetbook.UseCase(
  name: 'default',
  type: GdsUserCard,
  path: '[component]/[card]',
)
Widget buildGdsUserCardUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'UserCard',
    description: '추천 유저 프로필, 검색 유저 프로필, 인기 태그 노출 카드에 사용하는 컴포넌트입니다.',
    children: [
      _buildPlaygroundSection(context),
      _buildVariantSection(),
    ],
  );
}

Widget _buildPlaygroundSection(BuildContext context) {
  final type = context.knobs.list<GdsUserCardType>(
    label: 'type',
    options: GdsUserCardType.values,
    initialOption: GdsUserCardType.defaultType,
    labelBuilder: (value) => value.displayName,
  );
  final nickname = context.knobs.string(label: 'nickname', initialValue: '체리마루');
  final followerCount = context.knobs.int.slider(label: 'followerCount', initialValue: 123, min: 0, max: 9999);
  final followingCount = context.knobs.int.slider(label: 'followingCount', initialValue: 32, min: 0, max: 9999);
  final actionLabel = context.knobs.string(label: 'actionLabel', initialValue: '팔로우');
  final description = context.knobs.string(label: 'description', initialValue: _sampleDescription);
  final tagLabel = context.knobs.string(label: 'tagLabel', initialValue: '나폴리탄 괴담');

  return WidgetbookPlayground(
    info: [
      'type: ${type.displayName}',
      if (type != GdsUserCardType.tagView) 'frame: ${GdsUserCard.defaultWidth.toInt()}px fixed',
      if (type == GdsUserCardType.tagView)
        'frame: ${GdsUserCard.tagViewWidth.toInt()}x${GdsUserCard.tagViewHeight.toInt()} fixed',
    ],
    child: Align(
      alignment: Alignment.centerLeft,
      child: _buildCard(
        type: type,
        nickname: nickname,
        followerCount: followerCount,
        followingCount: followingCount,
        actionLabel: actionLabel,
        description: description,
        tagLabel: tagLabel,
      ),
    ),
  );
}

Widget _buildVariantSection() {
  return WidgetbookSection(
    title: 'UserCard',
    children: [
      WidgetbookSubsection(
        title: 'variant',
        labels: const ['Default', 'Search', 'TagView'],
        content: const Wrap(
          spacing: 24,
          runSpacing: 24,
          crossAxisAlignment: WrapCrossAlignment.start,
          children: [
            _UserVariantCard(type: GdsUserCardType.defaultType),
            _UserVariantCard(type: GdsUserCardType.search),
            _UserVariantCard(type: GdsUserCardType.tagView),
          ],
        ),
      ),
    ],
  );
}

Widget _buildCard({
  required GdsUserCardType type,
  required String nickname,
  required int followerCount,
  required int followingCount,
  required String actionLabel,
  required String description,
  required String tagLabel,
}) {
  return GdsUserCard(
    type: type,
    nickname: nickname,
    profileImageUrl: null,
    coverImageUrl: null,
    followerCount: followerCount,
    followingCount: type == GdsUserCardType.defaultType ? followingCount : null,
    description: type == GdsUserCardType.search ? description : null,
    tagLabel: type == GdsUserCardType.tagView ? tagLabel : null,
    latestThumbnails: type == GdsUserCardType.defaultType
        ? const [
            GdsUserCardThumbnailData(imageUrl: ''),
            GdsUserCardThumbnailData(imageUrl: ''),
            GdsUserCardThumbnailData(imageUrl: ''),
          ]
        : const [],
    actionLabel: actionLabel,
    onActionPressed: () {},
  );
}

class _UserVariantCard extends StatelessWidget {
  const _UserVariantCard({required this.type});

  final GdsUserCardType type;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: GdsSpacing.spacing8,
      children: [
        Text(
          type.displayName,
          style: GdsTypography.caption1.copyWith(color: colors.text.graySubtle),
        ),
        _buildCard(
          type: type,
          nickname: type == GdsUserCardType.tagView ? 'Grimity' : '체리마루',
          followerCount: 123,
          followingCount: 32,
          actionLabel: '팔로우',
          description: _sampleDescription,
          tagLabel: '나폴리탄 괴담',
        ),
      ],
    );
  }
}
