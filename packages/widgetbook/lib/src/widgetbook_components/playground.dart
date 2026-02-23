part of 'widgetbook_components.dart';

enum PlaygroundLayout { center, stretch }

class WidgetbookPlayground extends StatelessWidget {
  const WidgetbookPlayground({
    required this.child,
    this.info = const [],
    this.padding = const EdgeInsets.all(24),
    this.layout = PlaygroundLayout.center,
    super.key,
  });

  final Widget child;
  final List<String> info;
  final EdgeInsetsGeometry padding;
  final PlaygroundLayout layout;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return LayoutBuilder(
      builder: (context, constraints) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: colors.surface.base,
            borderRadius: BorderRadius.circular(GdsRadius.sm),
            border: Border.all(color: colors.border.graySubtler),
          ),
          child: Padding(
            padding: padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              spacing: 32,
              children: [
                Text(
                  'Playground',
                  style: GdsTypography.subtitle1.copyWith(color: colors.text.primaryNormal),
                ),
                switch (layout) {
                  PlaygroundLayout.stretch => SizedBox(width: double.infinity, child: child),
                  PlaygroundLayout.center => SizedBox(
                    width: double.infinity,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: constraints.maxWidth),
                      child: Center(child: child),
                    ),
                  ),
                },
                if (info.isNotEmpty)
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: info.map((text) => _InfoChip(text)).toList(),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final isFixed = label.contains('@fixed');

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isFixed ? colors.surface.graySubtlest : colors.surface.primarySubtlest,
        borderRadius: BorderRadius.circular(GdsRadius.full),
      ),
      child: Text(
        isFixed ? label.replaceAll('@fixed', '') : label,
        style: GdsTypography.label5.copyWith(
          color: isFixed ? colors.text.grayNormal : colors.text.primaryNormal,
        ),
      ),
    );
  }
}
