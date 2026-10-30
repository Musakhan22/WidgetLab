import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/models/widget_entry.dart';
import 'widget_preview.dart';

class WidgetCard extends StatelessWidget {
  const WidgetCard({super.key, required this.entry, this.onTap});
  final WidgetEntry entry;
  final VoidCallback? onTap;

  Color get _categoryColor => switch (entry.category) {
        'Animation' => AppColors.green,
        'Scrolling' => AppColors.textSecondary,
        'Box' => const Color(0xFF46C99A),
        _ => AppColors.accentLight,
      };

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(11),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Flexible(child: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: _categoryColor.withValues(alpha: .16), borderRadius: BorderRadius.circular(5)), child: Text(entry.category, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: _categoryColor, fontSize: 9, fontFamily: 'monospace')))),
              const Spacer(),
              if (entry.isLive) ...[Container(width: 6, height: 6, decoration: const BoxDecoration(color: AppColors.accentLight, shape: BoxShape.circle)), const SizedBox(width: 4), const Text('Live', style: TextStyle(color: AppColors.accentLight, fontSize: 9, fontFamily: 'monospace'))],
            ]),
            const SizedBox(height: 9),
            Container(height: 68, width: double.infinity, padding: const EdgeInsets.all(9), decoration: BoxDecoration(color: AppColors.preview, borderRadius: BorderRadius.circular(12)), child: Center(child: WidgetPreview(type: entry.previewType))),
            const SizedBox(height: 9),
            Text(entry.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: AppColors.textPrimary, fontSize: 12, fontWeight: FontWeight.w600, fontFamily: 'monospace')),
            const SizedBox(height: 4),
            Expanded(child: Text(entry.description, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11, height: 1.4))),
            const SizedBox(height: 8),
            Row(children: [Expanded(child: Text(entry.subtitle, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: AppColors.textMuted, fontSize: 9, fontFamily: 'monospace'))), const Icon(Icons.chevron_right, color: AppColors.textMuted, size: 15)]),
          ]),
        ),
      ),
    );
  }
}
