import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 에디터 패널에서 사용하는 옵션 버튼 모음.
abstract class GdsEditorPanelButton {
  /// 글꼴 스타일을 표시하는 버튼 위젯.
  static Widget text({
    Key? key,
    required GdsTypography typography,
    required String title,
    required String label,
    required bool selected,
    required VoidCallback onTap,
    double maxWidth = 110,
  }) {
    return GdsGesture(
      key: key,
      onTap: selected ? null : onTap,
      child: GdsContainer(
        width: .infinity,
        height: 80,
        maxWidth: maxWidth,
        color: .surfaceBase,
        radius: .sm,
        child: Column(
          crossAxisAlignment: .center,
          mainAxisAlignment: .center,
          spacing: 8,
          children: [
            // 제목 표시
            GdsContainer(
              height: 32,
              alignment: .center,
              child: GdsText(
                title,
                color: selected ? .textPrimaryNormal : .textGrayNormal,
                style: typography,
              ),
            ),

            // 라벨 표시
            GdsText(
              label,
              style: .label6,
              color: selected ? .textPrimaryNormal : .textGrayNormal,
            ),
          ],
        ),
      ),
    );
  }

  /// 아이콘과 라벨을 표시하는 버튼 위젯.
  static Widget icon({
    Key? key,
    required GdsIcon icon,
    required String label,
    required bool selected,
    required VoidCallback onTap,
    double maxWidth = 110,
  }) {
    return GdsGesture(
      key: key,
      onTap: selected ? null : onTap,
      child: GdsContainer(
        width: .infinity,
        height: 80,
        maxWidth: maxWidth,
        color: .surfaceBase,
        radius: .sm,
        child: Center(
          child: Column(
            mainAxisAlignment: .center,
            spacing: 8,
            children: [
              // 아이콘 표시
              icon.build(
                size: 24,
                color: selected ? .iconPrimaryNormal : .iconGrayNormal,
              ),

              // 라벨 표시
              GdsText(
                label,
                style: .label6,
                color: selected ? .textPrimaryNormal : .textGrayNormal,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 글자색을 표시하는 버튼 위젯.
  static Widget fontColor({
    Key? key,
    required GdsColor color,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GdsGesture(
      key: key,
      onTap: selected ? null : onTap,
      child: GdsContainer(
        width: 40,
        height: 40,
        alignment: .center,
        child: GdsContainer(
          width: 26,
          height: 26,
          color: color,
          shape: .circle,
          border: selected ? .all(color: .borderGrayNormal) : null,
        ),
      ),
    );
  }

  /// 글자 배경색을 표시하는 버튼 위젯.
  static Widget fontBgColor({
    Key? key,
    required GdsColor backgroundColor,
    required GdsColor foregroundColor,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GdsGesture(
      key: key,
      onTap: selected ? null : onTap,
      child: GdsContainer(
        width: 32,
        height: 32,
        margin: .all(4),
        radius: .xs,
        color: selected ? .surfaceGraySubtler : null,
        child: GdsIcon.fontBg.build(
          size: 24,
          colorMap: {
            'background': backgroundColor,
            'foreground': foregroundColor,
          },
        ),
      ),
    );
  }
}
