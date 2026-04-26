import 'package:flutter/widgets.dart';
import 'package:gds_components/src/common/common.dart';
import 'package:gds_foundation/gds_foundation.dart';


class GdsModalResourceTitle extends StatelessWidget {
  const GdsModalResourceTitle({
    super.key,
    this.title = '제목',
    this.icon = GdsIcon.blank,
    this.showArrow = true,
    this.showButtonIcon = true,
    this.showCloseIcon = true,
    this.showTitle = true,
    this.onArrowTap,
    this.onButtonIconTap,
    this.onCloseTap,
  });

  final String title;
  final GdsIcon icon;
  final bool showArrow;
  final bool showButtonIcon;
  final bool showCloseIcon;
  final bool showTitle;
  final VoidCallback? onArrowTap;
  final VoidCallback? onButtonIconTap;
  final VoidCallback? onCloseTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return Container(
      height: GdsSpacing.spacing56,
      padding: EdgeInsets.symmetric(horizontal: GdsSpacing.spacing20),
      color: colors.surface.base,
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: GdsSpacing.spacing12,
              children: [
                if (showArrow)
                  GdsGesture(
                    onTap: onArrowTap,
                    child: GdsIcon.chevronLeftTightThick.build(
                      color: colors.icon.grayBold,
                      width: GdsSpacing.spacing12,
                      height: GdsSpacing.spacing24,
                    ),
                  ),
                if (showTitle)
                  Flexible(
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: GdsTypography.title3.copyWith(
                        color: colors.text.grayBold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            spacing: GdsSpacing.spacing4,
            children: [
              if (showButtonIcon)
                _ModalIconButton(
                  icon: icon,
                  onTap: onButtonIconTap,
                ),
              if (showCloseIcon)
                _ModalIconButton(
                  icon: GdsIcon.xMarkThick,
                  onTap: onCloseTap,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ModalIconButton extends StatelessWidget {
  const _ModalIconButton({
    required this.icon,
    this.onTap,
  });

  final GdsIcon icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return GdsGesture(
      onTap: onTap,
      child: SizedBox.square(
        dimension: GdsSpacing.spacing40,
        child: Center(
          child: icon.build(
            color: colors.icon.grayBold,
            width: GdsIconSize.v24,
            height: GdsIconSize.v24,
          ),
        ),
      ),
    );
  }
}
