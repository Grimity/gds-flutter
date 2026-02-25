part of '../../gds_user_item.dart';

class GdsCommentDeletedUserItem extends GdsUserItem {
  const GdsCommentDeletedUserItem({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: GdsSpacing.spacing8),
      child: Text(
        '삭제된 댓글입니다.',
        style: GdsTypography.label6.copyWith(color: colors.text.graySubtle),
      ),
    );
  }
}
