import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 제목과 메시지 그리고 액션 버튼을 표시하는 알림 팝업 위젯.
@GdsSupportedSizes([.xl, .md])
class GdsAlert extends StatelessWidget {
  const new({
    super.key,
    required this.size,
    required this.title,
    required this.description,
    this.illust,
    this.primaryButton,
    this.secondaryButton,
  });

  final GdsSize size;
  final String title;
  final String description;
  final GdsIcon? illust;
  final GdsTextButtonAction? primaryButton;
  final GdsTextButtonAction? secondaryButton;

  @override
  Widget build(BuildContext context) {
    final hasIllust = illust != null;
    final hasPrimaryButton = primaryButton != null;
    final hasSecondaryButton = secondaryButton != null;

    return GdsContainer(
      minWidth: size.when(xl: 400, md: 320),
      maxWidth: size.when(xl: 400, md: 360),
      radius: .xl,
      padding: .only(top: 32, bottom: 16, left: 16, right: 16),
      border: .all(color: .borderGraySubtler),
      shadow: .level2,
      color: .surfaceBase,
      child: Column(
        mainAxisSize: .min,
        spacing: size.when(xl: 28, md: 20),
        children: [
          Column(
            crossAxisAlignment: .center,
            mainAxisSize: .min,
            spacing: 16,
            children: [
              // 일러스트 표시
              if (hasIllust) ...[
                illust!.build(size: 60),
              ],

              // 제목 표시
              GdsText(
                title,
                color: .textGrayBold,
                style: size.when(xl: .title2, md: .subtitle1),
              ),

              // 설명 표시
              GdsText(
                description,
                color: .textGrayBold,
                style: size.when(xl: .body1R, md: .body2R),
                maxLines: 2,
                overflow: .ellipsis,
                textAlign: .center,
              ),
            ],
          ),

          Row(
            spacing: 8,
            children: [
              // 보조 버튼 표시
              if (hasSecondaryButton) ...[
                Expanded(
                  child: GdsButton.text(
                    type: .outlined,
                    size: size.when(xl: .lg, md: .md),
                    label: secondaryButton!.label,
                    onTap: secondaryButton!.onTap,
                    mainAxisSize: .max,
                  ),
                ),
              ],

              // 주 버튼 표시
              if (hasPrimaryButton) ...[
                Expanded(
                  child: GdsButton.text(
                    type: .solid,
                    size: size.when(xl: .lg, md: .md),
                    label: primaryButton!.label,
                    onTap: primaryButton!.onTap,
                    mainAxisSize: .max,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  /// 알림 팝업을 오버레이에 표시합니다.
  Future<T?> open<T>(BuildContext context) {
    final route = GdsPopupRoute<T>(
      barrierDismissible: false,
      child: this,
    );

    return Navigator.of(context).push(route);
  }
}
