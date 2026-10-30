import 'package:flutter/material.dart';

class WidgetEntry {
  const WidgetEntry({
    required this.name,
    required this.category,
    required this.description,
    required this.subtitle,
    required this.previewType,
    this.isLive = true,
  });

  final String name;
  final String category;
  final String description;
  final String subtitle;
  final WidgetPreviewType previewType;
  final bool isLive;
}

enum WidgetPreviewType { row, column, stack, container, listView, expanded, wrap, animated }

const widgetEntries = <WidgetEntry>[
  WidgetEntry(name: 'Row', category: 'Layout', description: 'A widget that displays its children in a horizontal direction.', subtitle: 'Axis.horizontal', previewType: WidgetPreviewType.row),
  WidgetEntry(name: 'Column', category: 'Layout', description: 'Arranges children vertically with flexible alignment.', subtitle: 'Axis.vertical', previewType: WidgetPreviewType.column),
  WidgetEntry(name: 'Stack', category: 'Layout', description: 'Positions children relative to the edges of its box.', subtitle: 'Z-Index Stack', previewType: WidgetPreviewType.stack),
  WidgetEntry(name: 'Container', category: 'Box', description: 'Convenience widget combining painting and positioning.', subtitle: 'BoxDecoration', previewType: WidgetPreviewType.container),
  WidgetEntry(name: 'ListView', category: 'Scrolling', description: 'Linear scrollable list with lazy item rendering.', subtitle: 'SliverLazyList', previewType: WidgetPreviewType.listView),
  WidgetEntry(name: 'Expanded', category: 'Flex', description: 'Expands a child of Row or Column to fill available space.', subtitle: 'flex: 1 (greedy)', previewType: WidgetPreviewType.expanded),
  WidgetEntry(name: 'Wrap', category: 'Layout', description: 'Displays children across multiple dynamic runs.', subtitle: 'WrapAlignment', previewType: WidgetPreviewType.wrap),
  WidgetEntry(name: 'AnimatedContainer', category: 'Animation', description: 'Gradually changes values over time automatically.', subtitle: 'Implicit Curve', previewType: WidgetPreviewType.animated),
];
