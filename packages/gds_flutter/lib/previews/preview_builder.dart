// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

import 'package:flutter/material.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:pervice/pervice.dart';

/// 디자인 시스템 컴포넌트 프리뷰를 위한 앱을 구성합니다.
@preview
Widget previewBuilder(PreviewWidget widget) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: .light(),
    darkTheme: .dark(),
    themeMode: PreviewBinding.themeMode,
    localizationsDelegates: const [FlutterQuillLocalizations.delegate],
    builder: (context, child) {
      final brightness = Theme.of(context).brightness;

      return GdsThemeScope(
        theme: brightness == .dark ? .dark() : .light(),
        child: ServiceScope.withState(
          child: child!,
        ),
      );
    },
    home: Builder(
      builder: (context) {
        return Material(
          type: .transparency,
          child: GdsContainer(
            alignment: .center,
            padding: 24.all,
            child: widget.build(context),
          ),
        );
      },
    ),
  );
}
