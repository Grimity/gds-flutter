part of '../../gds_user_item.dart';

class GdsIdUserItem extends GdsUserItem {
  final String nickName;
  final GdsPersonAvatar personAvatar;
  final String userId;
  final GdsOutlinedButton? primaryActionButton;
  final GdsOutlinedButton? secondaryActionButton;

  const GdsIdUserItem({
    super.key,
    required this.nickName,
    required this.personAvatar,
    required this.userId,
    this.primaryActionButton,
    this.secondaryActionButton,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return _GdsProfileUserItemFrame(
      personAvatar: personAvatar,
      mainContent: _GdsProfileMainContent(
        nickName: nickName,
        secondaryContent: Text(
          userId,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GdsTypography.label6.copyWith(color: colors.text.graySubtle),
        ),
      ),
      trailing: _buildDualActions(primaryActionButton, secondaryActionButton),
    );
  }
}
