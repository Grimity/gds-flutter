import 'package:flutter/widgets.dart';
import 'package:gds_components/src/button/button.dart';
import 'package:gds_components/src/popup/overlay/gds_popup_route.dart';
import 'package:gds_foundation/gds_foundation.dart';

enum GdsAlertType {
  illust,
  content,
  normal,
}

enum GdsAlertSize {
  xl,
  md,
}

/// ```dart
/// final alert = GdsAlert(...);
/// alert.open(context);
/// ```
class GdsAlert extends StatelessWidget {
  const GdsAlert({
    super.key,
    required this.type,
    required this.size,
    required this.title,
    required this.description,
    this.primaryLabel = 'label',
    this.secondaryLabel = 'label',
    this.onPrimaryTap,
    this.onSecondaryTap,
  });

  final GdsAlertType type;
  final GdsAlertSize size;
  final String title;
  final String description;
  final String primaryLabel;
  final String secondaryLabel;
  final VoidCallback? onPrimaryTap;
  final VoidCallback? onSecondaryTap;

  static const int maxLines = 2;

  TextStyle get titleStyle {
    return switch (size) {
      GdsAlertSize.xl => GdsTypography.title2,
      GdsAlertSize.md => GdsTypography.subtitle1,
    };
  }

  TextStyle get descriptionStyle {
    return switch (size) {
      GdsAlertSize.xl => GdsTypography.body1R,
      GdsAlertSize.md => GdsTypography.body2R,
    };
  }

  GdsSolidButtonSize get solidButtonSize {
    return switch (size) {
      GdsAlertSize.xl => GdsSolidButtonSize.large,
      GdsAlertSize.md => GdsSolidButtonSize.regular,
    };
  }

  GdsOutlinedButtonSize get outlinedButtonSize {
    return switch (size) {
      GdsAlertSize.xl => GdsOutlinedButtonSize.large,
      GdsAlertSize.md => GdsOutlinedButtonSize.regular,
    };
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return Container(
      constraints: BoxConstraints(
        maxWidth: switch (size) {
          GdsAlertSize.xl => 400,
          GdsAlertSize.md => 360,
        }
      ),
      padding: EdgeInsets.only(
        top: GdsSpacing.spacing32,
        left: GdsSpacing.spacing16,
        right: GdsSpacing.spacing16,
        bottom: GdsSpacing.spacing16,        
      ),
      decoration: BoxDecoration(
        color: colors.surface.base,
        borderRadius: BorderRadius.circular(GdsRadius.xl),
        boxShadow: GdsShadows.level2,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: switch (size) {
          GdsAlertSize.xl => GdsSpacing.spacing28,
          GdsAlertSize.md => GdsSpacing.spacing20,
        },
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (type == GdsAlertType.illust) ... [
                GdsIcon.success.build(width: 60, height: 60),
                SizedBox(height: GdsSpacing.spacing16),
              ],
              Text(
                title,
                style: titleStyle.copyWith(color: colors.text.grayBold),
              ),
              SizedBox(
                height: switch (size) {
                  GdsAlertSize.xl => GdsSpacing.spacing10,
                  GdsAlertSize.md => GdsSpacing.spacing6,
                },
              ),
              Text(
                description,
                maxLines: maxLines,
                textAlign: TextAlign.center,
                style: descriptionStyle.copyWith(color: colors.text.grayBold),
              ),
            ],
          ),
          Row(
            spacing: GdsSpacing.spacing6,
            children: [
              if (type != GdsAlertType.normal) ... [
                Expanded(
                  child: GdsOutlinedButton(
                    size: outlinedButtonSize,
                    text: secondaryLabel,
                    expanded: true,
                    onPressed: onSecondaryTap,
                  ),
                ),
              ],
              Expanded(
                child: GdsSolidButton(
                  size: solidButtonSize,
                  text: primaryLabel,
                  expanded: true,
                  onPressed: onPrimaryTap,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 오버레이에 팝업을 화면에 표시합니다.
  Future<T?> open<T>(BuildContext context) {
    return Navigator.of(context).push(GdsPopupRoute<T>(child: this));
  }
}
