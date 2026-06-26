import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook_components/widgetbook_components.dart';

@widgetbook.UseCase(
  name: 'default',
  type: GdsUserItem,
  path: '[component]/[cell]',
)
Widget buildGdsUserItemUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'UserItem',
    description:
        'UserItem 컴포넌트입니다.\n'
        'default / id / iconId / radio / follow / notification / link / linkMain / title / image / bookmark / communityTitle / comment / commentPlus / commentXs / commentPlusXs / commentDeleted 타입을 지원합니다.',
    children: [
      _buildPlaygroundSection(context),
      _buildDemonstrationSection(context),
    ],
  );
}

String _scopedKnobLabel(_UserItemPreviewType type, String name) {
  return '${type.label}.$name';
}

Widget _buildPlaygroundSection(BuildContext context) {
  final type = context.knobs.list<_UserItemPreviewType>(
    label: 'type',
    options: _UserItemPreviewType.values,
    initialOption: _UserItemPreviewType.defaultType,
    labelBuilder: (t) => t.label,
  );

  late final GdsUserItem userItem;
  late final List<String> info;

  switch (type) {
    case _UserItemPreviewType.defaultType:
      final nickName = context.knobs.string(label: _scopedKnobLabel(type, 'nickName'), initialValue: 'Nickname');
      final avatarImageUrl = context.knobs.stringOrNull(
        label: _scopedKnobLabel(type, 'avatarImageUrl'),
        initialValue: 'https://picsum.photos/200',
      );
      final showPrimaryAction = context.knobs.boolean(
        label: _scopedKnobLabel(type, 'showPrimaryAction'),
        initialValue: true,
      );
      final showSecondaryAction = context.knobs.boolean(
        label: _scopedKnobLabel(type, 'showSecondaryAction'),
        initialValue: true,
      );

      userItem = GdsUserItem.defaultType(
        nickName: nickName,
        personAvatar: _buildAvatar(avatarImageUrl),
        primaryActionButton: showPrimaryAction ? _buildOutlinedAction('팔로잉') : null,
        secondaryActionButton: showSecondaryAction ? _buildOutlinedAction('메시지') : null,
      );

      info = [
        'type: ${type.label}',
        'showPrimaryAction: $showPrimaryAction',
        'showSecondaryAction: $showSecondaryAction',
      ];

    case _UserItemPreviewType.id:
      final nickName = context.knobs.string(label: _scopedKnobLabel(type, 'nickName'), initialValue: 'Nickname');
      final avatarImageUrl = context.knobs.stringOrNull(
        label: _scopedKnobLabel(type, 'avatarImageUrl'),
        initialValue: 'https://picsum.photos/200',
      );
      final userId = context.knobs.string(label: _scopedKnobLabel(type, 'userId'), initialValue: '@user_id');
      final showPrimaryAction = context.knobs.boolean(
        label: _scopedKnobLabel(type, 'showPrimaryAction'),
        initialValue: true,
      );
      final showSecondaryAction = context.knobs.boolean(
        label: _scopedKnobLabel(type, 'showSecondaryAction'),
        initialValue: true,
      );

      userItem = GdsUserItem.id(
        nickName: nickName,
        personAvatar: _buildAvatar(avatarImageUrl),
        userId: userId,
        primaryActionButton: showPrimaryAction ? _buildOutlinedAction('팔로잉') : null,
        secondaryActionButton: showSecondaryAction ? _buildOutlinedAction('메시지') : null,
      );

      info = [
        'type: ${type.label}',
        'userId: $userId',
        'showPrimaryAction: $showPrimaryAction',
        'showSecondaryAction: $showSecondaryAction',
      ];

    case _UserItemPreviewType.iconId:
      final nickName = context.knobs.string(label: _scopedKnobLabel(type, 'nickName'), initialValue: 'Nickname');
      final avatarImageUrl = context.knobs.stringOrNull(
        label: _scopedKnobLabel(type, 'avatarImageUrl'),
        initialValue: 'https://picsum.photos/200',
      );
      final userId = context.knobs.string(label: _scopedKnobLabel(type, 'userId'), initialValue: '@user_id');
      final showPrimaryAction = context.knobs.boolean(
        label: _scopedKnobLabel(type, 'showPrimaryAction'),
        initialValue: true,
      );
      final showSecondaryAction = context.knobs.boolean(
        label: _scopedKnobLabel(type, 'showSecondaryAction'),
        initialValue: true,
      );

      userItem = GdsUserItem.iconId(
        nickName: nickName,
        personAvatar: _buildAvatar(avatarImageUrl),
        userId: userId,
        primaryActionButton: showPrimaryAction ? _buildIconAction(GdsIcon.bellFill) : null,
        secondaryActionButton: showSecondaryAction ? _buildIconAction(GdsIcon.share) : null,
      );

      info = [
        'type: ${type.label}',
        'userId: $userId',
        'actionSpacing: 0px @fixed',
        'showPrimaryAction: $showPrimaryAction',
        'showSecondaryAction: $showSecondaryAction',
      ];

    case _UserItemPreviewType.radio:
      final nickName = context.knobs.string(label: _scopedKnobLabel(type, 'nickName'), initialValue: 'Nickname');
      final avatarImageUrl = context.knobs.stringOrNull(
        label: _scopedKnobLabel(type, 'avatarImageUrl'),
        initialValue: 'https://picsum.photos/200',
      );
      final userId = context.knobs.string(label: _scopedKnobLabel(type, 'userId'), initialValue: '@user_id');
      final isSelected = context.knobs.boolean(label: _scopedKnobLabel(type, 'isSelected'), initialValue: false);
      final radioEnabled = context.knobs.boolean(label: _scopedKnobLabel(type, 'radioEnabled'), initialValue: true);

      userItem = GdsUserItem.radio(
        nickName: nickName,
        personAvatar: _buildAvatar(avatarImageUrl),
        userId: userId,
        radioButton: GdsRadioButton(
          isSelected: isSelected,
          enabled: radioEnabled,
          onTap: () {},
        ),
      );

      info = [
        'type: ${type.label}',
        'userId: $userId',
        'isSelected: $isSelected',
        'radioEnabled: $radioEnabled',
      ];

    case _UserItemPreviewType.follow:
      final nickName = context.knobs.string(label: _scopedKnobLabel(type, 'nickName'), initialValue: 'Nickname');
      final avatarImageUrl = context.knobs.stringOrNull(
        label: _scopedKnobLabel(type, 'avatarImageUrl'),
        initialValue: 'https://picsum.photos/200',
      );
      final followerCount = context.knobs.int.input(label: _scopedKnobLabel(type, 'followerCount'), initialValue: 123);
      final showFollowing = context.knobs.boolean(label: _scopedKnobLabel(type, 'showFollowing'), initialValue: true);
      final followingCount = showFollowing
          ? context.knobs.int.input(label: _scopedKnobLabel(type, 'followingCount'), initialValue: 32)
          : null;
      final showPrimaryAction = context.knobs.boolean(
        label: _scopedKnobLabel(type, 'showPrimaryAction'),
        initialValue: true,
      );
      final showSecondaryAction = context.knobs.boolean(
        label: _scopedKnobLabel(type, 'showSecondaryAction'),
        initialValue: true,
      );

      userItem = GdsUserItem.follow(
        nickName: nickName,
        personAvatar: _buildAvatar(avatarImageUrl),
        followUserInfo: GdsFollowUserInfo(
          followerCount: followerCount,
          followingCount: showFollowing ? followingCount : null,
        ),
        primaryActionButton: showPrimaryAction ? _buildOutlinedAction('팔로잉') : null,
        secondaryActionButton: showSecondaryAction ? _buildOutlinedAction('메시지') : null,
      );

      info = [
        'type: ${type.label}',
        'showFollowing: $showFollowing',
        'showPrimaryAction: $showPrimaryAction',
        'showSecondaryAction: $showSecondaryAction',
      ];

    case _UserItemPreviewType.notification:
      final titleText = context.knobs.string(label: _scopedKnobLabel(type, 'titleText'), initialValue: '기능');
      final messageText = context.knobs.string(
        label: _scopedKnobLabel(type, 'messageText'),
        initialValue: '[글, 그림]에 [기능]을 눌렀어요.',
      );
      final timeText = context.knobs.string(label: _scopedKnobLabel(type, 'timeText'), initialValue: '8분 전');

      userItem = GdsUserItem.notification(
        titleText: titleText,
        messageText: messageText,
        timeText: timeText,
        onTap: () {},
        iconButton: _buildNotificationCloseAction(),
      );

      info = [
        'type: ${type.label}',
        'titleText: $titleText',
        'timeText: $timeText',
        'messageMaxLines: 3 @fixed',
      ];

    case _UserItemPreviewType.link:
      final siteText = context.knobs.string(label: _scopedKnobLabel(type, 'siteText'), initialValue: 'Site');
      final linkText = context.knobs.string(label: _scopedKnobLabel(type, 'linkText'), initialValue: 'Link');
      final linkIcon = context.knobs.list<_LinkIconOption>(
        label: _scopedKnobLabel(type, 'icon'),
        options: _LinkIconOption.values,
        initialOption: _LinkIconOption.pixiv,
        labelBuilder: (icon) => icon.label,
      );

      userItem = GdsUserItem.link(
        icon: linkIcon.icon,
        siteText: siteText,
        linkText: linkText,
      );

      info = [
        'type: ${type.label}',
        'iconSize: 32px @fixed',
        'icon: ${linkIcon.label}',
        'siteText: $siteText',
        'linkText: $linkText',
      ];

    case _UserItemPreviewType.linkMain:
      final siteText = context.knobs.string(label: _scopedKnobLabel(type, 'siteText'), initialValue: 'Site');
      final linkIcon = context.knobs.list<_LinkIconOption>(
        label: _scopedKnobLabel(type, 'icon'),
        options: _LinkIconOption.values,
        initialOption: _LinkIconOption.pixiv,
        labelBuilder: (icon) => icon.label,
      );

      userItem = GdsUserItem.linkMain(
        icon: linkIcon.icon,
        siteText: siteText,
      );

      info = [
        'type: ${type.label}',
        'iconSize: 20px @fixed',
        'icon: ${linkIcon.label}',
        'siteText: $siteText',
      ];

    case _UserItemPreviewType.bookmark:
      final titleText = context.knobs.string(label: _scopedKnobLabel(type, 'titleText'), initialValue: 'Title');
      final contentText = context.knobs.string(
        label: _scopedKnobLabel(type, 'contentText'),
        initialValue: '글의 내용이 들어오는 곳입니다. 길게 작성이 되면 말을 줄여주세요.',
      );
      final showTag = context.knobs.boolean(label: _scopedKnobLabel(type, 'showTag'), initialValue: true);
      final showImageIcon = context.knobs.boolean(label: _scopedKnobLabel(type, 'showImageIcon'), initialValue: true);
      final commentCount = context.knobs.int.input(label: _scopedKnobLabel(type, 'commentCount'), initialValue: 4);
      final showBookmark = context.knobs.boolean(label: _scopedKnobLabel(type, 'showBookmark'), initialValue: true);
      final isBookmarked = showBookmark
          ? context.knobs.boolean(label: _scopedKnobLabel(type, 'isBookmarked'), initialValue: false)
          : false;

      userItem = GdsUserItem.bookmark(
        titleText: titleText,
        showImageIcon: showImageIcon,
        showTag: showTag,
        chip: showTag ? _buildAssistiveTag('일반') : null,
        commentCount: commentCount,
        contentText: contentText,
        userInfo: _buildPostDefaultUserInfo(showHeart: true),
        showBookmark: showBookmark,
        bookmark: showBookmark ? _buildBookmark(isBookmarked) : null,
      );

      info = [
        'type: ${type.label}',
        'showTag: $showTag',
        'showImageIcon: $showImageIcon',
        'showBookmark: $showBookmark',
      ];

    case _UserItemPreviewType.communityTitle:
      final titleText = context.knobs.string(label: _scopedKnobLabel(type, 'titleText'), initialValue: 'Title');
      final contentText = context.knobs.string(
        label: _scopedKnobLabel(type, 'contentText'),
        initialValue: '글의 내용이 들어오는 곳입니다. 길게 작성이 되면 말을 줄여주세요.',
      );
      final showTag = context.knobs.boolean(label: _scopedKnobLabel(type, 'showTag'), initialValue: true);
      final commentCount = context.knobs.int.input(label: _scopedKnobLabel(type, 'commentCount'), initialValue: 4);

      userItem = GdsUserItem.communityTitle(
        titleText: titleText,
        showTag: showTag,
        chip: showTag ? _buildAssistiveTag('일반') : null,
        commentCount: commentCount,
        contentText: contentText,
        userInfo: _buildPostDefaultUserInfo(showHeart: false),
      );

      info = [
        'type: ${type.label}',
        'showTag: $showTag',
      ];

    case _UserItemPreviewType.title:
      final titleText = context.knobs.string(label: _scopedKnobLabel(type, 'titleText'), initialValue: 'Title');
      final showTag = context.knobs.boolean(label: _scopedKnobLabel(type, 'showTag'), initialValue: true);

      userItem = GdsUserItem.title(
        titleText: titleText,
        showTag: showTag,
        chip: showTag ? _buildAssistiveTag('일반') : null,
        userInfo: _buildPostDefaultUserInfo(showHeart: false),
      );

      info = [
        'type: ${type.label}',
        'showTag: $showTag',
      ];

    case _UserItemPreviewType.image:
      final titleText = context.knobs.string(label: _scopedKnobLabel(type, 'titleText'), initialValue: 'Title');
      final thumbnailImageUrl = context.knobs.string(
        label: _scopedKnobLabel(type, 'thumbnailImageUrl'),
        initialValue: 'https://picsum.photos/96',
      );

      userItem = GdsUserItem.image(
        titleText: titleText,
        thumbnail: _buildPostThumbnail(thumbnailImageUrl),
        userInfo: _buildPostCommunityUserInfo(),
      );

      info = [
        'type: ${type.label}',
        'thumbnail: 48x48 @fixed',
      ];

    case _UserItemPreviewType.comment:
      final avatarImageUrl = context.knobs.stringOrNull(
        label: _scopedKnobLabel(type, 'avatarImageUrl'),
        initialValue: null,
      );
      final nickName = context.knobs.string(label: _scopedKnobLabel(type, 'nickName'), initialValue: 'Nickname');
      final showTag = context.knobs.boolean(label: _scopedKnobLabel(type, 'showTag'), initialValue: true);
      final showTime = context.knobs.boolean(label: _scopedKnobLabel(type, 'showTime'), initialValue: true);
      final timeText = showTime
          ? context.knobs.string(label: _scopedKnobLabel(type, 'timeText'), initialValue: '32분 전')
          : null;
      final commentText = context.knobs.string(
        label: _scopedKnobLabel(type, 'commentText'),
        initialValue: '댓글 내용 노출됩니다.\n길어지면 2줄 이상으로 나오고 절대 가리지 마세요!',
      );
      final isLiked = context.knobs.boolean(label: _scopedKnobLabel(type, 'isLiked'), initialValue: false);
      final likeCount = context.knobs.int.input(label: _scopedKnobLabel(type, 'likeCount'), initialValue: 21);

      userItem = GdsUserItem.comment(
        personAvatar: _buildAvatar(avatarImageUrl),
        commentUserInfo: GdsCommentUserInfo(
          nickName: nickName,
          showTag: showTag,
          showTime: showTime,
          timeText: timeText,
        ),
        commentText: commentText,
        isLiked: isLiked,
        onLikeTap: () {},
        likeCount: likeCount,
        onReplyTap: () {},
        onMenuTap: () {},
      );

      info = [
        'type: ${type.label}',
        'showTag: $showTag',
        'showTime: $showTime',
        'isLiked: $isLiked',
      ];

    case _UserItemPreviewType.commentPlus:
      final avatarImageUrl = context.knobs.stringOrNull(
        label: _scopedKnobLabel(type, 'avatarImageUrl'),
        initialValue: null,
      );
      final nickName = context.knobs.string(label: _scopedKnobLabel(type, 'nickName'), initialValue: 'Nickname');
      final showTag = context.knobs.boolean(label: _scopedKnobLabel(type, 'showTag'), initialValue: true);
      final showTime = context.knobs.boolean(label: _scopedKnobLabel(type, 'showTime'), initialValue: true);
      final timeText = showTime
          ? context.knobs.string(label: _scopedKnobLabel(type, 'timeText'), initialValue: '32분 전')
          : null;
      final mentionText = context.knobs.string(label: _scopedKnobLabel(type, 'mentionText'), initialValue: '@닉네임');
      final commentText = context.knobs.string(
        label: _scopedKnobLabel(type, 'commentText'),
        initialValue: '댓글 내용 노출됩니다.',
      );
      final isLiked = context.knobs.boolean(label: _scopedKnobLabel(type, 'isLiked'), initialValue: false);
      final likeCount = context.knobs.int.input(label: _scopedKnobLabel(type, 'likeCount'), initialValue: 21);

      userItem = GdsUserItem.commentPlus(
        personAvatar: _buildAvatar(avatarImageUrl, size: GdsAvatarSize.xs),
        commentUserInfo: GdsCommentUserInfo(
          nickName: nickName,
          showTag: showTag,
          showTime: showTime,
          timeText: timeText,
        ),
        mentionText: mentionText,
        commentText: commentText,
        isLiked: isLiked,
        onLikeTap: () {},
        likeCount: likeCount,
        onReplyTap: () {},
        onMenuTap: () {},
      );

      info = [
        'type: ${type.label}',
        'showTag: $showTag',
        'showTime: $showTime',
        'isLiked: $isLiked',
      ];

    case _UserItemPreviewType.commentXs:
      final avatarImageUrl = context.knobs.stringOrNull(
        label: _scopedKnobLabel(type, 'avatarImageUrl'),
        initialValue: null,
      );
      final nickName = context.knobs.string(label: _scopedKnobLabel(type, 'nickName'), initialValue: 'Nickname');
      final showTag = context.knobs.boolean(label: _scopedKnobLabel(type, 'showTag'), initialValue: true);
      final showTime = context.knobs.boolean(label: _scopedKnobLabel(type, 'showTime'), initialValue: true);
      final timeText = showTime
          ? context.knobs.string(label: _scopedKnobLabel(type, 'timeText'), initialValue: '32분 전')
          : null;
      final commentText = context.knobs.string(
        label: _scopedKnobLabel(type, 'commentText'),
        initialValue: '댓글 내용 노출됩니다.\n길어지면 2줄 이상으로 나오고 절대 가리지 마세요!',
      );
      final isLiked = context.knobs.boolean(label: _scopedKnobLabel(type, 'isLiked'), initialValue: false);
      final likeCount = context.knobs.int.input(label: _scopedKnobLabel(type, 'likeCount'), initialValue: 21);

      userItem = GdsUserItem.commentXs(
        personAvatar: _buildAvatar(avatarImageUrl, size: GdsAvatarSize.xs),
        commentUserInfo: GdsCommentUserInfo(
          nickName: nickName,
          showTag: showTag,
          showTime: showTime,
          timeText: timeText,
        ),
        commentText: commentText,
        isLiked: isLiked,
        onLikeTap: () {},
        likeCount: likeCount,
        onReplyTap: () {},
        onMenuTap: () {},
      );

      info = [
        'type: ${type.label}',
        'showTag: $showTag',
        'showTime: $showTime',
        'isLiked: $isLiked',
      ];

    case _UserItemPreviewType.commentPlusXs:
      final avatarImageUrl = context.knobs.stringOrNull(
        label: _scopedKnobLabel(type, 'avatarImageUrl'),
        initialValue: null,
      );
      final nickName = context.knobs.string(label: _scopedKnobLabel(type, 'nickName'), initialValue: 'Nickname');
      final showTag = context.knobs.boolean(label: _scopedKnobLabel(type, 'showTag'), initialValue: true);
      final showTime = context.knobs.boolean(label: _scopedKnobLabel(type, 'showTime'), initialValue: true);
      final timeText = showTime
          ? context.knobs.string(label: _scopedKnobLabel(type, 'timeText'), initialValue: '32분 전')
          : null;
      final mentionText = context.knobs.string(label: _scopedKnobLabel(type, 'mentionText'), initialValue: '@닉네임');
      final commentText = context.knobs.string(
        label: _scopedKnobLabel(type, 'commentText'),
        initialValue: '댓글 내용 노출됩니다.',
      );
      final isLiked = context.knobs.boolean(label: _scopedKnobLabel(type, 'isLiked'), initialValue: false);
      final likeCount = context.knobs.int.input(label: _scopedKnobLabel(type, 'likeCount'), initialValue: 21);

      userItem = GdsUserItem.commentPlusXs(
        personAvatar: _buildAvatar(avatarImageUrl, size: GdsAvatarSize.xs),
        commentUserInfo: GdsCommentUserInfo(
          nickName: nickName,
          showTag: showTag,
          showTime: showTime,
          timeText: timeText,
        ),
        mentionText: mentionText,
        commentText: commentText,
        isLiked: isLiked,
        onLikeTap: () {},
        likeCount: likeCount,
        onReplyTap: () {},
        onMenuTap: () {},
      );

      info = [
        'type: ${type.label}',
        'showTag: $showTag',
        'showTime: $showTime',
        'isLiked: $isLiked',
      ];

    case _UserItemPreviewType.commentDeleted:
      userItem = const GdsUserItem.commentDeleted();

      info = [
        'type: ${type.label}',
        'message: 삭제된 댓글입니다. @fixed',
      ];
  }

  return WidgetbookPlayground(
    layout: PlaygroundLayout.stretch,
    info: info,
    child: Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        width: 420,
        child: userItem,
      ),
    ),
  );
}

