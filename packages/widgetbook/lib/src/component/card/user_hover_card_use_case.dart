import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook_components/widgetbook_components.dart';

const _sampleBio = '소개글 2줄이 노출됩니다. 내용이 길지 않을 경우 한줄만 차지하게 해주세요, 넘어가면 이렇게 처리해주세요.';
const _sampleProfileImageUrl = 'https://picsum.photos/seed/grimity-hover-profile/400/400';
const _sampleCoverImageUrl = 'https://picsum.photos/seed/grimity-hover-cover/1200/600';

@widgetbook.UseCase(
  name: 'default',
  type: GdsUserHoverCard,
  path: '[component]/[card]',
)
Widget buildGdsUserHoverCardUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'UserHoverCard',
    description: '닉네임 hover 시 노출되는 작가 카드입니다. 고정 프레임(280px) 기준으로 내부 레이아웃을 constraints 기반으로 맞춥니다.',
    children: [
      _buildPlaygroundSection(context),
      _buildDemonstrationSection(context),
    ],
  );
}

Widget _buildPlaygroundSection(BuildContext context) {
  final state = context.knobs.list<GdsUserHoverCardState>(
    label: 'state',
    options: GdsUserHoverCardState.values,
    initialOption: GdsUserHoverCardState.defaultType,
    labelBuilder: (value) => value.name,
  );
  final showContent = context.knobs.boolean(label: 'showContent', initialValue: true);
  final showImages = context.knobs.boolean(label: 'showImages', initialValue: false);
  final nickname = context.knobs.string(label: 'nickname', initialValue: 'Nickname');
  final bio = context.knobs.string(label: 'bio', initialValue: _sampleBio);

  return WidgetbookPlayground(
    info: [
      'state: ${state.name}',
      'showContent: $showContent',
      'showImages: $showImages',
      'frame: ${GdsUserHoverCard.frameWidth.toInt()}px fixed',
    ],
    child: Align(
      alignment: Alignment.centerLeft,
      child: GdsUserHoverCard(
        nickname: nickname,
        profileImageUrl: showImages ? _sampleProfileImageUrl : null,
        coverImageUrl: showImages ? _sampleCoverImageUrl : null,
        bio: showContent ? bio : null,
        showContent: showContent,
        state: state,
        onFollowPressed: () {},
        onMessagePressed: () {},
      ),
    ),
  );
}

Widget _buildDemonstrationSection(BuildContext context) {
  return WidgetbookSection(
    title: 'UserHoverCard',
    children: [
      WidgetbookSubsection(
        title: 'state x content',
        labels: const ['4 variants'],
        content: const _HoverCardVariantMatrix(),
      ),
      WidgetbookSubsection(
        title: 'image loaded x fallback',
        labels: const ['without image', 'with image'],
        content: const _HoverCardImageMatrix(),
      ),
    ],
  );
}

class _HoverCardVariantMatrix extends StatelessWidget {
  const _HoverCardVariantMatrix();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 24,
      runSpacing: 24,
      children: const [
        GdsUserHoverCard(
          nickname: 'Nickname',
          showContent: false,
          state: GdsUserHoverCardState.defaultType,
        ),
        GdsUserHoverCard(
          nickname: 'Nickname',
          bio: _sampleBio,
          showContent: true,
          state: GdsUserHoverCardState.defaultType,
        ),
        GdsUserHoverCard(
          nickname: 'Nickname',
          showContent: false,
          state: GdsUserHoverCardState.follow,
        ),
        GdsUserHoverCard(
          nickname: 'Nickname',
          bio: _sampleBio,
          showContent: true,
          state: GdsUserHoverCardState.follow,
        ),
      ],
    );
  }
}

class _HoverCardImageMatrix extends StatelessWidget {
  const _HoverCardImageMatrix();

  @override
  Widget build(BuildContext context) {
    final labelStyle = GdsTypography.caption1.copyWith(
      color: context.gdsColors.text.graySubtle,
    );

    return Wrap(
      spacing: 24,
      runSpacing: 24,
      children: [
        SizedBox(
          width: GdsUserHoverCard.frameWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('without image', style: labelStyle),
              const SizedBox(height: GdsSpacing.spacing8),
              const GdsUserHoverCard(
                nickname: 'Nickname',
                bio: _sampleBio,
                showContent: true,
                state: GdsUserHoverCardState.defaultType,
              ),
            ],
          ),
        ),
        SizedBox(
          width: GdsUserHoverCard.frameWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('with image', style: labelStyle),
              const SizedBox(height: GdsSpacing.spacing8),
              const GdsUserHoverCard(
                nickname: 'Nickname',
                profileImageUrl: _sampleProfileImageUrl,
                coverImageUrl: _sampleCoverImageUrl,
                bio: _sampleBio,
                showContent: true,
                state: GdsUserHoverCardState.defaultType,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
