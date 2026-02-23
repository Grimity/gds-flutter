import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'main.directories.g.dart';

void main() {
  runApp(const GrimityWidgetbook());
}

@widgetbook.App()
class GrimityWidgetbook extends StatelessWidget {
  const GrimityWidgetbook({super.key});

  static const _categoryOrder = {
    'foundation': 0,
    'component': 1,
  };

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: directories
        ..sort(
          (p0, p1) {
            if (p0 is WidgetbookCategory && p1 is WidgetbookCategory) {
              return _categoryOrder[p0.name]!.compareTo(
                _categoryOrder[p1.name]!,
              );
            }

            return 0;
          },
        ),
      addons: [
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(
              name: 'Light',
              data: ThemeData(brightness: Brightness.light, fontFamily: 'Pretendard'),
            ),
            WidgetbookTheme(
              name: 'Dark',
              data: ThemeData(brightness: Brightness.dark, fontFamily: 'Pretendard'),
            ),
          ],
        ),
      ],
    );
  }
}
