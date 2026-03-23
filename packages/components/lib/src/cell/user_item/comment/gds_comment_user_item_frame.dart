part of '../../gds_user_item.dart';

class _GdsCommentUserItemFrame extends StatelessWidget {
  const _GdsCommentUserItemFrame({
    required this.type,
    required this.personAvatar,
    required this.commentUserInfo,
    required this.commentText,
    required this.isLiked,
    required this.likeCount,
    required this.onLikeTap,
    required this.onReplyTap,
    required this.onMoreHorizontalTap,
    this.mentionText,
  });

  final _GdsCommentUserItemType type;
  final GdsPersonAvatar personAvatar;
  final GdsCommentUserInfo commentUserInfo;
  final String commentText;
  final String? mentionText;
  final bool isLiked;
  final int likeCount;
  final VoidCallback onLikeTap;
  final VoidCallback onReplyTap;
  final VoidCallback onMoreHorizontalTap;

  @override
  Widget build(BuildContext context) {
    final frame = Column(
      children: [
        _buildHeader(context),
        const SizedBox(height: GdsSpacing.spacing4),
        _buildBody(context),
        SizedBox(height: type.contentBottomSpacing),
        _buildActions(context),
      ],
    );

    if (type.rootLeftPadding == 0) {
      return frame;
    }

    return Padding(
      padding: EdgeInsets.only(left: type.rootLeftPadding),
      child: frame,
    );
  }

  Widget _buildHeader(BuildContext context) {
    final colors = context.gdsColors;
    final avatarSpacing = type.showReplyGuideIcon ? GdsSpacing.spacing6 : GdsSpacing.spacing8;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (type.showReplyGuideIcon) ...[
          GdsIcon.replyComment.build(
            color: colors.border.graySubtle,
            width: GdsIconSize.v10,
            height: GdsIconSize.v10,
          ),
          const SizedBox(width: GdsSpacing.spacing6),
        ],
        personAvatar,
        SizedBox(width: avatarSpacing),
        Expanded(child: commentUserInfo),
        GdsIconButton.small(
          icon: GdsIcon.dotMenuHorizontal,
          onPressed: onMoreHorizontalTap,
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: type.contentLeftPadding),
        Expanded(child: _buildBodyText(context)),
      ],
    );
  }

  Widget _buildBodyText(BuildContext context) {
    final colors = context.gdsColors;
    final commentStyle = GdsTypography.body2R.copyWith(color: colors.text.grayBold);

    if (mentionText == null || mentionText!.isEmpty) {
      return Text(commentText, style: commentStyle);
    }

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '$mentionText ',
            style: GdsTypography.label5.copyWith(color: colors.text.primaryNormal),
          ),
          TextSpan(
            text: commentText,
            style: commentStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    final colors = context.gdsColors;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: type.contentLeftPadding),
        GdsTextButton(
          text: '$likeCount',
          leadingIcon: GdsHeart.icon(isLiked),
          iconColor: GdsHeartType.defaultType.iconColor(colors, isLiked),
          onPressed: onLikeTap,
          variant: GdsTextButtonVariant.assistive,
          size: GdsTextButtonSize.small,
        ),
        const SizedBox(width: GdsSpacing.spacing10),
        GdsTextButton(
          text: '답글달기',
          leadingIcon: GdsIcon.chatRound,
          onPressed: onReplyTap,
          variant: GdsTextButtonVariant.assistive,
          size: GdsTextButtonSize.small,
        ),
      ],
    );
  }
}
