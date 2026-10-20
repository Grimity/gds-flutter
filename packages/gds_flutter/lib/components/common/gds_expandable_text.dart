import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:pervice/pervice.dart';

/// 지정한 줄 수를 초과하는 텍스트를 접어 표시하고, 더보기로 펼칠 수 있는 위젯.
class GdsExpandableText extends StatelessWidget {
  const new(
    this.text, {
    super.key,
    required this.color,
    required this.style,
    this.animation = .normal,
    required this.maxLines,
  });

  final String text;
  final GdsColor color;
  final GdsTypography style;
  final GdsAnimation animation;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final key = ValueKey((text, maxLines));

    final overflow = context.stateOf<bool?>(() => null, key: key, mode: .read);
    final expanded = context.stateOf<bool>(() => false, key: key);

    return LayoutBuilder(
      builder: (context, constraints) {
        // 최초 레이아웃에서 최대 줄 수 초과 여부를 확인.
        if (overflow.value == null) {
          final painter = createTextPainter();
          painter.layout(maxWidth: constraints.maxWidth);

          overflow.value = painter.didExceedMaxLines;
          painter.dispose();
        }

        return Column(
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          spacing: 4,
          children: [
            // 본문 표시
            ClipRect(
              child: AnimatedSize(
                clipBehavior: .none,
                alignment: .topCenter,
                duration: animation.duration,
                curve: animation.curve,
                child: GdsText(
                  text,
                  color: color,
                  style: style,
                  maxLines: expanded.value ? null : maxLines,
                  overflow: expanded.value ? .visible : .ellipsis,
                ),
              ),
            ),

            // 더보기 혹은 축소 표시
            if (overflow.value == true) ...[
              GdsButton.text(
                type: .borderless,
                size: .sm,
                variant: .primary,
                onTap: expanded.toogle,
                label: expanded.value ? '접기' : '더보기',
              ),
            ],
          ],
        );
      },
    );
  }

  /// 텍스트 크기와 줄 수를 측정하기 위한 [TextPainter]를 생성합니다.
  TextPainter createTextPainter() {
    return TextPainter(
      text: TextSpan(text: text, style: style.style),
      textDirection: .ltr,
      maxLines: maxLines,
    );
  }
}
