import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 제목과 메시지 그리고 액션 버튼을 표시하는 알림 팝업 위젯.
@GdsSupportedSizes([.xl, .md])
class GdsAlert extends StatelessWidget {
  const new({
    super.key,
    this.size,
    required this.title,
    required this.description,
    this.illust,
    this.primaryButton,
    this.secondaryButton,
  });

  final GdsSize? size;
  final String title;
  final String description;
  final GdsIcon? illust;
  final GdsTextButtonAction? primaryButton;
  final GdsTextButtonAction? secondaryButton;

  @override
  Widget build(BuildContext context) {
    final hasIllust = illust != null;

    // 크기를 지정하지 않은 경우, 현재 기기에 맞는 기본 크기를 적용.
    final GdsSize sizeByDevice = context.whenDevice(
      mobile: .md,
      tablet: .xl,
    );

    final GdsSize size = this.size ?? sizeByDevice;

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
              if (secondaryButton case final action?) ...[
                Expanded(
                  child: GdsButton.text(
                    type: .outlined,
                    size: size.when(xl: .lg, md: .md),
                    label: action.label,
                    onTap: action.onTap,
                    status: action.status,
                    layerLink: action.layerLink,
                    mainAxisSize: .max,
                  ),
                ),
              ],

              // 주 버튼 표시
              if (primaryButton case final action?) ...[
                Expanded(
                  child: GdsButton.text(
                    type: .solid,
                    size: size.when(xl: .lg, md: .md),
                    label: action.label,
                    onTap: action.onTap,
                    status: action.status,
                    layerLink: action.layerLink,
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
  static Future<T?> show<T>(
    BuildContext context, {
    required WidgetBuilder builder,
  }) {
    final route = GdsPopupRoute<T>(
      barrierDismissible: false,
      child: Builder(builder: builder),
    );

    return Navigator.of(context).push(route);
  }
}
