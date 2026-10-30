import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/library/presentation/screens/widget_library_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const WidgetLabApp());
}

class WidgetLabApp extends StatelessWidget {
  const WidgetLabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WidgetLab',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: const WidgetLibraryScreen(),
    );
  }
}
