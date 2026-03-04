part of '../gds_list_item.dart';

class GdsSectionListItem extends GdsListItem {
  final String text;

  const GdsSectionListItem({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface.graySubtlest,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: GdsSpacing.spacing24,
          right: GdsSpacing.spacing16,
          top: GdsSpacing.spacing6,
          bottom: GdsSpacing.spacing6,
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GdsTypography.label6.copyWith(color: colors.text.grayNormal),
          ),
        ),
      ),
    );
  }
}
