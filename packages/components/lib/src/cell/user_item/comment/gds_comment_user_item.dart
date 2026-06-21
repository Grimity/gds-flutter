part of '../../gds_user_item.dart';

class GdsCommentUserItem extends GdsUserItem {
  const GdsCommentUserItem({
    super.key,
    required this.personAvatar,
    required this.commentUserInfo,
    required this.commentText,
    required this.isLiked,
    required this.onLikeTap,
    required this.likeCount,
    required this.onReplyTap,
    required this.onMenuTap,
    this.menuLayerLink,
  }) : _type = _GdsCommentUserItemType.comment;

  const GdsCommentUserItem.xs({
    super.key,
    required this.personAvatar,
    required this.commentUserInfo,
    required this.commentText,
    required this.isLiked,
    required this.onLikeTap,
    required this.likeCount,
    required this.onReplyTap,
    required this.onMenuTap,
    this.menuLayerLink,
  }) : _type = _GdsCommentUserItemType.commentXs;

  final _GdsCommentUserItemType _type;
  final GdsPersonAvatar personAvatar;
  final GdsCommentUserInfo commentUserInfo;
  final String commentText;
  final bool isLiked;
  final VoidCallback onLikeTap;
  final int likeCount;
  final VoidCallback onReplyTap;
  final VoidCallback onMenuTap;
  final LayerLink? menuLayerLink;

  @override
  Widget build(BuildContext context) {
    assert(personAvatar.size == _type.assertAvatarSize, 'personAvatar size must be ${_type.assertAvatarSize}');

    return _GdsCommentUserItemFrame(
      type: _type,
      personAvatar: personAvatar,
      commentUserInfo: commentUserInfo,
      commentText: commentText,
      mentionText: null,
      isLiked: isLiked,
      likeCount: likeCount,
      onLikeTap: onLikeTap,
      onReplyTap: onReplyTap,
      onMenuTap: onMenuTap,
      menuLayerLink: menuLayerLink,
    );
  }
}
