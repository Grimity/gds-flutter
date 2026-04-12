import 'package:flutter/material.dart';
import 'package:gds_components/src/common/common.dart';
import 'package:gds_foundation/gds_foundation.dart';

/// 페이지네이션에서 페이지 번호를 이동하는 버튼을 표시하는 컴포넌트입니다.
class GdsNavigation extends StatelessWidget {
  const GdsNavigation({
    super.key,
    required this.index,
    required this.pageCount,
    required this.maxCount,
    required this.onPageChanged,
  });

  /// 페이지네이션에서 현재 페이지 번호입니다.
  final int index;

  /// 페이지네이션에서 총 페이지 수입니다.
  final int pageCount;

  /// 페이지네이션에서 한 번에 표시할 최대 페이지 버튼 수입니다.
  final int maxCount;

  final Function(int) onPageChanged;

  @override
  Widget build(BuildContext context) {
    assert(index >= 0, 'index는 0 이상이어야 합니다.');
    assert(pageCount > 0, 'pageCount는 0보다 커야 합니다.');
    assert(maxCount > 0, 'maxCount는 0보다 커야 합니다.');
    assert(index < pageCount && index < pageCount);

    final int half = maxCount ~/ 2;

    int startPage = index - half;
    int endPage = startPage + maxCount - 1;

    // 왼쪽 경계를 벗어난 경우
    if (startPage < 0) {
      startPage = 0;
      endPage = maxCount - 1;
    }

    // 오른쪽 경계를 벗어난 경우
    if (endPage >= pageCount) {
      endPage = pageCount - 1;
      startPage = (endPage - maxCount + 1).clamp(0, pageCount - 1);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: GdsSpacing.spacing4,
      children: [
        // 이전 페이지로 이동하는 버튼
        _IconButton(
          icon: GdsIcon.chevronLeft,
          isActive: index > 0,
          onTap: index > 0 ? () => onPageChanged(index - 1) : null,
        ),

        // 페이지 번호 버튼 생성
        for (int i = startPage; i <= endPage; i++) ...[
          _PageButton(
            label: '${i + 1}',
            isActive: index == i,
            onTap: () => onPageChanged(i),
          ),
        ],

        // 다음 페이지로 이동하는 버튼
        _IconButton(
          icon: GdsIcon.chevronRight,
          isActive: index < pageCount - 1,
          onTap: index < pageCount - 1 ? () => onPageChanged(index + 1) : null,
        ),
      ],
    );
  }
}

/// 페이지네이션에서 이전 페이지, 다음 페이지로 이동하는 버튼입니다.
class _IconButton extends StatelessWidget {
  const _IconButton({
    super.key,
    required this.icon,
    required this.isActive,
    this.onTap,
  });

  /// 버튼에 표시할 아이콘입니다.
  final GdsIcon icon;

  /// 버튼이 활성화 상태인지 여부입니다.
  final bool isActive;

  /// 버튼이 탭되었을 때 호출되는 콜백입니다.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return GdsGesture(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(GdsSpacing.spacing4),
        child: icon.build(
          color: isActive ? colors.icon.grayBold : colors.icon.grayNormal,
        ),
      ),
    );
  }
}

/// 페이지네이션에서 페이지 번호를 표시하는 버튼입니다.
class _PageButton extends StatelessWidget {
  const _PageButton({
    super.key,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  /// 버튼에 표시할 페이지 번호입니다.
  final String label;

  /// 버튼이 활성화 상태인지 여부입니다.
  final bool isActive;

  /// 버튼이 탭되었을 때 호출되는 콜백입니다.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return GdsGesture(
      onTap: onTap,
      child: Container(
        width: GdsSpacing.spacing32,
        height: GdsSpacing.spacing32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(GdsRadius.sm),
          color: isActive ? colors.surface.graySubtler : null,
        ),
        child: Text(
          label,
          style: GdsTypography.label2.copyWith(
            color: isActive ? colors.text.grayBold : colors.text.grayNormal,
          ),
        ),
      ),
    );
  }
}
