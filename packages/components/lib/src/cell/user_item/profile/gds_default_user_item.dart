part of '../../gds_user_item.dart';

class GdsDefaultUserItem extends GdsUserItem {
  final String nickName;
  final GdsPersonAvatar personAvatar;
  final GdsOutlinedButton? primaryActionButton;
  final GdsOutlinedButton? secondaryActionButton;

  const GdsDefaultUserItem({
    super.key,
    required this.nickName,
    required this.personAvatar,
    this.primaryActionButton,
    this.secondaryActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return _GdsProfileUserItemFrame(
      personAvatar: personAvatar,
      mainContent: _GdsProfileMainContent(nickName: nickName),
      trailing: _buildDualActions(primaryActionButton, secondaryActionButton),
    );
  }
}
