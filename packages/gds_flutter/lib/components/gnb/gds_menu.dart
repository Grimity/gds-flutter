import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 각각의 메뉴 항목의 라벨과 콜백을 정의하는 레코드.
typedef GdsMenuItem = ({
  String label,
  VoidCallback onTap,
});

/// 내비게이션 활성화 시 하위 메뉴 목록을 보여주는 드롭다운 위젯입니다.
class GdsMenu extends StatelessWidget {
  /// 메뉴 항목 목록을 하나의 그룹으로 표시하는 위젯.
  GdsMenu({
    super.key,
    required List<GdsMenuItem> items,
  }) : groups = [items];

  /// 메뉴 항목 목록을 그룹별로 나누어 표시하는 위젯.
  const GdsMenu.group({
    super.key,
    required this.groups,
  });

  /// 그룹별로 묶은 메뉴 항목 목록.
  final List<List<GdsMenuItem>> groups;

  @override
  Widget build(BuildContext context) {
    return GdsContainer(
      width: 150,
      color: .surfaceBase,
      shadow: .level2,
      radius: .md,
      border: .all(color: .borderGraySubtler),
      padding: .symmetric(vertical: 6),
      clip: true,
      child: Column(
        mainAxisSize: .min,
        spacing: 8,
        children: [
          for (final (index, group) in groups.indexed) ...[
            // 첫 그룹을 제외한 각 그룹 앞에 구분선 표시
            if (index > 0) GdsDivider(variant: .secondary),

            // 그룹에 속한 메뉴 항목 표시
            for (final item in group)
              GdsListItem.text(
                size: .md,
                label: item.label,
                onTap: item.onTap,
              ),
          ],
        ],
      ),
    );
  }

  /// 오버레이에 메뉴를 화면에 표시합니다.
  Future<T?> open<T>(
    BuildContext context, {
    required LayerLink layerLink,
    required GdsMenuPosition position,
  }) {
    final route = GdsMenuRoute<T>(
      child: this,
      position: position,
      layerLink: layerLink,
    );

    return Navigator.push<T>(context, route);
  }
}
