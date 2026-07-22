part of '../../gds_user_item.dart';

class GdsRadioUserItem extends GdsUserItem {
  final String nickName;
  final GdsPersonAvatar personAvatar;
  final String userId;
  final GdsRadioButton radioButton;
  final VoidCallback? onProfileTap;

  const GdsRadioUserItem({
    super.key,
    required this.nickName,
    required this.personAvatar,
    required this.userId,
    required this.radioButton,
    this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return _GdsProfileUserItemFrame(
      onTap: onProfileTap,
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
      trailing: radioButton,
    );
  }
}