Widget _buildDemonstrationSection(BuildContext context) {
  return WidgetbookSection(
    title: 'UserItem',
    children: [
      WidgetbookSubsection(
        title: 'type',
        labels: const ['17 types'],
        content: const _UserItemTypeMatrix(),
      ),
    ],
  );
}

enum _UserItemPreviewType {
  defaultType,
  id,
  iconId,
  radio,
  follow,
  notification,
  link,
  linkMain,
  bookmark,
  communityTitle,
  title,
  image,
  comment,
  commentPlus,
  commentXs,
  commentPlusXs,
  commentDeleted;

  String get label => switch (this) {
    _UserItemPreviewType.defaultType => 'default',
    _UserItemPreviewType.id => 'id',
    _UserItemPreviewType.iconId => 'iconId',
    _UserItemPreviewType.radio => 'radio',
    _UserItemPreviewType.follow => 'follow',
    _UserItemPreviewType.notification => 'notification',
    _UserItemPreviewType.link => 'link',
    _UserItemPreviewType.linkMain => 'linkMain',
    _UserItemPreviewType.bookmark => 'bookmark',
    _UserItemPreviewType.communityTitle => 'communityTitle',
    _UserItemPreviewType.title => 'title',
    _UserItemPreviewType.image => 'image',
    _UserItemPreviewType.comment => 'comment',
    _UserItemPreviewType.commentPlus => 'commentPlus',
    _UserItemPreviewType.commentXs => 'commentXs',
    _UserItemPreviewType.commentPlusXs => 'commentPlusXs',
    _UserItemPreviewType.commentDeleted => 'commentDeleted',
  };
}

