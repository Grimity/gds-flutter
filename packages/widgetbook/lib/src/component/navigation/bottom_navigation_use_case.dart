import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook_components/widgetbook_components.dart';

enum _BadgeType {
  none("Default", null),
  home("Home", 0),
  rank("Rank", 1),
  follow("Follow", 2),
  community("Community", 3),
  dm("DM", 4);

  final String displayName;
  final int? navIndex;
  const _BadgeType(this.displayName, this.navIndex);
}

@widgetbook.UseCase(
  name: 'default',
  type: GdsBottomNavigation,
  path: '[component]/[navigation]',
)
Widget buildGdsBottomNavigationUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'Bottom Navigation',
    description: '화면 상단에 위치한 내비게이션으로, 작은 화면을 디자인할 때 사용합니다.',
    children: [
      _buildPlaygroundSection(context),
    ],
  );
}

Widget _buildPlaygroundSection(BuildContext context) {
  final type = context.knobs.list<_BadgeType>(
    label: 'type',
    options: _BadgeType.values,
    labelBuilder: (type) => type.displayName,
  );

  final plus = context.knobs.boolean(
    label: 'plus',
    initialValue: false,
  );

  final plusState = context.knobs.list<GdsPlusState>(
    label: 'plusState',
    options: GdsPlusState.values,
    labelBuilder: (state) => state.displayName,
  );

  final dotBadge = context.knobs.boolean(
    label: 'dotBadge',
    initialValue: false,
  );

  return WidgetbookPlayground(
    info: [
      'type: ${type.displayName}',
      'navIndex: ${type.navIndex}',
      'dotBadge: $dotBadge',
      'plusState: ${plusState.displayName}',
    ],
    child: Builder(
      builder: (context) {
        final Widget navigation = GdsBottomNavigation.main(
          index: type.navIndex,
          dotIndex: dotBadge ? 4 : null,
        );

        if (plus) {
          return ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 130),
            child: GdsBottomNavigation.wrap(
              child: SizedBox.shrink(),
              onPlusTap: plus ? () => debugPrint('Plus tapped') : null,
              plusState: plus ? plusState : GdsPlusState.enabled,
              navigation: navigation,
            ),
          );
        }

        return navigation;
      },
    ),
  );
}
