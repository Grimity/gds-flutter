import 'package:flutter/widgets.dart';
import 'package:gds_components/gds_components.dart';
import 'package:gds_foundation/gds_foundation.dart';

enum GdsBottomSheetType {
  primary("Primary"),
  secondary("Secondary"),
  tertiary("Tertiary"),
  twoButton("2 Button");

  final String displayName;
  const GdsBottomSheetType(this.displayName);
}

class GdsBottomSheet extends StatelessWidget {
  const GdsBottomSheet({
    super.key,
    required this.type,
    required this.title,
    required this.child,
    required this.onClose,
    this.primaryLabel,
    this.secondaryLabel,
    this.onPrimaryTap,
    this.onSecondaryTap,
  });

  final GdsBottomSheetType type;
  final String title;
  final Widget child;
  final VoidCallback onClose;
  final String? primaryLabel;
  final String? secondaryLabel;
  final VoidCallback? onPrimaryTap;
  final VoidCallback? onSecondaryTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _Header(title: title, onClose: onClose),
        Padding(
          padding: EdgeInsets.only(
            top: GdsSpacing.spacing8,
            left: GdsSpacing.spacing20,
            right: GdsSpacing.spacing20,
            bottom: GdsSpacing.spacing20,
          ),
          child: Column(
            spacing: GdsSpacing.spacing20,
            children: [
              child,

              if (type != GdsBottomSheetType.tertiary)
                Row(
                  spacing: GdsSpacing.spacing8,
                  children: [
                    if (type == GdsBottomSheetType.primary
                     || type == GdsBottomSheetType.twoButton) 
                      Expanded(
                        child: GdsSolidButton(
                          size: GdsSolidButtonSize.large,
                          text: primaryLabel!,
                          expanded: true,
                          onPressed: onPrimaryTap,
                        ),
                      ),

                    if (type == GdsBottomSheetType.secondary
                     || type == GdsBottomSheetType.twoButton)
                      Expanded(
                        child: GdsOutlinedButton(
                          size: GdsOutlinedButtonSize.large,
                          text: secondaryLabel!,
                          expanded: true,
                          onPressed: onSecondaryTap,
                        ),
                      ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    super.key,
    required this.title,
    required this.onClose,
  });

  final String title;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: GdsSpacing.spacing20),
      height: GdsSpacing.spacing56,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: GdsSpacing.spacing12,
        children: [
          GdsIcon.chevronLeftTightThick.build(
            color: colors.icon.grayBold,
            width: GdsSpacing.spacing12,
            height: GdsSpacing.spacing24,
          ),
          Expanded(
            child: Text(
              title,
              style: GdsTypography.title3.copyWith(color: colors.text.grayBold),
            ),
          ),
          GdsIconButton(icon: GdsIcon.xMark, onPressed: onClose),
        ],
      ),
    );
  }
}