enum _LinkIconOption {
  youtube,
  pixiv,
  mail,
  x;

  String get label => switch (this) {
    _LinkIconOption.youtube => 'youtube',
    _LinkIconOption.pixiv => 'pixiv',
    _LinkIconOption.mail => 'mail',
    _LinkIconOption.x => 'x',
  };

  GdsIcon get icon => switch (this) {
    _LinkIconOption.youtube => GdsIcon.youtubeBg,
    _LinkIconOption.pixiv => GdsIcon.pixivBg,
    _LinkIconOption.mail => GdsIcon.email,
    _LinkIconOption.x => GdsIcon.xBg,
  };
}

class _UserItemTypeMatrix extends StatelessWidget {
  const _UserItemTypeMatrix();

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
        for (final type in _UserItemPreviewType.values)
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16, bottom: 16),
                child: Text(type.label, style: labelStyle),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: SizedBox(width: 420, child: _buildPreview(type)),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildPreview(_UserItemPreviewType type) {
    return switch (type) {
      _UserItemPreviewType.defaultType => GdsUserItem.defaultType(
        nickName: 'Nickname',
        personAvatar: _buildAvatar(null),
        primaryActionButton: _buildOutlinedAction('Label'),
        secondaryActionButton: _buildOutlinedAction('Label'),
      ),
      _UserItemPreviewType.id => GdsUserItem.id(
        nickName: 'Nickname',
        personAvatar: _buildAvatar(null),
        userId: '@user_id',
        primaryActionButton: _buildOutlinedAction('Label'),
        secondaryActionButton: _buildOutlinedAction('Label'),
      ),
      _UserItemPreviewType.iconId => GdsUserItem.iconId(
        nickName: 'Nickname',
        personAvatar: _buildAvatar(null),
        userId: '@user_id',
        primaryActionButton: _buildIconAction(GdsIcon.bellFill),
        secondaryActionButton: _buildIconAction(GdsIcon.share),
      ),
      _UserItemPreviewType.radio => GdsUserItem.radio(
        nickName: 'Nickname',
        personAvatar: _buildAvatar(null),
        userId: '@user_id',
        radioButton: GdsRadioButton(
          isSelected: true,
          enabled: true,
          onTap: () {},
        ),
      ),
      _UserItemPreviewType.follow => GdsUserItem.follow(
        nickName: 'Nickname',
        personAvatar: _buildAvatar(null),
        followUserInfo: GdsFollowUserInfo(
          followerCount: 123,
          followingCount: 32,
        ),
        primaryActionButton: _buildOutlinedAction('Label'),
        secondaryActionButton: _buildOutlinedAction('Label'),
      ),
      _UserItemPreviewType.notification => GdsUserItem.notification(
        titleText: '기능',
        messageText: '[글, 그림]에 [기능]을 눌렀어요.',
        timeText: '8분 전',
        onTap: () {},
        iconButton: _buildNotificationCloseAction(),
      ),
      _UserItemPreviewType.link => GdsUserItem.link(
        icon: GdsIcon.pixivBg,
        siteText: 'Site',
        linkText: 'Link',
      ),
      _UserItemPreviewType.linkMain => GdsUserItem.linkMain(
        icon: GdsIcon.pixivBg,
        siteText: 'Site',
      ),
      _UserItemPreviewType.bookmark => GdsUserItem.bookmark(
        titleText: 'Title',
        showImageIcon: true,
        showTag: true,
        chip: _buildAssistiveTag('일반'),
        commentCount: 4,
        contentText: '글의 내용이 들어오는 곳입니다. 길게 작성이 되면 말을 줄여주세요.',
        userInfo: _buildPostDefaultUserInfo(showHeart: true),
        showBookmark: true,
        bookmark: _buildBookmark(false),
      ),
      _UserItemPreviewType.communityTitle => GdsUserItem.communityTitle(
        titleText: 'Title',
        showTag: true,
        chip: _buildAssistiveTag('일반'),
        commentCount: 4,
        contentText: '글의 내용이 들어오는 곳입니다. 길게 작성이 되면 말을 줄여주세요.',
        userInfo: _buildPostDefaultUserInfo(showHeart: false),
      ),
      _UserItemPreviewType.title => GdsUserItem.title(
        titleText: 'Title',
        showTag: true,
        chip: _buildPrimaryTag('일반'),
        userInfo: _buildPostDefaultUserInfo(showHeart: false),
      ),
      _UserItemPreviewType.image => GdsUserItem.image(
        titleText: 'Title',
        thumbnail: _buildPostThumbnail('https://picsum.photos/96'),
        userInfo: _buildPostCommunityUserInfo(),
      ),
      _UserItemPreviewType.comment => GdsUserItem.comment(
        personAvatar: _buildAvatar(null),
        commentUserInfo: const GdsCommentUserInfo(
          nickName: 'Nickname',
          showTag: true,
          showTime: true,
          timeText: '32분 전',
        ),
        commentText: '댓글 내용 노출됩니다.\n길어지면 2줄 이상으로 나오고 절대 가리지 마세요!',
        isLiked: false,
        onLikeTap: () {},
        likeCount: 21,
        onReplyTap: () {},
        onMenuTap: () {},
      ),
      _UserItemPreviewType.commentPlus => GdsUserItem.commentPlus(
        personAvatar: _buildAvatar(null, size: GdsAvatarSize.xs),
        commentUserInfo: const GdsCommentUserInfo(
          nickName: 'Nickname',
          showTag: true,
          showTime: true,
          timeText: '32분 전',
        ),
        mentionText: '@닉네임',
        commentText: '댓글 내용 노출됩니다.',
        isLiked: false,
        onLikeTap: () {},
        likeCount: 21,
        onReplyTap: () {},
        onMenuTap: () {},
      ),
      _UserItemPreviewType.commentXs => GdsUserItem.commentXs(
        personAvatar: _buildAvatar(null, size: GdsAvatarSize.xs),
        commentUserInfo: const GdsCommentUserInfo(
          nickName: 'Nickname',
          showTag: true,
          showTime: true,
          timeText: '32분 전',
        ),
        commentText: '댓글 내용 노출됩니다.\n길어지면 2줄 이상으로 나오고 절대 가리지 마세요!',
        isLiked: false,
        onLikeTap: () {},
        likeCount: 21,
        onReplyTap: () {},
        onMenuTap: () {},
      ),
      _UserItemPreviewType.commentPlusXs => GdsUserItem.commentPlusXs(
        personAvatar: _buildAvatar(null, size: GdsAvatarSize.xs),
        commentUserInfo: const GdsCommentUserInfo(
          nickName: 'Nickname',
          showTag: true,
          showTime: true,
          timeText: '32분 전',
        ),
        mentionText: '@닉네임',
        commentText: '댓글 내용 노출됩니다.',
        isLiked: false,
        onLikeTap: () {},
        likeCount: 21,
        onReplyTap: () {},
        onMenuTap: () {},
      ),
      _UserItemPreviewType.commentDeleted => const GdsUserItem.commentDeleted(),
    };
  }
}

