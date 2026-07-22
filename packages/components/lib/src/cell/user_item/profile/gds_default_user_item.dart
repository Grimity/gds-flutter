part of '../../gds_user_item.dart';

class GdsDefaultUserItem extends GdsUserItem {
  final String nickName;
  final GdsPersonAvatar personAvatar;
  final VoidCallback? onProfileTap;
  final Widget? primaryActionButton;
  final Widget? secondaryActionButton;

  const GdsDefaultUserItem({
    super.key,
    required this.nickName,
    required this.personAvatar,
    this.onProfileTap,
    this.primaryActionButton,
    this.secondaryActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return _GdsProfileUserItemFrame(
      onTap: onProfileTap,
      personAvatar: personAvatar,
      mainContent: _GdsProfileMainContent(nickName: nickName),
      trailing: _buildDualActions(primaryActionButton, secondaryActionButton),
    );
  }
}
