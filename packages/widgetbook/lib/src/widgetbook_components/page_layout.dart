part of 'widgetbook_components.dart';

class WidgetbookPageLayout extends StatelessWidget {
  const WidgetbookPageLayout({
    required this.title,
    required this.children,
    this.description,
    this.childrenSpacing = 24,
    super.key,
  });

  final String title;
  final String? description;
  final List<Widget> children;
  final double childrenSpacing;

  @override
  Widget build(BuildContext context) {
    final bgColor = context.gdsColors.bg.primary;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: InteractiveViewer(
          maxScale: 6,
          minScale: 1,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: childrenSpacing,
              children: [
                WidgetbookTitle(title: title, description: description),
                ...children,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
