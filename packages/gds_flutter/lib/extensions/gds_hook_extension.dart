import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:pervice/pervice.dart';

/// 디자인 시스템에서 제공하는 [BuildContext]에 대한 유틸리티 확장.
extension GdsHookExtension on BuildContext {
  /// [LayerLink]를 생성하고 자동으로 이를 해제합니다.
  LayerLink useLayerLink() => stateOf(LayerLink.new).value;

  /// [GdsViewStackController]를 생성하고 자동으로 이를 해제합니다.
  GdsViewStackController<T> useGdsViewStackController<T>(T Function() builder) {
    final state = stateOf(
      () => GdsViewStackController<T>(
        initialView: builder(),
      ),
      onDispose: (e) => e.dispose(),
    );

    return state.value;
  }

  /// [QuillController]를 생성하고 자동으로 이를 해제합니다.
  QuillController useQuillController() {
    final state = stateOf(
      () => QuillController.basic(),
      onDispose: (e) => e.dispose(),
    );

    return state.value;
  }
}
