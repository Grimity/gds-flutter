import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

///
@GdsSupportedSizes([.xl, .md])
class GdsEmptyState extends StatelessWidget {
  const new({
    super.key,
    required this.size,
    required this.illust,
    required this.title,
    this.description,
    this.button,
    this.buttonType = .solid,
  });

  final GdsSize size;
  final GdsIcon illust;
  final String title;
  final String? description;
  final GdsTextButtonAction? button;
  final GdsTextButtonType buttonType;

  @override
  Widget build(BuildContext context) {
    assert(illust.type != .semantic);
    final hasDescription = description != null;
    final hasButton = button != null;

    return Padding(
      padding: .symmetric(vertical: 72),
      child: Column(
        crossAxisAlignment: .center,
        mainAxisSize: .min,
        children: [
          // 상단에 일러스트 표시
          illust.build(size: 60),

          // 본문 간의 간격.
          size.when(xl: 24, md: 16).verticalGap,

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
          if (hasButton) ...[
            24.verticalGap,

            GdsButton.text(
              type: buttonType,
              size: size.when(xl: .lg, md: .md),
              variant: buttonType.supportsVariant ? .assistive : null,
              label: button!.label,
              onTap: button!.onTap,
            ),
          ],
        ],
      ),
    );
  }
}
