import 'package:flutter/material.dart';
import 'package:gds_components/src/common/common.dart';
import 'package:gds_components/src/tab/gds_render_tab.dart';
import 'package:gds_foundation/gds_foundation.dart';
import 'package:collection/collection.dart';

enum GdsTabSize {
  lg,
  md,
  sm,
}

class GdsTabItem {
  const GdsTabItem({
    required this.label,
    required this.onTap,
    this.badge,
  });

  final String label;
  final VoidCallback onTap;
  final String? badge;
}

class GdsTab extends StatefulWidget {
  const GdsTab({
    super.key,
    required this.items,
    required this.controller,
    this.showBorder = true,
    this.size = GdsTabSize.lg,
  });

  /// 탭 아이템 리스트
  final List<GdsTabItem> items;

  /// 선택된 탭 인덱스
  final TabController controller;

  /// 탭 하단의 구분선을 표시할지 여부
  final bool showBorder;

  /// 탭 네비게이션 크기
  final GdsTabSize size;

  @override
  State<GdsTab> createState() => _GdsTabState();
}

class _GdsTabState extends State<GdsTab> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ListenableBuilder(
          listenable: widget.controller.animation!,
          builder: (context, child) {
            return GdsRenderTab(
              indicatorColor: colors.border.grayBold,
              dividerColor: widget.showBorder ? colors.border.graySubtle : GdsColors.transparent,
              offset: widget.controller.index + widget.controller.offset,
              children: [
                ...widget.items.mapIndexed((index, item) {
                  return _TabItem(
                    item: item,
                    size: widget.size,
                    index: index,
                    controller: widget.controller,
                  );
                }),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.item,
    required this.size,
    required this.index,
    required this.controller,
  });

  final GdsTabItem item;
  final GdsTabSize size;
  final int index;
  final TabController controller;

  TextStyle get _textStyle {
    return switch (size) {
      GdsTabSize.lg => GdsTypography.subtitle1,
      GdsTabSize.md => GdsTypography.label1,
      GdsTabSize.sm => GdsTypography.label3,
    };
  }

  double get _horizontalPadding {
    return switch (size) {
      GdsTabSize.lg => GdsSpacing.spacing12,
      GdsTabSize.md => GdsSpacing.spacing10,
      GdsTabSize.sm => GdsSpacing.spacing8,
    };
  }

  double get _activatedProgress {
    final double absolutePosition = controller.index + controller.offset;
    final double distance = (absolutePosition - index).abs();
    final double progress = 1.0 - distance;

    return progress.clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final progress = _activatedProgress;
    final isSelected = progress.abs() == 1.0;

    final labelColor = Color.lerp(
      colors.text.graySubtle,
      colors.text.grayBold,
      progress,
    );

    final badgeColor = Color.lerp(
      colors.text.graySubtle,
      colors.text.primaryNormal,
      progress,
    );

    return GdsGesture(
      onTap: isSelected ? null : item.onTap,
      child: Container(
        padding: EdgeInsets.only(
          top: GdsSpacing.spacing12,
          left: _horizontalPadding,
          right: _horizontalPadding,
          bottom: GdsSpacing.spacing16,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: GdsSpacing.spacing6,
          children: [
            Text(
              item.label,
              style: _textStyle.copyWith(color: labelColor),
            ),
            if (item.badge != null)
              Text(
                item.badge!,
                style: _textStyle.copyWith(color: badgeColor),
              ),
          ],
        ),
      ),
    );
  }
}
