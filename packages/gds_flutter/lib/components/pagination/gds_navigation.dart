import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 페이지네이션에서 페이지를 이동하는 버튼을 표시하는 위젯.
class GdsNavigation extends StatelessWidget {
  const GdsNavigation({
    super.key,
    required this.index,
    required this.pageCount,
    required this.maxCount,
    required this.onChanged,
  });

  /// 현재 페이지 번호.
  final int index;

  /// 총 페이지 수.
  final int pageCount;

  /// 한 번에 표시할 최대 페이지 버튼 수.
  final int maxCount;

  /// 변경된 인덱스를 전달하는 콜백.
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    assert(index >= 0, 'index는 0 이상이어야 합니다.');
    assert(pageCount > 0, 'pageCount는 0보다 커야 합니다.');
    assert(maxCount > 0, 'maxCount는 0보다 커야 합니다.');
    assert(index < pageCount && index < pageCount);

    final int half = maxCount ~/ 2;
    int startPage = index - half;
    int endPage = startPage + maxCount - 1;

    // 좌측 경계를 벗어난 경우.
    if (startPage < 0) {
      startPage = 0;
      endPage = maxCount - 1;
    }

    // 우측 경계를 벗어난 경우.
    if (endPage >= pageCount) {
      endPage = pageCount - 1;
      startPage = (endPage - maxCount + 1).clamp(0, pageCount - 1);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 4,
      children: [
        // 이전 페이지 버튼 표시
        _IconButton(
          icon: GdsIcon.chevronLeft,
          onTap: index > 0 ? () => onChanged(index - 1) : null,
          active: index > 0,
        ),

        // 페이지 번호 버튼 표시
        for (int i = startPage; i <= endPage; i++) ...[
          _PageButton(
            label: '${i + 1}',
            active: index == i,
            onTap: () => onChanged(i),
          ),
        ],

        // 다음 페이지 버튼 표시
        _IconButton(
          icon: GdsIcon.chevronRight,
          onTap: index < pageCount - 1 ? () => onChanged(index + 1) : null,
          active: index < pageCount - 1,
        ),
      ],
    );
  }
}

/// 이전 혹은 다음 페이지로 이동하는 버튼 위젯.
class _IconButton extends StatelessWidget {
  const _IconButton({
    required this.icon,
    required this.onTap,
    required this.active,
  });

  final GdsIcon icon;
  final VoidCallback? onTap;
  final bool active;

  /// 이동 버튼의 가로 및 세로 크기.
  static final size = GdsControlSize.sm.value;

  @override
  Widget build(BuildContext context) {
    return GdsGesture(
      key: key,
      onTap: onTap,
      child: GdsContainer(
        width: size,
        height: size,
        alignment: .center,
        child: icon.build(
          size: 24,
          color: active ? .iconGrayBold : .iconGrayNormal,
        ),
      ),
    );
  }
}

/// 페이지 번호를 표시하는 버튼 위젯.
class _PageButton extends StatelessWidget {
  const _PageButton({
    required this.label,
    required this.onTap,
    required this.active,
  });

  final String label;
  final VoidCallback? onTap;
  final bool active;

  /// 페이지 번호 버튼의 가로 및 세로 크기.
  static final size = GdsControlSize.sm.value;

  @override
  Widget build(BuildContext context) {
    return GdsGesture(
      key: key,
      onTap: onTap,
      child: GdsContainer(
        width: size,
        height: size,
        radius: .sm,
        color: active ? .surfaceGraySubtler : null,
        alignment: .center,
        child: GdsText(
          label,
          style: .label2,
          color: active ? .textGrayBold : .textGrayNormal,
        ),
      ),
    );
  }
}
