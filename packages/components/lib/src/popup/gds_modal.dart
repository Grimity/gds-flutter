import 'package:flutter/widgets.dart';
import 'package:gds_components/src/button/button.dart';
import 'package:gds_components/src/micro_interaction/modal/gds_modal_interaction.dart';
import 'package:gds_foundation/gds_foundation.dart';

class GdsModalAction {
  const GdsModalAction({
    required this.icon,
    required this.onTap,
  });

  final GdsIcon icon;
  final VoidCallback onTap;
}

/// ```dart
/// final modal = GdsModal(...);
/// modal.open(context);
/// ```
class GdsModal extends StatelessWidget {
  const GdsModal({
    super.key,
    required this.title,
    this.primaryLabel = 'Label',
    this.secondaryLabel = 'Label',
    this.onClose,
    this.onPrimary,
    this.onSecondary,
    this.action,
    required this.body,
  });

  final String title;
  final String primaryLabel;
  final String secondaryLabel;
  final VoidCallback? onClose;
  final VoidCallback? onPrimary;
  final VoidCallback? onSecondary;
  final GdsModalAction? action;
  final Container body;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return Container(
      constraints: BoxConstraints(
        maxWidth: 500,
        maxHeight: 760,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(GdsRadius.xl),
        boxShadow: GdsShadows.level2,
        color: colors.surface.base,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _Header(
            title: title,
            onClose: onClose ?? () => Navigator.pop(context),
            action: action,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: GdsSpacing.spacing8,
              left: GdsSpacing.spacing20,
              right: GdsSpacing.spacing20,
              bottom: GdsSpacing.spacing20,
            ),
            child: body,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: GdsSpacing.spacing20,
              right: GdsSpacing.spacing20,
              bottom: GdsSpacing.spacing20,
            ),
            child: Row(
              spacing: GdsSpacing.spacing8,
              children: [
                if (onPrimary != null) ...[
                  Expanded(
                    child: GdsSolidButton(
                      size: GdsSolidButtonSize.large,
                      text: primaryLabel,
                      onPressed: onPrimary,
                      expanded: true,
                    ),
                  ),
                ],
                if (onSecondary != null) ...[
                  Expanded(
                    child: GdsOutlinedButton(
                      size: GdsOutlinedButtonSize.large,
                      text: secondaryLabel,
                      onPressed: onSecondary,
                      expanded: true,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 오버레이에 팝업을 화면에 표시합니다.
  Future<T?> open<T>(
    BuildContext context, {
    bool isBarrierDismissible = false,
  }) {
    return GdsModalInteraction.open<T>(
      context,
      child: this,
      isBarrierDismissible: isBarrierDismissible,
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.title,
    required this.onClose,
    this.action,
  });

  final String title;
  final VoidCallback onClose;
  final GdsModalAction? action;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return Container(
      height: GdsSpacing.spacing56,
      padding: EdgeInsets.symmetric(horizontal: GdsSpacing.spacing20),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            spacing: GdsSpacing.spacing12,
            children: [
              GdsIcon.chevronLeft.build(
                color: colors.icon.grayBold,
              ),
              Text(
                title,
                style: GdsTypography.title3.copyWith(color: colors.text.grayBold),
              ),
            ],
          ),
          Row(
            spacing: GdsSpacing.spacing4,
            children: [
              if (action != null) ...[
                GdsIconButton(icon: action!.icon, onPressed: action!.onTap),
              ],
              GdsIconButton(icon: GdsIcon.xMark, onPressed: onClose),
            ],
          ),
        ],
      ),
    );
  }
}
