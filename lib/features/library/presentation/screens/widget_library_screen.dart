import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/models/widget_entry.dart';
import '../widgets/widget_card.dart';

class WidgetLibraryScreen extends StatefulWidget {
  const WidgetLibraryScreen({super.key});

  @override
  State<WidgetLibraryScreen> createState() => _WidgetLibraryScreenState();
}

class _WidgetLibraryScreenState extends State<WidgetLibraryScreen> {
  final _searchController = TextEditingController();
  String _selectedCategory = 'Layout';
  String _searchQuery = '';
  int _selectedTab = 0;

  static const _categories = ['All (64)', 'Layout', 'Scrolling', 'Animation', 'Input', 'Text', 'State'];

  List<WidgetEntry> get _filteredEntries {
    return widgetEntries.where((entry) {
      final matchesCategory = _selectedCategory == 'All' || entry.category == _selectedCategory || (_selectedCategory == 'Layout' && entry.category == 'Box') || (_selectedCategory == 'Layout' && entry.category == 'Flex');
      final query = _searchQuery.toLowerCase();
      final matchesSearch = query.isEmpty || entry.name.toLowerCase().contains(query) || entry.description.toLowerCase().contains(query) || entry.category.toLowerCase().contains(query);
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  void dispose() { _searchController.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final isLibrary = _selectedTab == 0;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(preferredSize: const Size.fromHeight(64), child: _buildHeader()),
      body: SafeArea(top: false, child: isLibrary ? _buildLibrary() : _buildTabPlaceholder()),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildHeader() => Container(
    height: 64, padding: const EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(color: AppColors.background.withValues(alpha: .97), border: const Border(bottom: BorderSide(color: Color(0xFF1B2025), width: .5))),
    child: Row(children: [
      const Spacer(),
      const Text('WidgetLab', style: TextStyle(color: AppColors.textPrimary, fontSize: 20, fontWeight: FontWeight.w700, letterSpacing: -.5)),
      const SizedBox(width: 5),
      Container(padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2), decoration: BoxDecoration(color: AppColors.surfaceHigh, borderRadius: BorderRadius.circular(4)), child: const Text('v3.2', style: TextStyle(color: AppColors.accentLight, fontSize: 10, fontFamily: 'monospace'))),
      const Spacer(),
      IconButton(onPressed: _showThemeInfo, style: IconButton.styleFrom(backgroundColor: AppColors.surface, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), icon: const Icon(Icons.dark_mode_outlined, size: 19, color: AppColors.textSecondary)),
      const SizedBox(width: 4),
      Container(width: 36, height: 36, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.surfaceHigh, width: 2), gradient: const LinearGradient(colors: [Color(0xFF07516C), Color(0xFF252A30)])), child: const Icon(Icons.person_outline, color: AppColors.accentLight, size: 19)),
    ]),
  );

  Widget _buildLibrary() => CustomScrollView(slivers: [
    SliverPadding(padding: const EdgeInsets.fromLTRB(16, 12, 16, 0), sliver: SliverToBoxAdapter(child: _buildStats())),
    SliverPadding(padding: const EdgeInsets.fromLTRB(16, 12, 16, 0), sliver: SliverToBoxAdapter(child: _buildSearch())),
    SliverToBoxAdapter(child: _buildCategories()),
    SliverPadding(padding: const EdgeInsets.fromLTRB(16, 8, 16, 18), sliver: _filteredEntries.isEmpty ? const SliverToBoxAdapter(child: Padding(padding: EdgeInsets.all(32), child: Center(child: Text('No widgets found', style: TextStyle(color: AppColors.textSecondary))))) : SliverGrid.builder(
      itemCount: _filteredEntries.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, mainAxisExtent: 208),
      itemBuilder: (context, index) => WidgetCard(entry: _filteredEntries[index], onTap: () => _showWidgetInfo(_filteredEntries[index])),
    )),
    SliverPadding(padding: const EdgeInsets.fromLTRB(16, 0, 16, 28), sliver: SliverToBoxAdapter(child: _buildDrillBanner())),
  ]);

