import 'package:flutter/widgets.dart';
import 'package:gds_foundation/gds_foundation.dart';

/// Empty state 컴포넌트 크기입니다.
///
/// Figma 시안 기준 `xl`, `md` 두 가지 레이아웃을 제공합니다.
enum GdsEmptyStateSize {
  xl,
  md;

  TextStyle get titleStyle => switch (this) {
    GdsEmptyStateSize.xl => GdsTypography.title3,
    GdsEmptyStateSize.md => GdsTypography.subtitle1,
  };

  TextStyle get descriptionStyle => switch (this) {
    GdsEmptyStateSize.xl => GdsTypography.body1R,
    GdsEmptyStateSize.md => GdsTypography.body2R,
  };

  double get titleTopSpacing => switch (this) {
    GdsEmptyStateSize.xl => GdsSpacing.spacing24,
    GdsEmptyStateSize.md => GdsSpacing.spacing16,
  };
}

/// Empty state UI 컴포넌트입니다.
///
/// 기본적으로 일러스트 + 제목 조합을 제공하며,
/// 설명 텍스트와 액션 위젯을 선택적으로 추가할 수 있습니다.
///
/// 액션 버튼은 `GdsSolidButton`, `GdsTextButton` 등을 외부에서 주입해
/// 시안의 Title / Content / Solid / Outline 조합을 모두 표현할 수 있습니다.
class GdsEmptyState extends StatelessWidget {
  const GdsEmptyState({
    super.key,
    required this.title,
    required this.icon,
    this.size = GdsEmptyStateSize.xl,
    this.description,
    this.action,
    this.maxDescriptionLines = 2,
  });

  final GdsEmptyStateSize size;
  final String title;
  final GdsIcon icon;
  final String? description;

  /// 버튼/링크 등 하단 액션 영역입니다.
  final Widget? action;
  final int maxDescriptionLines;

  bool get _hasDescription => description != null && description!.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: GdsSpacing.spacing72),
      constraints: BoxConstraints(maxWidth: 375),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon.build(width: 60, height: 60),
          SizedBox(height: size.titleTopSpacing),
          Text(
            title,
            textAlign: TextAlign.center,
            style: size.titleStyle.copyWith(color: colors.text.grayBold),
          ),
          if (_hasDescription) ...[
            SizedBox(height: GdsSpacing.spacing12),
            Text(
              description!,
              maxLines: maxDescriptionLines,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: size.descriptionStyle.copyWith(
                color: colors.text.grayBold,
              ),
            ),
          ],
          if (action != null) ...[
            SizedBox(height: GdsSpacing.spacing24),
            action!,
          ],
        ],
      ),
    );
  }
}
