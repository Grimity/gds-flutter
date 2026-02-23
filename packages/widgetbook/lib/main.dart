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

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: directories,
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
