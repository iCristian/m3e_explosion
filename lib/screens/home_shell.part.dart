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
    required this.locale,
    required this.onLocaleChanged,
  });

  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;
  final DemoFontPack fontPack;
  final ValueChanged<DemoFontPack> onFontPackChanged;
  final DemoColorPack colorPack;
  final ValueChanged<DemoColorPack> onColorPackChanged;
  final Locale locale;
  final ValueChanged<String> onLocaleChanged;

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

  List<_NavItem> _buildNavItems(AppLocalizations l10n) => [
    _NavItem(icon: Icons.grid_view_rounded, selectedIcon: Icons.grid_view, label: l10n.navShowcase, shortLabel: l10n.navShowcaseShort),
    _NavItem(icon: Icons.smart_button_outlined, selectedIcon: Icons.smart_button, label: l10n.navButtons, shortLabel: l10n.navButtonsShort),
    _NavItem(icon: Icons.alt_route_outlined, selectedIcon: Icons.alt_route, label: l10n.navNavigation, shortLabel: l10n.navNavigationShort),
    _NavItem(icon: Icons.animation_outlined, selectedIcon: Icons.animation, label: l10n.navMotion, shortLabel: l10n.navMotionShort),
    _NavItem(icon: Icons.refresh_outlined, selectedIcon: Icons.refresh, label: l10n.navRefresh, shortLabel: l10n.navRefreshShort),
    _NavItem(icon: Icons.widgets_outlined, selectedIcon: Icons.widgets, label: l10n.navCore, shortLabel: l10n.navCoreShort),
    _NavItem(icon: Icons.category_outlined, selectedIcon: Icons.category, label: l10n.navShapes, shortLabel: l10n.navShapesShort),
    _NavItem(icon: Icons.menu_book_outlined, selectedIcon: Icons.menu_book, label: l10n.navLibraries, shortLabel: l10n.navLibrariesShort),
  ];

  Future<void> _openStudioManager(BuildContext context) async {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    var selectedThemeMode = widget.themeMode;
    var selectedFontPack = widget.fontPack;
    var selectedColorPack = widget.colorPack;
    var selectedLocale = widget.locale;

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
                      Text(l10n.studioTitle, style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 10),
                      Text(l10n.studioColorMode, style: Theme.of(context).textTheme.labelLarge),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          ChoiceChip(
                            selected: selectedThemeMode == ThemeMode.light,
                            avatar: const Icon(Icons.light_mode),
                            label: Text(l10n.studioLight),
                            onSelected: (_) {
                              selectedThemeMode = ThemeMode.light;
                              widget.onThemeModeChanged(ThemeMode.light);
                              setModalState(() {});
                            },
                          ),
                          ChoiceChip(
                            selected: selectedThemeMode == ThemeMode.dark,
                            avatar: const Icon(Icons.dark_mode),
                            label: Text(l10n.studioDark),
                            onSelected: (_) {
                              selectedThemeMode = ThemeMode.dark;
                              widget.onThemeModeChanged(ThemeMode.dark);
                              setModalState(() {});
                            },
                          ),
                          ChoiceChip(
                            selected: selectedThemeMode == ThemeMode.system,
                            avatar: const Icon(Icons.auto_mode),
                            label: Text(l10n.studioSystem),
                            onSelected: (_) {
                              selectedThemeMode = ThemeMode.system;
                              widget.onThemeModeChanged(ThemeMode.system);
                              setModalState(() {});
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(l10n.studioTypography, style: Theme.of(context).textTheme.labelLarge),
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
                      Text(l10n.studioPalette, style: Theme.of(context).textTheme.labelLarge),
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
                        label: Text(l10n.studioSurprise),
                        style: ButtonM3EStyle.tonal,
                        onPressed: () {
                          final index = (DemoColorPack.values.indexOf(selectedColorPack) + 1) % DemoColorPack.values.length;
                          selectedColorPack = DemoColorPack.values[index];
                          widget.onColorPackChanged(selectedColorPack);
                          setModalState(() {});
                        },
                      ),
                      const SizedBox(height: 16),
                      Text(l10n.studioLanguage, style: Theme.of(context).textTheme.labelLarge),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          ChoiceChip(
                            selected: selectedLocale.languageCode == 'en',
                            label: const Text('🇬🇧 English'),
                            onSelected: (_) {
                              selectedLocale = const Locale('en');
                              widget.onLocaleChanged('en');
                              setModalState(() {});
                            },
                          ),
                          ChoiceChip(
                            selected: selectedLocale.languageCode == 'es',
                            label: const Text('🇪🇸 Español'),
                            onSelected: (_) {
                              selectedLocale = const Locale('es');
                              widget.onLocaleChanged('es');
                              setModalState(() {});
                            },
                          ),
                          ChoiceChip(
                            selected: selectedLocale.languageCode == 'de',
                            label: const Text('🇩🇪 Deutsch'),
                            onSelected: (_) {
                              selectedLocale = const Locale('de');
                              widget.onLocaleChanged('de');
                              setModalState(() {});
                            },
                          ),
                          ChoiceChip(
                            selected: selectedLocale.languageCode == 'zh',
                            label: const Text('🇨🇳 中文'),
                            onSelected: (_) {
                              selectedLocale = const Locale('zh');
                              widget.onLocaleChanged('zh');
                              setModalState(() {});
                            },
                          ),
                        ],
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
    final navItems = _buildNavItems(l10n);

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
          child: _CompactBottomNav(
              selectedIndex: _currentIndex,
              items: navItems,
              useFullLabel: !compactLayout,
              onTap: (index) => setState(() => _currentIndex = index),
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
    this.useFullLabel = false,
  });

  final int selectedIndex;
  final List<_NavItem> items;
  final ValueChanged<int> onTap;
  final bool useFullLabel;

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
                          widget.useFullLabel ? item.label : item.shortLabel,
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