  Widget _buildStats() => Row(children: [
    Expanded(child: Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(color: AppColors.surfaceHigh.withValues(alpha: .8), borderRadius: BorderRadius.circular(30)), child: const Row(children: [Icon(Icons.circle, color: AppColors.accent, size: 7), SizedBox(width: 5), Expanded(child: Text('12 interactive\nsandboxes', style: TextStyle(color: AppColors.accentLight, fontSize: 10, height: 1.25, fontFamily: 'monospace'))), Text('•', style: TextStyle(color: AppColors.textMuted)), SizedBox(width: 7), Expanded(child: Text('8 mistake\ndrills', style: TextStyle(color: AppColors.textSecondary, fontSize: 10, height: 1.25, fontFamily: 'monospace')))]))),
    const SizedBox(width: 10),
    const Icon(Icons.bolt, color: Color(0xFF4EDEA3), size: 16),
    const SizedBox(width: 3),
    const Text('Flutter 3.22\nReady', style: TextStyle(color: AppColors.textSecondary, fontSize: 10, height: 1.3, fontFamily: 'monospace')),
  ]);

  Widget _buildSearch() => TextField(
    controller: _searchController,
    onChanged: (value) => setState(() => _searchQuery = value),
    style: const TextStyle(color: AppColors.textPrimary, fontSize: 13),
    decoration: InputDecoration(hintText: 'Search widgets (e.g. Row, Flex)...', prefixIcon: const Icon(Icons.search, color: AppColors.textMuted, size: 19), suffixIcon: IconButton(onPressed: _showFilterInfo, icon: const Icon(Icons.tune, color: AppColors.textSecondary, size: 19)), contentPadding: const EdgeInsets.symmetric(vertical: 14)),
  );

  Widget _buildCategories() => SizedBox(height: 48, child: ListView.separated(
    padding: const EdgeInsets.fromLTRB(16, 10, 16, 5), scrollDirection: Axis.horizontal,
    itemCount: _categories.length, separatorBuilder: (_, __) => const SizedBox(width: 8),
    itemBuilder: (context, index) {
      final label = _categories[index]; final category = index == 0 ? 'All' : label; final selected = _selectedCategory == category;
      return ChoiceChip(label: Text(label), selected: selected, onSelected: (_) => setState(() => _selectedCategory = category), showCheckmark: false, labelStyle: TextStyle(color: selected ? AppColors.accentLight : AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.w600), selectedColor: AppColors.accent.withValues(alpha: .18), backgroundColor: AppColors.surfaceHigh, side: BorderSide.none, shape: const StadiumBorder(), padding: const EdgeInsets.symmetric(horizontal: 5));
    },
  ));

  Widget _buildDrillBanner() => Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: const Color(0xFF1B2025), borderRadius: BorderRadius.circular(16)), child: Row(children: [
    Container(width: 40, height: 40, decoration: BoxDecoration(color: const Color(0xFF02569B), borderRadius: BorderRadius.circular(11)), child: const Icon(Icons.psychology_outlined, color: AppColors.accentLight, size: 21)),
    const SizedBox(width: 11),
    const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Daily Common Mistakes Drill', style: TextStyle(color: AppColors.textPrimary, fontSize: 11, fontWeight: FontWeight.w600)), SizedBox(height: 3), Text("Solve 'RenderFlex overflowed by 42px'", style: TextStyle(color: AppColors.textSecondary, fontSize: 10))])),
    const SizedBox(width: 8),
    FilledButton(onPressed: () => setState(() => _selectedTab = 3), style: FilledButton.styleFrom(backgroundColor: const Color(0xFFA4C9FF), foregroundColor: const Color(0xFF00315D), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11))), child: const Text('Debug →', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600))),
  ]));

  Widget _buildBottomNavigation() => Container(decoration: const BoxDecoration(color: AppColors.surface, border: Border(top: BorderSide(color: Color(0xFF252A30)))), child: NavigationBar(
    height: 66, backgroundColor: AppColors.surface, indicatorColor: AppColors.surfaceHigh, selectedIndex: _selectedTab,
    onDestinationSelected: (index) => setState(() => _selectedTab = index),
    labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    destinations: const [
      NavigationDestination(icon: Icon(Icons.grid_view_outlined), selectedIcon: Icon(Icons.grid_view), label: 'Library'),
      NavigationDestination(icon: Icon(Icons.tune), selectedIcon: Icon(Icons.tune), label: 'Playground'),
      NavigationDestination(icon: Icon(Icons.compare_arrows), selectedIcon: Icon(Icons.compare_arrows), label: 'Compare'),
      NavigationDestination(icon: Icon(Icons.bug_report_outlined), selectedIcon: Icon(Icons.bug_report), label: 'Mistakes'),
    ],
  ));

  Widget _buildTabPlaceholder() {
    const titles = ['Library', 'Playground', 'Compare', 'Mistakes'];
    const descriptions = ['Browse Flutter widgets and interactive examples.', 'Select a widget from the Library to open its interactive playground.', 'Compare widget behaviour side by side.', 'Explore common Flutter layout mistakes and learn how to fix them.'];
    return Center(child: Padding(padding: const EdgeInsets.all(28), child: Column(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.construction, color: AppColors.accentLight, size: 38), const SizedBox(height: 14), Text(titles[_selectedTab], style: const TextStyle(color: AppColors.textPrimary, fontSize: 20, fontWeight: FontWeight.bold)), const SizedBox(height: 8), Text(descriptions[_selectedTab], textAlign: TextAlign.center, style: const TextStyle(color: AppColors.textSecondary, height: 1.5)), const SizedBox(height: 18), OutlinedButton(onPressed: () => setState(() => _selectedTab = 0), child: const Text('Back to Library'))])));
  }

  void _showWidgetInfo(WidgetEntry entry) => showModalBottomSheet<void>(context: context, backgroundColor: AppColors.surface, showDragHandle: true, builder: (context) => Padding(padding: const EdgeInsets.fromLTRB(20, 8, 20, 28), child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [Text(entry.name, style: const TextStyle(color: AppColors.textPrimary, fontSize: 20, fontWeight: FontWeight.bold)), const SizedBox(height: 8), Text(entry.description, style: const TextStyle(color: AppColors.textSecondary, height: 1.5)), const SizedBox(height: 16), const Text('Interactive playground and Dart code will be added in the next phase.', style: TextStyle(color: AppColors.accentLight, fontSize: 12))])));
  void _showFilterInfo() => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('More filters will be added in a later phase.')));
  void _showThemeInfo() => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Light theme support is planned for a later phase.')));
}
