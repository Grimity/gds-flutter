part of '../../gds_user_item.dart';

class GdsLinkMainUserItem extends GdsUserItem {
  final GdsIcon icon;
  final String siteText;

  const GdsLinkMainUserItem({
    super.key,
    required this.icon,
    required this.siteText,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: GdsSpacing.spacing4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: GdsSpacing.spacing4,
        children: [
          icon.build(
            width: GdsIconSize.v20,
            height: GdsIconSize.v20,
          ),
          Text(
            siteText,
            style: GdsTypography.label5.copyWith(color: colors.text.grayBold),
          ),
        ],
      ),
    );
  }
}
