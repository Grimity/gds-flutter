// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 테스트에서 지정한 시점에 이미지를 전달하는 제공자.
class _TestImageProvider extends ImageProvider<_TestImageProvider> {
  final response = Completer<ImageInfo>();

  late final completer = OneFrameImageStreamCompleter(response.future);
  late final handle = completer.keepAlive();

  @override
  Future<_TestImageProvider> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture(this);
  }

  @override
  void resolveStreamForKey(
    ImageConfiguration configuration,
    ImageStream stream,
    _TestImageProvider key,
    ImageErrorListener handleError,
  ) {
    stream.setCompleter(completer);
  }

  /// 서로 다른 크기의 이미지로 완료 순서를 구분합니다.
  void complete(int width) {
    final recorder = ui.PictureRecorder();
    ui.Canvas(recorder);

    final picture = recorder.endRecording();
    response.complete(ImageInfo(image: picture.toImageSync(width, 1)));
    picture.dispose();
  }
}

void main() {
  testWidgets('이전 이미지가 늦게 완료되어도 새 이미지를 유지하는지 확인', (tester) async {
    final first = _TestImageProvider();
    final second = _TestImageProvider();

    addTearDown(first.handle.dispose);
    addTearDown(second.handle.dispose);

    // 첫 이미지가 로딩 중인 상태에서 제공자를 교체.
    await tester.pumpWidget(ImmediateImage(provider: first, width: 10, height: 10, fit: .cover));
    await tester.pumpWidget(ImmediateImage(provider: second, width: 10, height: 10, fit: .cover));

    // 새 이미지가 먼저 완료되면 화면에 반영되는지 확인.
    second.complete(2);

    await tester.pumpAndSettle();
    expect(tester.widget<RawImage>(find.byType(RawImage)).image?.width, 2);

    // 이전 이미지가 늦게 완료되어도 새 이미지를 유지하는지 확인.
    first.complete(1);

    await tester.pumpAndSettle();
    expect(tester.widget<RawImage>(find.byType(RawImage)).image?.width, 2);
    expect(tester.takeException(), isNull);

    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('로딩 중 위젯을 제거해도 이미지 완료 시 오류가 발생하지 않는지 확인', (tester) async {
    final provider = _TestImageProvider();
    addTearDown(provider.handle.dispose);

    // 이미지가 로딩 중인 상태에서 위젯을 제거.
    await tester.pumpWidget(ImmediateImage(provider: provider, width: 10, height: 10, fit: .cover));
    await tester.pumpWidget(const SizedBox());

    // 뒤늦게 로딩이 완료되어도 제거된 위젯을 갱신하지 않는지 확인.
    provider.complete(1);

    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}
