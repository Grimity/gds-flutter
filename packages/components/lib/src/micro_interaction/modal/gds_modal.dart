import 'package:flutter/widgets.dart';
import 'package:gds_components/src/button/button.dart';
import 'package:gds_foundation/gds_foundation.dart';

import 'gds_modal_resource_title.dart';

/// Pop-up modal variants from the modal micro-interaction spec.
enum GdsModalResourceType { primary, secondary, tertiary, twoButton }

/// Pop-up modal resource.
///
/// Figma: `Pop Up/Modal`.
class GdsModalResource extends StatelessWidget {
  const GdsModalResource._({
    super.key,
    required this.type,
    required this.child,
    this.title = '제목',
    this.icon = GdsIcon.blank,
    this.primaryLabel = 'label',
    this.secondaryLabel = 'Label',
    this.onArrowTap,
    this.onButtonIconTap,
    this.onCloseTap,
    this.onPrimaryTap,
    this.onSecondaryTap,
    this.width = 400,
    this.height = 400,
  });

  factory GdsModalResource.primary({
    Key? key,
    required Widget child,
    String title = '제목',
    GdsIcon icon = GdsIcon.blank,
    String primaryLabel = 'label',
    VoidCallback? onArrowTap,
    VoidCallback? onButtonIconTap,
    VoidCallback? onCloseTap,
    VoidCallback? onPrimaryTap,
    double? width = 400,
    double? height = 400,
  }) {
    return GdsModalResource._(
      key: key,
      type: GdsModalResourceType.primary,
      title: title,
      icon: icon,
      primaryLabel: primaryLabel,
      onArrowTap: onArrowTap,
      onButtonIconTap: onButtonIconTap,
      onCloseTap: onCloseTap,
      onPrimaryTap: onPrimaryTap,
      width: width,
      height: height,
      child: child,
    );
  }

  factory GdsModalResource.secondary({
    Key? key,
    required Widget child,
    String title = '제목',
    GdsIcon icon = GdsIcon.blank,
    String secondaryLabel = 'Label',
    VoidCallback? onArrowTap,
    VoidCallback? onButtonIconTap,
    VoidCallback? onCloseTap,
    VoidCallback? onSecondaryTap,
    double? width = 400,
    double? height = 400,
  }) {
    return GdsModalResource._(
      key: key,
      type: GdsModalResourceType.secondary,
      title: title,
      icon: icon,
      secondaryLabel: secondaryLabel,
      onArrowTap: onArrowTap,
      onButtonIconTap: onButtonIconTap,
      onCloseTap: onCloseTap,
      onSecondaryTap: onSecondaryTap,
      width: width,
      height: height,
      child: child,
    );
  }

  factory GdsModalResource.tertiary({
    Key? key,
    required Widget child,
    String title = '제목',
    GdsIcon icon = GdsIcon.blank,
    VoidCallback? onArrowTap,
    VoidCallback? onButtonIconTap,
    VoidCallback? onCloseTap,
    double? width = 400,
    double? height = 400,
  }) {
    return GdsModalResource._(
      key: key,
      type: GdsModalResourceType.tertiary,
      title: title,
      icon: icon,
      onArrowTap: onArrowTap,
      onButtonIconTap: onButtonIconTap,
      onCloseTap: onCloseTap,
      width: width,
      height: height,
      child: child,
    );
  }

  factory GdsModalResource.twoButton({
    Key? key,
    required Widget child,
    String title = '제목',
    GdsIcon icon = GdsIcon.blank,
    String primaryLabel = 'label',
    String secondaryLabel = 'Label',
    VoidCallback? onArrowTap,
    VoidCallback? onButtonIconTap,
    VoidCallback? onCloseTap,
    VoidCallback? onPrimaryTap,
    VoidCallback? onSecondaryTap,
    double? width = 400,
    double? height = 400,
  }) {
    return GdsModalResource._(
      key: key,
      type: GdsModalResourceType.twoButton,
      title: title,
      icon: icon,
      primaryLabel: primaryLabel,
      secondaryLabel: secondaryLabel,
      onArrowTap: onArrowTap,
      onButtonIconTap: onButtonIconTap,
      onCloseTap: onCloseTap,
      onPrimaryTap: onPrimaryTap,
      onSecondaryTap: onSecondaryTap,
      width: width,
      height: height,
      child: child,
    );
  }

  final GdsModalResourceType type;
  final Widget child;
  final String title;
  final GdsIcon icon;
  final String primaryLabel;
  final String secondaryLabel;
  final VoidCallback? onArrowTap;
  final VoidCallback? onButtonIconTap;
  final VoidCallback? onCloseTap;
  final VoidCallback? onPrimaryTap;
  final VoidCallback? onSecondaryTap;
  final double? width;
  final double? height;

  bool get _hasAction => type != GdsModalResourceType.tertiary;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return Container(
      width: width,
      height: height,
      constraints: const BoxConstraints(
        maxWidth: 500,
        maxHeight: 760,
      ),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: colors.surface.base,
        border: Border.all(color: colors.border.graySubtler),
        borderRadius: BorderRadius.circular(GdsRadius.xl),
        boxShadow: GdsShadows.level2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GdsModalResourceTitle(
            title: title,
            icon: icon,
            onArrowTap: onArrowTap,
            onButtonIconTap: onButtonIconTap,
            onCloseTap: onCloseTap,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                top: GdsSpacing.spacing8,
                left: GdsSpacing.spacing20,
                right: GdsSpacing.spacing20,
                bottom: GdsSpacing.spacing20,
              ),
              child: child,
            ),
          ),
          if (_hasAction)
            Padding(
              padding: EdgeInsets.only(
                left: GdsSpacing.spacing20,
                right: GdsSpacing.spacing20,
                bottom: GdsSpacing.spacing20,
              ),
              child: _buildAction(),
            ),
        ],
      ),
    );
  }

  Widget _buildAction() {
    return switch (type) {
      GdsModalResourceType.primary => GdsSolidButton(
        size: GdsSolidButtonSize.large,
        text: primaryLabel,
        expanded: true,
        onPressed: onPrimaryTap,
      ),
      GdsModalResourceType.secondary => GdsOutlinedButton(
        size: GdsOutlinedButtonSize.large,
        text: secondaryLabel,
        expanded: true,
        onPressed: onSecondaryTap,
      ),
      GdsModalResourceType.twoButton => Row(
        spacing: GdsSpacing.spacing8,
        children: [
          Expanded(
            child: GdsOutlinedButton(
              size: GdsOutlinedButtonSize.large,
              text: secondaryLabel,
              expanded: true,
              onPressed: onSecondaryTap,
            ),
          ),
          Expanded(
            child: GdsSolidButton(
              size: GdsSolidButtonSize.large,
              text: primaryLabel,
              expanded: true,
              onPressed: onPrimaryTap,
            ),
          ),
        ],
      ),
      GdsModalResourceType.tertiary => const SizedBox.shrink(),
    };
  }
}
