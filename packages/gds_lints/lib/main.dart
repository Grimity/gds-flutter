import 'package:analysis_server_plugin/plugin.dart';
import 'package:analysis_server_plugin/registry.dart';
import 'package:gds_lints/rules/rules.dart';

/// GDS analyzer 플러그인 인스턴스.
final plugin = GdsLintsPlugin();

/// 디자인 시스템 규칙을 analyzer에 등록하는 플러그인.
class GdsLintsPlugin extends Plugin {
  @override
  String get name => 'gds_lints';

  @override
  void register(PluginRegistry registry) {
    // Prefer
    registry.registerWarningRule(PreferConciseConstructorRule());
    registry.registerWarningRule(PreferGdsButtonRule());
    registry.registerWarningRule(PreferGdsCheckBoxRule());
    registry.registerWarningRule(PreferGdsChipRule());
    registry.registerWarningRule(PreferGdsCircularLoadingRule());
    registry.registerWarningRule(PreferGdsContainerRule());
    registry.registerWarningRule(PreferGdsDividerRule());
    registry.registerWarningRule(PreferGdsGestureRule());
    registry.registerWarningRule(PreferGdsIconRule());
    registry.registerWarningRule(PreferGdsImageRule());
    registry.registerWarningRule(PreferGdsRadioRule());
    registry.registerWarningRule(PreferGdsRefreshLoadingRule());
    registry.registerWarningRule(PreferGdsScaffoldRule());
    registry.registerWarningRule(PreferGdsTextRule());
    registry.registerWarningRule(PreferGdsTextFieldRule());
    registry.registerWarningRule(PreferGdsToggleRule());
    registry.registerWarningRule(PreferWidgetFactoryKeyRule());

    // Valid
    registry.registerWarningRule(ValidGdsButtonVariantRule());
    registry.registerWarningRule(ValidGdsIconColorRule());
    registry.registerWarningRule(ValidPublicMemberDocsRule());
    registry.registerWarningRule(ValidGdsSizeRule());
    registry.registerWarningRule(ValidGdsSpacingRule());
  }
}
