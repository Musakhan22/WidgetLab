import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../shared/models/widget_entry.dart';

class WidgetPreview extends StatelessWidget {
  const WidgetPreview({super.key, required this.type});
  final WidgetPreviewType type;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case WidgetPreviewType.row:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _tile('A', const Color(0xFF07516C)),
            _tile('B', const Color(0xFF008DBB)),
            _tile('C', const Color(0xFF07516C)),
          ],
        );
      case WidgetPreviewType.column:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            3,
            (i) => Container(
              height: 12,
              margin: const EdgeInsets.symmetric(vertical: 2),
              decoration: BoxDecoration(
                color: i == 1 ? AppColors.accent : const Color(0xFF07516C),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
        );
      case WidgetPreviewType.stack:
        return SizedBox(
          width: 60,
          height: 52,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 8,
                top: 7,
                child: _square(const Color(0xFF07516C)),
              ),
              Positioned(
                left: 18,
                top: 15,
                child: _square(const Color(0xFF008DBB)),
              ),
              Positioned(
                left: 28,
                top: 24,
                child: _square(AppColors.accentLight),
              ),
            ],
          ),
        );
      case WidgetPreviewType.container:
        return Container(
          width: 46,
          height: 46,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFF30353B),
            borderRadius: BorderRadius.circular(9),
          ),
          child: Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFF46C99A),
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Text(
              'pad',
              style: TextStyle(
                color: AppColors.background,
                fontSize: 9,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      case WidgetPreviewType.listView:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            4,
            (i) => Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 6,
                width: i == 2 ? double.infinity : 80 + (i % 2) * 24,
                margin: const EdgeInsets.symmetric(vertical: 2),
                decoration: BoxDecoration(
                  color: i == 1 ? AppColors.accent : const Color(0xFF414650),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        );
      case WidgetPreviewType.expanded:
        return Row(
          children: [
            Container(
              width: 15,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.surfaceHigh,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Container(
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.accentLight,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Icon(
                  Icons.unfold_more,
                  color: AppColors.background,
                  size: 16,
                ),
              ),
            ),
            const SizedBox(width: 5),
            Container(
              width: 15,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.surfaceHigh,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        );
      case WidgetPreviewType.wrap:
        return Wrap(
          spacing: 6,
          runSpacing: 5,
          children: List.generate(
            5,
            (i) => Container(
              width: i == 2 ? 42 : 24,
              height: 12,
              decoration: BoxDecoration(
                color: const Color(0xFF008DBB),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        );
      case WidgetPreviewType.animated:
        return Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.accent, Color(0xFF4EDEA3)],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.auto_awesome,
            color: AppColors.background,
            size: 19,
          ),
        );
    }
  }

  Widget _tile(String label, Color color) => Container(
    width: 38,
    height: 32,
    alignment: Alignment.center,
    margin: const EdgeInsets.symmetric(horizontal: 1),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: AppColors.accentLight,
        fontSize: 10,
        fontFamily: 'monospace',
      ),
    ),
  );
  Widget _square(Color color) => Container(
    width: 27,
    height: 27,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(7),
    ),
  );
}
