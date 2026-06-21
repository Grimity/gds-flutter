part of '../../gds_user_item.dart';

class GdsCommentPlusUserItem extends GdsUserItem {
  const GdsCommentPlusUserItem({
    super.key,
    required this.personAvatar,
    required this.commentUserInfo,
    required this.commentText,
    required this.isLiked,
    required this.onLikeTap,
    required this.likeCount,
    required this.onReplyTap,
    required this.onMenuTap,
    required this.mentionText,
    this.menuLayerLink,
  }) : _type = _GdsCommentUserItemType.commentPlus;

  const GdsCommentPlusUserItem.xs({
    super.key,
    required this.personAvatar,
    required this.commentUserInfo,
    required this.commentText,
    required this.isLiked,
    required this.onLikeTap,
    required this.likeCount,
    required this.onReplyTap,
    required this.onMenuTap,
    required this.mentionText,
    this.menuLayerLink,
  }) : _type = _GdsCommentUserItemType.commentPlusXs;

  final _GdsCommentUserItemType _type;
  final GdsPersonAvatar personAvatar;
  final GdsCommentUserInfo commentUserInfo;
  final String commentText;
  final bool isLiked;
  final VoidCallback onLikeTap;
  final int likeCount;
  final VoidCallback onReplyTap;
  final VoidCallback onMenuTap;
  final String mentionText;
  final LayerLink? menuLayerLink;

  @override
  Widget build(BuildContext context) {
    assert(personAvatar.size == _type.assertAvatarSize, 'personAvatar size must be ${_type.assertAvatarSize}');

    return _GdsCommentUserItemFrame(
      type: _type,
      personAvatar: personAvatar,
      commentUserInfo: commentUserInfo,
      commentText: commentText,
      mentionText: mentionText,
      isLiked: isLiked,
      likeCount: likeCount,
      onLikeTap: onLikeTap,
      onReplyTap: onReplyTap,
      onMenuTap: onMenuTap,
      menuLayerLink: menuLayerLink,
    );
  }
}
