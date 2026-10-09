import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:transparent_image/transparent_image.dart';

void main() {
  testWidgets('본 이미지가 페이드 인하는 동안 플레이스홀더를 유지한다', (tester) async {
    final provider = _DelayedImage();

    await tester.pumpWidget(
      GdsThemeScope(
        theme: GdsTheme.light(),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: GdsImage(
              provider: provider,
              placeholder: MemoryImage(kTransparentImage),
              width: 100,
              height: 100,
            ),
          ),
        ),
      ),
    );

    expect(find.byType(Image), findsNWidgets(2));
    expect(tester.widget<Opacity>(find.byType(Opacity)).opacity, 0);

    final recorder = ui.PictureRecorder();
    ui.Canvas(recorder).drawColor(const ui.Color(0xFFFFFFFF), ui.BlendMode.src);
    final picture = recorder.endRecording();
    provider.result.complete(ImageInfo(image: picture.toImageSync(1, 1)));
    picture.dispose();

    await tester.pump();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.byType(Image), findsNWidgets(2));
    final opacity = tester.widget<Opacity>(find.byType(Opacity)).opacity;
    expect(opacity, greaterThan(0));
    expect(opacity, lessThan(1));

    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(Image), findsOneWidget);
    expect(tester.widget<Opacity>(find.byType(Opacity)).opacity, 1);
    expect(tester.takeException(), isNull);
  });
}

class _DelayedImage extends ImageProvider<_DelayedImage> {
  final result = Completer<ImageInfo>();

  @override
  Future<_DelayedImage> obtainKey(ImageConfiguration configuration) => SynchronousFuture(this);

  @override
  ImageStreamCompleter loadImage(_DelayedImage key, ImageDecoderCallback decode) {
    return OneFrameImageStreamCompleter(result.future);
  }
}
