import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:gds_flutter/gds_flutter.dart';

///
@GdsSupportedSizes([.xl, .md])
class GdsEmptyState extends StatelessWidget {
  const new({
    super.key,
    this.size,
    required this.illust,
    required this.title,
    this.description,
    this.action,
  });

  final GdsSize? size;
  final GdsIcon illust;
  final String title;
  final String? description;
  final GdsTextButtonAction? action;

  @override
  Widget build(BuildContext context) {
    assert(illust.type != .semantic);
    final hasDescription = description != null;
    final hasAction = action != null;
    final actionType = action?.type ?? .solid;

    // 크기를 지정하지 않은 경우, 현재 기기에 맞는 기본 크기를 적용.
    final GdsSize sizeByDevice = context.whenDevice(
      mobile: .md,
      tablet: .xl,
    );

    final GdsSize size = this.size ?? sizeByDevice;

    return Padding(
      padding: .symmetric(vertical: 72),
      child: Column(
        crossAxisAlignment: .center,
        mainAxisSize: .min,
        children: [
          // 상단에 일러스트 표시
          illust.build(size: 60),

          // 본문 간의 간격.
          size.when(
            xl: const Gap(24),
            md: const Gap(16),
          ),

          Column(
            crossAxisAlignment: .center,
            spacing: 12,
            children: [
              // 제목 표시
              GdsText(
                title,
                color: .textGrayBold,
                style: size.when(xl: .title3, md: .subtitle1),
              ),

              // 설명 표시
              if (hasDescription) ...[
                GdsText(
                  description!,
                  color: .textGrayBold,
                  style: size.when(xl: .body1R, md: .body2R),
                  maxLines: 2,
                  overflow: .ellipsis,
                  textAlign: .center,
                ),
              ],
            ],
          ),

          // 하단에 액션 버튼 표시
          if (hasAction) ...[
            const Gap(24),

            GdsButton.text(
              type: actionType,
              size: size.when(xl: .lg, md: .md),
              variant: actionType.supportsVariant ? .assistive : null,
              label: action!.label,
              onTap: action!.onTap,
              layerLink: action!.layerLink,
            ),
          ],
        ],
      ),
    );
  }
}
