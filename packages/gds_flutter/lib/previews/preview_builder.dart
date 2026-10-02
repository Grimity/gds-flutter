import 'package:flutter/material.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 디자인 시스템 컴포넌트 프리뷰를 위한 앱을 구성합니다.
@preview
Widget previewBuilder(PreviewWidget widget) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.light(),
    darkTheme: ThemeData.dark(),
    themeMode: PreviewBinding.themeMode,
    builder: (context, child) {
      final brightness = Theme.of(context).brightness;

      return GdsThemeScope(
        theme: brightness == .dark ? .dark() : .light(),
        child: child!,
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
