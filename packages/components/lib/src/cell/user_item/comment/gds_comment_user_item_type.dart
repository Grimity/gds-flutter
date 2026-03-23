part of '../../gds_user_item.dart';

enum _GdsCommentUserItemType {
  comment,
  commentXs,
  commentPlus,
  commentPlusXs;

  GdsAvatarSize get assertAvatarSize => switch (this) {
    _GdsCommentUserItemType.comment => GdsAvatarSize.md,
    _GdsCommentUserItemType.commentXs => GdsAvatarSize.xs,
    _GdsCommentUserItemType.commentPlus => GdsAvatarSize.xs,
    _GdsCommentUserItemType.commentPlusXs => GdsAvatarSize.xs,
  };

  double get rootLeftPadding => switch (this) {
    _GdsCommentUserItemType.comment => 0,
    _GdsCommentUserItemType.commentXs => 0,
    _GdsCommentUserItemType.commentPlus => GdsSpacing.spacing48,
    _GdsCommentUserItemType.commentPlusXs => GdsSpacing.spacing32,
  };

  double get contentLeftPadding => switch (this) {
    _GdsCommentUserItemType.comment => GdsSpacing.spacing48,
    _GdsCommentUserItemType.commentXs => GdsSpacing.spacing32,
    _GdsCommentUserItemType.commentPlus => GdsSpacing.spacing32,
    _GdsCommentUserItemType.commentPlusXs => GdsSpacing.spacing32,
  };

  bool get showReplyGuideIcon => switch (this) {
    _GdsCommentUserItemType.comment => false,
    _GdsCommentUserItemType.commentXs => false,
    _GdsCommentUserItemType.commentPlus => true,
    _GdsCommentUserItemType.commentPlusXs => true,
  };

  double get contentBottomSpacing => switch (this) {
    _GdsCommentUserItemType.comment => GdsSpacing.spacing12,
    _GdsCommentUserItemType.commentXs => GdsSpacing.spacing6,
    _GdsCommentUserItemType.commentPlus => GdsSpacing.spacing12,
    _GdsCommentUserItemType.commentPlusXs => GdsSpacing.spacing6,
  };
}
