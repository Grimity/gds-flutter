import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:gds_flutter/src/image_embed_builder.dart';

/// HTML 본문을 GDS 스타일로 표시하는 읽기 전용 에디터 위젯.
class GdsEditorViewer extends StatelessWidget {
  const new({
    super.key,
    required this.html,
    this.imageBuilder,
    this.onLinkTap,
  });

  final String html;
  final ImageBuilder? imageBuilder;
  final FutureOr<void> Function(String url)? onLinkTap;

  @override
  Widget build(BuildContext context) {
    final GdsTypography body = context.whenDevice(
      mobile: .body2R,
      tablet: .body1R,
    );

    // 본문에 삽입된 글자와 링크에 적용할 색상.
    final textColor = GdsColor.textGrayBold.of(context);
    final linkColor = GdsColor.textPrimaryNormal.of(context);

    return HtmlWidget(
      html,
      textStyle: body.style.copyWith(color: textColor),
      customStylesBuilder: (element) {
        // 제목과 명시적으로 지정한 본문 서식 적용.
        final typography = switch (element.localName) {
          'h1' => GdsTypography.postTitle1,
          'h2' => GdsTypography.postTitle2,
          'h3' => GdsTypography.postBody,
          _ => null,
        };

        if (typography != null) {
          return {
            'margin': '0',
            'font-size': '${typography.fontSize}px',
            'font-weight': '${typography.fontWeight.value}',
            'line-height': '${typography.lineHeight}',
            'letter-spacing': '${typography.letterSpacing}px',
          };
        }

        // 일반 문단의 기본 위아래 여백 제거.
        if (element.localName == 'p') {
          return {'margin': '0'};
        }

        // 이미지 위아래에 고정 여백 적용.
        if (element.localName == 'img') {
          return {
            'display': 'block',
            'margin': '12px 0',
          };
        }

        // 링크의 글자와 밑줄에 색상 적용.
        if (element.localName == 'a') {
          return {
            'color': linkColor.toHex(),
            'text-decoration-color': linkColor.toHex(),
          };
        }

        return null;
      },
      customWidgetBuilder: (element) {
        final url = element.attributes['src'];

        // 이미지 태그에 URL이 있으면 지정한 빌더로 표시.
        if (element.localName == 'img' && url != null) {
          final image = imageBuilder?.call(context, url);
          if (image != null) {
            return Padding(padding: const .symmetric(vertical: 12), child: image);
          }
        }

        return null;
      },
      onTapUrl: (url) async {
        await onLinkTap?.call(url);
        return true;
      },
    );
  }
}
