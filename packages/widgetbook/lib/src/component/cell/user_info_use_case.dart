import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook_components/widgetbook_components.dart';

@widgetbook.UseCase(
  name: 'default',
  type: GdsUserInfo,
  path: '[component]/[cell]',
)
Widget buildGdsUserInfoUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'UserInfo',
    description: 'Default / Community / Comment / Follow 타입을 지원하는 사용자 메타 정보 컴포넌트입니다.',
    children: [
      _buildPlaygroundSection(context),
      _buildDemonstrationSection(context),
    ],
  );
}

Widget _buildPlaygroundSection(BuildContext context) {
  final type = context.knobs.list<_UserInfoPreviewType>(
    label: 'type',
    options: _UserInfoPreviewType.values,
    initialOption: _UserInfoPreviewType.defaultType,
    labelBuilder: (t) => t.label,
  );

  late final GdsUserInfo userInfo;
  late final List<String> info;

  switch (type) {
    case _UserInfoPreviewType.defaultType:
      final nickName = context.knobs.string(label: 'nickName', initialValue: 'Nickname');
      final showHeart = context.knobs.boolean(label: 'showHeart', initialValue: true);
      final heartCount = showHeart ? context.knobs.int.input(label: 'heartCount', initialValue: 32) : null;
      final showView = context.knobs.boolean(label: 'showView', initialValue: true);
      final viewCount = showView ? context.knobs.int.input(label: 'viewCount', initialValue: 123) : null;
      final showTime = context.knobs.boolean(label: 'showTime', initialValue: true);
      final timeText = showTime ? context.knobs.stringOrNull(label: 'timeText', initialValue: '32분 전') : null;

      userInfo = GdsUserInfo.defaultType(
        nickName: nickName,
        showHeart: showHeart,
        heartCount: heartCount,
        showView: showView,
        viewCount: viewCount,
        showTime: showTime,
        timeText: timeText,
      );

      info = [
        'type: ${type.label}',
        'nickName: $nickName',
        'showHeart: $showHeart',
        'showView: $showView',
        'showTime: $showTime',
      ];

    case _UserInfoPreviewType.community:
      final showChat = context.knobs.boolean(label: 'showChat', initialValue: true);
      final chatCount = showChat ? context.knobs.int.input(label: 'chatCount', initialValue: 4) : null;
      final showHeart = context.knobs.boolean(label: 'showHeart', initialValue: true);
      final heartCount = showHeart ? context.knobs.int.input(label: 'heartCount', initialValue: 32) : null;
      final showView = context.knobs.boolean(label: 'showView', initialValue: true);
      final viewCount = showView ? context.knobs.int.input(label: 'viewCount', initialValue: 123) : null;
      final showTime = context.knobs.boolean(label: 'showTime', initialValue: true);
      final timeText = showTime ? context.knobs.stringOrNull(label: 'timeText', initialValue: '32분 전') : null;

      userInfo = GdsUserInfo.community(
        showChat: showChat,
        chatCount: chatCount,
        showHeart: showHeart,
        heartCount: heartCount,
        showView: showView,
        viewCount: viewCount,
        showTime: showTime,
        timeText: timeText,
      );

      info = [
        'type: ${type.label}',
        'showChat: $showChat',
        'showHeart: $showHeart',
        'showView: $showView',
        'showTime: $showTime',
      ];

    case _UserInfoPreviewType.comment:
      final nickName = context.knobs.string(label: 'nickName', initialValue: 'Nickname');
      final showTag = context.knobs.boolean(label: 'showTag', initialValue: true);
      final showTime = context.knobs.boolean(label: 'showTime', initialValue: true);
      final timeText = showTime ? context.knobs.stringOrNull(label: 'timeText', initialValue: '32분 전') : null;

      userInfo = GdsUserInfo.comment(
        nickName: nickName,
        showTag: showTag,
        showTime: showTime,
        timeText: timeText,
      );

      info = [
        'type: ${type.label}',
        'nickName: $nickName',
        'showTag: $showTag',
        'showTime: $showTime',
      ];

    case _UserInfoPreviewType.follow:
      final followerCount = context.knobs.int.input(label: 'followerCount', initialValue: 123);
      final showFollowing = context.knobs.boolean(label: 'showFollowing', initialValue: true);
      final followingCount = showFollowing ? context.knobs.int.input(label: 'followingCount', initialValue: 32) : null;

      userInfo = GdsUserInfo.follow(
        followerCount: followerCount,
        showFollowing: showFollowing,
        followingCount: followingCount,
      );

      info = [
        'type: ${type.label}',
        'showFollowing: $showFollowing',
      ];
  }

  return WidgetbookPlayground(
    layout: PlaygroundLayout.stretch,
    info: info,
    child: Align(
      alignment: Alignment.centerLeft,
      child: userInfo,
    ),
  );
}

Widget _buildDemonstrationSection(BuildContext context) {
  return WidgetbookSection(
    title: 'UserInfo',
    children: [
      WidgetbookSubsection(
        title: 'type',
        labels: const ['4 types'],
        content: const _UserInfoTypeMatrix(),
      ),
    ],
  );
}

enum _UserInfoPreviewType {
  defaultType,
  community,
  comment,
  follow;

  String get label => switch (this) {
    _UserInfoPreviewType.defaultType => 'default',
    _UserInfoPreviewType.community => 'community',
    _UserInfoPreviewType.comment => 'comment',
    _UserInfoPreviewType.follow => 'follow',
  };
}

class _UserInfoTypeMatrix extends StatelessWidget {
  const _UserInfoTypeMatrix();

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final labelStyle = GdsTypography.caption1.copyWith(color: colors.text.graySubtle);

    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {
        0: IntrinsicColumnWidth(),
        1: FlexColumnWidth(),
      },
      children: [
        for (final type in _UserInfoPreviewType.values)
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16, bottom: 16),
                child: Text(type.label, style: labelStyle),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildPreview(type),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildPreview(_UserInfoPreviewType type) {
    return switch (type) {
      _UserInfoPreviewType.defaultType => const GdsUserInfo.defaultType(
        nickName: 'Nickname',
        showHeart: true,
        heartCount: 32,
        showView: true,
        viewCount: 123,
        showTime: true,
        timeText: '32분 전',
      ),
      _UserInfoPreviewType.community => const GdsUserInfo.community(
        showChat: true,
        chatCount: 4,
        showHeart: true,
        heartCount: 32,
        showView: true,
        viewCount: 123,
        showTime: true,
        timeText: '32분 전',
      ),
      _UserInfoPreviewType.comment => const GdsUserInfo.comment(
        nickName: 'Nickname',
        showTag: true,
        showTime: true,
        timeText: '32분 전',
      ),
      _UserInfoPreviewType.follow => const GdsUserInfo.follow(
        followerCount: 123,
        showFollowing: true,
        followingCount: 32,
      ),
    };
  }
}
