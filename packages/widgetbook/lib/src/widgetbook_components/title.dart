part of 'widgetbook_components.dart';

class WidgetbookTitle extends StatelessWidget {
  const WidgetbookTitle({
    required this.title,
    this.description,
    super.key,
  });

  final String title;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 16,
      children: [
        Text(title, style: GdsTypography.title1),
        if (description != null && description!.isNotEmpty) Text(description!, style: GdsTypography.body1R),
        // TODO GdsDivider로 변경
        // const GdsDivider(type: GdsDividerType.primary),
      ],
    );
  }
}
