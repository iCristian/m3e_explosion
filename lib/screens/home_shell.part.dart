part of '../main.dart';

// Responsibility: Home shell and main structure of the application UI.

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.themeMode,
    required this.onThemeModeChanged,
    required this.fontPack,
    required this.onFontPackChanged,
    required this.colorPack,
    required this.onColorPackChanged,
  });

  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;
  final DemoFontPack fontPack;
  final ValueChanged<DemoFontPack> onFontPackChanged;
  final DemoColorPack colorPack;
  final ValueChanged<DemoColorPack> onColorPackChanged;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  static final List<Widget> _screens = [
    const _ShowcaseScreen(),
    const _ButtonsScreen(),
    const _NavigationScreen(),
    const _ProgressAndMotionScreen(),
    const _RefreshAndAppBarScreen(),
    const _CoreWidgetsScreen(),
    const _ShapesLabScreen(),
    const _LibrariesScreen(),
  ];

  static const List<_NavItem> _navItems = [
    _NavItem(icon: Icons.grid_view_rounded, selectedIcon: Icons.grid_view, label: 'Showcase', shortLabel: 'Inicio'),
    _NavItem(icon: Icons.smart_button_outlined, selectedIcon: Icons.smart_button, label: 'Buttons', shortLabel: 'Botones'),
    _NavItem(icon: Icons.alt_route_outlined, selectedIcon: Icons.alt_route, label: 'Navigation', shortLabel: 'Nav'),
    _NavItem(icon: Icons.animation_outlined, selectedIcon: Icons.animation, label: 'Motion', shortLabel: 'Motion'),
    _NavItem(icon: Icons.refresh_outlined, selectedIcon: Icons.refresh, label: 'Refresh', shortLabel: 'Refresh'),
    _NavItem(icon: Icons.widgets_outlined, selectedIcon: Icons.widgets, label: 'Core', shortLabel: 'Core'),
    _NavItem(icon: Icons.category_outlined, selectedIcon: Icons.category, label: 'Shapes', shortLabel: 'Shapes'),
    _NavItem(icon: Icons.menu_book_outlined, selectedIcon: Icons.menu_book, label: 'Librerias', shortLabel: 'Libs'),
  ];

  Future<void> _openStudioManager(BuildContext context) async {
    final cs = Theme.of(context).colorScheme;
    var selectedThemeMode = widget.themeMode;
    var selectedFontPack = widget.fontPack;
    var selectedColorPack = widget.colorPack;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: cs.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final maxHeight = MediaQuery.sizeOf(context).height * 0.85;
            return SafeArea(
              top: false,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: maxHeight),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Studio M3E', style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 10),
                      Text('Modo de color', style: Theme.of(context).textTheme.labelLarge),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          ChoiceChip(
                            selected: selectedThemeMode == ThemeMode.light,
                            avatar: const Icon(Icons.light_mode),
                            label: const Text('Claro'),
                            onSelected: (_) {
                              selectedThemeMode = ThemeMode.light;
                              widget.onThemeModeChanged(ThemeMode.light);
                              setModalState(() {});
                            },
                          ),
                          ChoiceChip(
                            selected: selectedThemeMode == ThemeMode.dark,
                            avatar: const Icon(Icons.dark_mode),
                            label: const Text('Oscuro'),
                            onSelected: (_) {
                              selectedThemeMode = ThemeMode.dark;
                              widget.onThemeModeChanged(ThemeMode.dark);
                              setModalState(() {});
                            },
                          ),
                          ChoiceChip(
                            selected: selectedThemeMode == ThemeMode.system,
                            avatar: const Icon(Icons.auto_mode),
                            label: const Text('Sistema'),
                            onSelected: (_) {
                              selectedThemeMode = ThemeMode.system;
                              widget.onThemeModeChanged(ThemeMode.system);
                              setModalState(() {});
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text('Tipografia activa', style: Theme.of(context).textTheme.labelLarge),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: DemoFontPack.values.map((pack) {
                          final selected = pack == selectedFontPack;
                          return ChoiceChip(
                            selected: selected,
                            label: Text(pack.label),
                            onSelected: (_) {
                              selectedFontPack = pack;
                              widget.onFontPackChanged(pack);
                              setModalState(() {});
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),
                      Text('Paleta colorida', style: Theme.of(context).textTheme.labelLarge),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: DemoColorPack.values.map((pack) {
                          final selected = pack == selectedColorPack;
                          return ChoiceChip(
                            selected: selected,
                            avatar: CircleAvatar(backgroundColor: pack.seed),
                            label: Text(pack.label),
                            onSelected: (_) {
                              selectedColorPack = pack;
                              widget.onColorPackChanged(pack);
                              setModalState(() {});
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 10),
                      ButtonM3E(
                        label: const Text('Color sorpresa'),
                        style: ButtonM3EStyle.tonal,
                        onPressed: () {
                          final index = (DemoColorPack.values.indexOf(selectedColorPack) + 1) % DemoColorPack.values.length;
                          selectedColorPack = DemoColorPack.values[index];
                          widget.onColorPackChanged(selectedColorPack);
                          setModalState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final compactLayout = MediaQuery.sizeOf(context).width < 780;
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: _screens[_currentIndex],
      floatingActionButton: FabM3E(
        icon: const Icon(Icons.tune),
        kind: FabM3EKind.tertiary,
        tooltip: 'Studio M3E',
        onPressed: () => _openStudioManager(context),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        minimum: const EdgeInsets.fromLTRB(12, 0, 12, 10),
        child: _AnimatedPaletteGradientBand(
          borderRadius: BorderRadius.circular(28),
          showShadow: true,
          child: compactLayout
              ? _CompactBottomNav(
                  selectedIndex: _currentIndex,
                  items: _navItems,
                  onTap: (index) => setState(() => _currentIndex = index),
                )
              : Theme(
                  data: Theme.of(context).copyWith(
                    navigationBarTheme: NavigationBarThemeData(
                      height: 72,
                      backgroundColor: Colors.transparent,
                      indicatorColor: cs.onPrimary.withValues(alpha: 0.2),
                      labelTextStyle: WidgetStateProperty.all(
                        Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: cs.onPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                  ),
                  child: NavigationBarM3E(
                    selectedIndex: _currentIndex,
                    onDestinationSelected: (index) => setState(() => _currentIndex = index),
                    destinations: _navItems
                        .map(
                          (item) => NavigationDestinationM3E(
                            icon: Icon(item.icon),
                            selectedIcon: Icon(item.selectedIcon),
                            label: item.label,
                          ),
                        )
                        .toList(),
                  ),
                ),
        ),
      ),
    );
  }
}

class _NavItem {
  const _NavItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.shortLabel,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final String shortLabel;
}

class _CompactBottomNav extends StatefulWidget {
  const _CompactBottomNav({
    required this.selectedIndex,
    required this.items,
    required this.onTap,
  });

  final int selectedIndex;
  final List<_NavItem> items;
  final ValueChanged<int> onTap;

  @override
  State<_CompactBottomNav> createState() => _CompactBottomNavState();
}

class _CompactBottomNavState extends State<_CompactBottomNav> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final accents = <Color>[
      cs.primary,
      cs.secondary,
      cs.tertiary,
      cs.error,
      cs.primary,
      cs.secondary,
      cs.tertiary,
      cs.error,
    ];

    return SizedBox(
      height: 72,
      child: Align(
        alignment: Alignment.center,
        child: Scrollbar(
          controller: _scrollController,
          thumbVisibility: false,
          notificationPredicate: (notification) => notification.metrics.axis == Axis.horizontal,
          child: ListView.separated(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            scrollDirection: Axis.horizontal,
            itemCount: widget.items.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final item = widget.items[index];
              final selected = index == widget.selectedIndex;
              final accent = accents[index % accents.length];

              return Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(999),
                  onTap: () => widget.onTap(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 240),
                    curve: Curves.easeOutCubic,
                    padding: EdgeInsets.symmetric(horizontal: selected ? 14 : 12, vertical: 8),
                    decoration: BoxDecoration(
                      gradient: selected
                          ? LinearGradient(
                              colors: [
                                accent.withValues(alpha: 0.62),
                                cs.primary.withValues(alpha: 0.72),
                              ],
                            )
                          : null,
                      color: selected ? null : cs.surface.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: selected
                            ? cs.onPrimary.withValues(alpha: 0.42)
                            : cs.onPrimary.withValues(alpha: 0.28),
                      ),
                      boxShadow: selected
                          ? [
                              BoxShadow(
                                color: accent.withValues(alpha: 0.28),
                                blurRadius: 14,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : null,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          selected ? item.selectedIcon : item.icon,
                          size: 18,
                          color: cs.onPrimary,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          item.shortLabel,
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                color: cs.onPrimary,
                                fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// ============================================================
// VIDEO PLAYER — ViewModel (ChangeNotifier)
// Ubicado en: lib/viewmodels/video_player_viewmodel.dart
// Patrón: MVVM-lite con ChangeNotifier + ListenableBuilder.
// Toda la lógica de reproducción vive allí, independiente de la UI.
// Se importa desde 'viewmodels/video_player_viewmodel.dart'
// ============================================================

