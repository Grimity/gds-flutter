part of '../../gds_user_item.dart';

class GdsFollowUserItem extends GdsUserItem {
  final String nickName;
  final GdsPersonAvatar personAvatar;
  final GdsFollowUserInfo followUserInfo;
  final Widget? primaryActionButton;
  final Widget? secondaryActionButton;

  const GdsFollowUserItem({
    super.key,
    required this.nickName,
    required this.personAvatar,
    required this.followUserInfo,
    this.primaryActionButton,
    this.secondaryActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return _GdsProfileUserItemFrame(
      personAvatar: personAvatar,
      mainContent: _GdsProfileMainContent(
        nickName: nickName,
        secondaryContent: followUserInfo,
      ),
      trailing: _buildDualActions(primaryActionButton, secondaryActionButton),
    );
  }
}