GdsPersonAvatar _buildAvatar(
  String? imageUrl, {
  GdsAvatarSize size = GdsAvatarSize.md,
}) {
  return GdsPersonAvatar(
    size: size,
    imageUrl: imageUrl,
  );
}

GdsOutlinedButton _buildOutlinedAction(String text) {
  return GdsOutlinedButton(
    text: text,
    size: GdsOutlinedButtonSize.small,
    onPressed: () {},
  );
}

GdsIconButton _buildIconAction(GdsIcon icon) {
  return GdsIconButton.normal(
    icon: icon,
    onPressed: () {},
  );
}

GdsIconButton _buildNotificationCloseAction() {
  return GdsIconButton.normal(
    icon: GdsIcon.xMark,
    onPressed: () {},
  );
}

GdsChip _buildAssistiveTag(String text) {
  return GdsChip.medium(
    text: text,
    variant: GdsChipVariant.assistive,
  );
}

GdsChip _buildPrimaryTag(String text) {
  return GdsChip.medium(
    text: text,
  );
}

GdsUserInfo _buildPostDefaultUserInfo({required bool showHeart}) {
  return GdsUserInfo.defaultType(
    nickName: 'Nickname',
    showHeart: showHeart,
    heartCount: showHeart ? 4 : null,
    showView: true,
    viewCount: 123,
    showTime: true,
    timeText: '32분 전',
  );
}

GdsUserInfo _buildPostCommunityUserInfo() {
  return GdsUserInfo.community(
    showChat: true,
    chatCount: 4,
    showHeart: false,
    heartCount: null,
    showView: true,
    viewCount: 123,
    showTime: true,
    timeText: '32분 전',
  );
}

GdsThumbnail _buildPostThumbnail(String imageUrl) {
  return GdsThumbnail(
    imageUrl: imageUrl,
    ratio: GdsThumbnailRatio.r1x1,
    width: 48,
    height: 48,
    borderRadius: BorderRadius.circular(GdsRadius.sm),
  );
}

GdsBookmark _buildBookmark(bool isBookmarked) {
  return GdsBookmark(
    isBookmarked: isBookmarked,
    onTap: () {},
  );
}
