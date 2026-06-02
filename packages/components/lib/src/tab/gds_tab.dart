import 'package:flutter/material.dart';
import 'package:gds_components/src/common/common.dart';
import 'package:gds_foundation/gds_foundation.dart';

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
  const GdsTab({super.key, required this.items, required this.index, this.size = GdsTabSize.lg});

  /// 탭 아이템 리스트
  final List<GdsTabItem> items;

  /// 선택된 탭 인덱스
  final int index;

  final GdsTabSize size;

  @override
  State<GdsTab> createState() => _GdsTabState();
}

class _GdsTabState extends State<GdsTab> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    /*
      BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colors.border.grayBold,
            width: 2,
          ),
        ),
      ),
    */

    return Stack(
      children: [
        // 탭 하단의 구분선
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 1,
              color: colors.border.graySubtle,
            ),
          ),
        ),

        // 탭 아이템 리스트
        SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final item in widget.items)
                  _TabItem(
                    item: item,
                    size: widget.size,
                    isSelected: widget.index == widget.items.indexOf(item),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.item,
    required this.size,
    required this.isSelected,
  });

  final GdsTabItem item;
  final GdsTabSize size;
  final bool isSelected;

  /// 탭 크기별 텍스트 스타일
  TextStyle get _textStyle {
    return switch (size) {
      GdsTabSize.lg => GdsTypography.subtitle1,
      GdsTabSize.md => GdsTypography.label1,
      GdsTabSize.sm => GdsTypography.label3,
    };
  }

  /// 탭 크기별 수평 패딩
  double get _horizontalPadding {
    return switch (size) {
      GdsTabSize.lg => GdsSpacing.spacing12,
      GdsTabSize.md => GdsSpacing.spacing10,
      GdsTabSize.sm => GdsSpacing.spacing8,
    };
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return GdsGesture(
      onTap: item.onTap,
      child: Container(
        padding: EdgeInsets.only(
          top: GdsSpacing.spacing12,
          left: _horizontalPadding,
          right: _horizontalPadding,
          bottom: GdsSpacing.spacing16,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: colors.border.grayBold,
              width: 2,
              style: isSelected ? BorderStyle.solid : BorderStyle.none,
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: GdsSpacing.spacing6,
          children: [
            Text(
              item.label,
              // 선택된 탭은 grayBold, 선택되지 않은 탭은 graySubtle
              style: _textStyle.copyWith(
                color: isSelected ? colors.text.grayBold : colors.text.graySubtle,
              ),
            ),

            if (item.badge != null)
              Text(
                item.badge!,
                // 선택된 탭은 primaryNormal, 선택되지 않은 탭은 graySubtle
                style: _textStyle.copyWith(
                  color: isSelected ? colors.text.primaryNormal : colors.text.graySubtle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
