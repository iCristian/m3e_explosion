import 'dart:async';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:expressive_loading_indicator/expressive_loading_indicator.dart' as eli;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_m3shapes_extended/flutter_m3shapes_extended.dart' as m3shapes;
import 'package:google_fonts/google_fonts.dart';
import 'package:m3e_buttons/m3e_buttons.dart' as m3eb;
import 'package:m3e_collection/m3e_collection.dart';
import 'package:m3e_core/m3e_core.dart' as m3ec;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

// ARQUITECTURA: Models, Services, ViewModels, Widgets
import 'models/app_models.dart';
import 'service_locator.dart';
import 'viewmodels/video_player_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Animate.defaultDuration = const Duration(milliseconds: 400);
  
  // Inicializar el service locator (inyección de dependencias)
  await setupServiceLocator();
  
  runApp(const M3EDemoApp());
}

// Enums y constantes importados de lib/models/app_models.dart


// Extension DemoColorPackLabel (label + seed) importada desde app_models.dart

class M3EDemoApp extends StatefulWidget {
  const M3EDemoApp({
    super.key,
    this.enableIntro = true,
  });

  final bool enableIntro;

  @override
  State<M3EDemoApp> createState() => _M3EDemoAppState();
}

class _M3EDemoAppState extends State<M3EDemoApp> {
  ThemeMode _themeMode = ThemeMode.system;
  DemoFontPack _fontPack = DemoFontPack.inter;
  DemoColorPack _colorPack = DemoColorPack.ultraViolet;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  /// Carga las configuraciones guardadas desde AppPreferencesService.
  /// Este método se ejecuta una sola vez en initState().
  Future<void> _loadSettings() async {
    // Acceder al servicio de preferencias via service locator
    final prefs = preferencesService;

    if (!mounted) {
      return;
    }

    setState(() {
      // Cargar tema (por defecto: system)
      final themeModeName = prefs.getThemeMode();
      _themeMode = _parseThemeMode(themeModeName);

      // Cargar pack de fuentes (por defecto: Inter)
      _fontPack = prefs.getFontPack();

      // Cargar pack de colores (por defecto: Ultra Violet)
      _colorPack = prefs.getColorPack();
    });
  }

  /// Convierte una cadena a [ThemeMode].
  ThemeMode _parseThemeMode(String mode) {
    switch (mode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  /// Guarda el tema seleccionado en preferencias.
  Future<void> _setThemeMode(ThemeMode mode) async {
    setState(() => _themeMode = mode);
    final modeStr = mode == ThemeMode.light
        ? 'light'
        : mode == ThemeMode.dark
            ? 'dark'
            : 'system';
    await preferencesService.setThemeMode(modeStr);
  }

  /// Guarda el pack de fuentes seleccionado en preferencias.
  Future<void> _setFontPack(DemoFontPack pack) async {
    setState(() => _fontPack = pack);
    await preferencesService.setFontPack(pack);
  }

  /// Guarda el pack de colores seleccionado en preferencias.
  Future<void> _setColorPack(DemoColorPack pack) async {
    setState(() => _colorPack = pack);
    await preferencesService.setColorPack(pack);
  }

  TextStyle _fontStyle(
    DemoFontPack pack, {
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? height,
  }) {
    switch (pack) {
      case DemoFontPack.inter:
        return GoogleFonts.inter(
          fontSize: fontSize,
          fontWeight: fontWeight,
          letterSpacing: letterSpacing,
          height: height,
        );
      case DemoFontPack.spaceGrotesk:
        return GoogleFonts.spaceGrotesk(
          fontSize: fontSize,
          fontWeight: fontWeight,
          letterSpacing: letterSpacing,
          height: height,
        );
      case DemoFontPack.playfairDisplay:
        return GoogleFonts.playfairDisplay(
          fontSize: fontSize,
          fontWeight: fontWeight,
          letterSpacing: letterSpacing,
          height: height,
        );
      case DemoFontPack.sora:
        return GoogleFonts.sora(
          fontSize: fontSize,
          fontWeight: fontWeight,
          letterSpacing: letterSpacing,
          height: height,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        final seed = _colorPack.seed;
        final light = lightDynamic ?? ColorScheme.fromSeed(seedColor: seed);
        final dark = darkDynamic ?? ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.dark);

        return MaterialApp(
          title: 'M3 Expressive Mega Gallery',
          debugShowCheckedModeBanner: false,
          themeMode: _themeMode,
          theme: _buildTheme(light, _fontPack),
          darkTheme: _buildTheme(dark, _fontPack),
          home: widget.enableIntro
              ? IntroGate(
                  child: HomeScreen(
                    themeMode: _themeMode,
                    onThemeModeChanged: (mode) => _setThemeMode(mode),
                    fontPack: _fontPack,
                    onFontPackChanged: (pack) => _setFontPack(pack),
                    colorPack: _colorPack,
                    onColorPackChanged: (pack) => _setColorPack(pack),
                  ),
                )
              : HomeScreen(
                  themeMode: _themeMode,
                  onThemeModeChanged: (mode) => _setThemeMode(mode),
                  fontPack: _fontPack,
                  onFontPackChanged: (pack) => _setFontPack(pack),
                  colorPack: _colorPack,
                  onColorPackChanged: (pack) => _setColorPack(pack),
                ),
        );
      },
    );
  }

  ThemeData _buildTheme(ColorScheme colorScheme, DemoFontPack pack) {
    final textTheme = TextTheme(
      displayLarge: _fontStyle(pack, fontSize: 57, fontWeight: FontWeight.w800, letterSpacing: -0.4),
      headlineMedium: _fontStyle(pack, fontSize: 28, fontWeight: FontWeight.w700),
      titleLarge: _fontStyle(pack, fontSize: 22, fontWeight: FontWeight.w700),
      titleMedium: _fontStyle(pack, fontSize: 16, fontWeight: FontWeight.w600),
      bodyLarge: _fontStyle(pack, fontSize: 16),
      bodyMedium: _fontStyle(pack, fontSize: 14),
      labelLarge: _fontStyle(pack, fontWeight: FontWeight.w700),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: textTheme,
      cardTheme: const CardThemeData(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(24))),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
      ),
    );
  }
}

class IntroGate extends StatefulWidget {
  const IntroGate({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<IntroGate> createState() => _IntroGateState();
}

class _IntroGateState extends State<IntroGate> {
  bool _showHome = false;

  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(milliseconds: 1800), () {
      if (!mounted) {
        return;
      }
      setState(() => _showHome = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(scale: Tween<double>(begin: 0.97, end: 1).animate(animation), child: child),
        );
      },
      child: _showHome
          ? widget.child
          : Scaffold(
              key: const ValueKey('intro-screen'),
              body: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [cs.primaryContainer, cs.tertiaryContainer, cs.secondaryContainer],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      m3shapes.M3EContainer.softBurst(
                        width: 128,
                        height: 128,
                        color: cs.primary,
                        child: Icon(Icons.auto_awesome, color: cs.onPrimary, size: 42),
                      ).animate(onPlay: (controller) => controller.repeat(reverse: true)).scale(begin: const Offset(0.85, 0.85), end: const Offset(1.12, 1.12), duration: 1200.ms),
                      const SizedBox(height: 20),
                      Text(
                        'M3 EXPRESSIVE',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900),
                      ).animate().fadeIn(duration: 350.ms).slideY(begin: 0.15, end: 0),
                      const SizedBox(height: 6),
                      Text(
                        'Mega Gallery',
                        style: Theme.of(context).textTheme.titleLarge,
                      ).animate(delay: 80.ms).fadeIn(duration: 350.ms),
                      const SizedBox(height: 18),
                      const SizedBox(
                        width: 56,
                        height: 56,
                        child: eli.ExpressiveLoadingIndicator(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

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

  Future<void> _openStudioManager(BuildContext context) async {
    final cs = Theme.of(context).colorScheme;
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
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Studio M3E', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 10),
                  Text('Modo de color', style: Theme.of(context).textTheme.labelLarge),
                  const SizedBox(height: 8),
                  SegmentedButton<ThemeMode>(
                    selected: {widget.themeMode},
                    onSelectionChanged: (set) {
                      final mode = set.first;
                      widget.onThemeModeChanged(mode);
                      setModalState(() {});
                    },
                    segments: const [
                      ButtonSegment(value: ThemeMode.light, icon: Icon(Icons.light_mode), label: Text('Claro')),
                      ButtonSegment(value: ThemeMode.dark, icon: Icon(Icons.dark_mode), label: Text('Oscuro')),
                      ButtonSegment(value: ThemeMode.system, icon: Icon(Icons.auto_mode), label: Text('Sistema')),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text('Tipografia activa', style: Theme.of(context).textTheme.labelLarge),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: DemoFontPack.values.map((pack) {
                      final selected = pack == widget.fontPack;
                      return ChoiceChip(
                        selected: selected,
                        label: Text(pack.label),
                        onSelected: (_) {
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
                      final selected = pack == widget.colorPack;
                      return ChoiceChip(
                        selected: selected,
                        avatar: CircleAvatar(backgroundColor: pack.seed),
                        label: Text(pack.label),
                        onSelected: (_) {
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
                      final index = (DemoColorPack.values.indexOf(widget.colorPack) + 1) % DemoColorPack.values.length;
                      widget.onColorPackChanged(DemoColorPack.values[index]);
                      setModalState(() {});
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      floatingActionButton: FabM3E(
        icon: const Icon(Icons.tune),
        kind: FabM3EKind.tertiary,
        tooltip: 'Studio M3E',
        onPressed: () => _openStudioManager(context),
      ),
      bottomNavigationBar: NavigationBarM3E(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        destinations: const [
          NavigationDestinationM3E(icon: Icon(Icons.grid_view_rounded), selectedIcon: Icon(Icons.grid_view), label: 'Showcase'),
          NavigationDestinationM3E(icon: Icon(Icons.smart_button_outlined), selectedIcon: Icon(Icons.smart_button), label: 'Buttons'),
          NavigationDestinationM3E(icon: Icon(Icons.alt_route_outlined), selectedIcon: Icon(Icons.alt_route), label: 'Navigation'),
          NavigationDestinationM3E(icon: Icon(Icons.animation_outlined), selectedIcon: Icon(Icons.animation), label: 'Motion'),
          NavigationDestinationM3E(icon: Icon(Icons.refresh_outlined), selectedIcon: Icon(Icons.refresh), label: 'Refresh'),
          NavigationDestinationM3E(icon: Icon(Icons.widgets_outlined), selectedIcon: Icon(Icons.widgets), label: 'Core'),
          NavigationDestinationM3E(icon: Icon(Icons.category_outlined), selectedIcon: Icon(Icons.category), label: 'Shapes'),
          NavigationDestinationM3E(icon: Icon(Icons.menu_book_outlined), selectedIcon: Icon(Icons.menu_book), label: 'Librerias'),
        ],
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

class _ShowcaseScreen extends StatefulWidget {
  const _ShowcaseScreen();

  @override
  State<_ShowcaseScreen> createState() => _ShowcaseScreenState();
}

class _ShowcaseScreenState extends State<_ShowcaseScreen> {
  /// ViewModel del reproductor obtenido del service locator.
  /// Se usa como Singleton compartido en toda la app.
  late VideoPlayerViewModel _videoVM;

  double _energy = 0.75;
  double _organic = 0.65;
  String _query = '';
  double _productivity = 0.68;
  bool _focusMode = true;
  bool _smartAlerts = true;
  final Set<int> _doneTasks = {0, 2};

  static const List<_UtilityModule> _modules = [
    _UtilityModule(_ModuleKind.routines, 'Rutinas', 'Hábitos, streaks y objetivos diarios', Icons.track_changes),
    _UtilityModule(_ModuleKind.focus, 'Focus', 'Bloqueo de distracciones y bloques deep work', Icons.center_focus_strong),
    _UtilityModule(_ModuleKind.finance, 'Finanzas', 'Seguimiento de gasto y alertas de presupuesto', Icons.pie_chart_outline),
    _UtilityModule(_ModuleKind.health, 'Salud', 'Hidratación, sueño y movimiento', Icons.favorite_outline),
    _UtilityModule(_ModuleKind.agenda, 'Agenda', 'Eventos, recordatorios y prioridades', Icons.event_note),
    _UtilityModule(_ModuleKind.automation, 'Automatización', 'Reglas inteligentes según contexto', Icons.auto_mode),
  ];

  void _openModule(_UtilityModule module) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => _UtilityModuleScreen(module: module),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Obtener el ViewModel del service locator (es un Singleton)
    _videoVM = videoPlayerViewModel;
    // Escucha cambios del ViewModel para reconstruir la UI del reproductor.
    _videoVM.addListener(_onVideoVMChange);
  }

  void _onVideoVMChange() => setState(() {});

  @override
  void dispose() {
    _videoVM.removeListener(_onVideoVMChange);
    // NO llamar a dispose() del ViewModel aquí, ya que es un Singleton
    // que se comparte con otras pantallas. El dispose() se llamará
    // solo cuando la app se cierre (en setupServiceLocator cleanup).
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final query = _query.trim().toLowerCase();
    final filteredModules = query.isEmpty
      ? _modules
      : _modules
        .where((module) => '${module.title} ${module.subtitle}'.toLowerCase().contains(query))
        .toList();
    const tasks = ['Revisar métricas de energía', 'Enviar reporte del sprint', 'Sesión de focus 45 min', 'Actualizar presupuesto'];
    return Scaffold(
      appBar: const AppBarM3E(titleText: 'Material 3 Expressive'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            height: 250,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [cs.primaryContainer, cs.tertiaryContainer, cs.secondaryContainer],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(36),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 16,
                  right: 14,
                  child: m3shapes.M3EContainer.softBurst(
                    width: 86,
                    height: 86,
                    color: cs.primary,
                    child: Icon(Icons.bolt, color: cs.onPrimary),
                  ).animate(onPlay: (controller) => controller.repeat(reverse: true)).scale(begin: const Offset(0.88, 0.88), end: const Offset(1.08, 1.08), duration: 1400.ms),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: m3shapes.M3EContainer.flower(
                    width: 62,
                    height: 62,
                    color: cs.secondary,
                    child: Icon(Icons.auto_awesome, color: cs.onSecondary),
                  ).animate(onPlay: (controller) => controller.repeat(reverse: true)).rotate(begin: -0.05, end: 0.07, duration: 1800.ms),
                ),
                Positioned(
                  top: 58,
                  left: 20,
                  right: 110,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: cs.surface.withValues(alpha: 0.34),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'EXPLOSION\nM3E',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: cs.onPrimaryContainer,
                        height: 0.95,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.12, end: 0),
                ),
                Positioned(
                  right: 18,
                  bottom: 20,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: cs.surface.withValues(alpha: 0.72),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text('Material 3 Expressive', style: Theme.of(context).textTheme.labelLarge),
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 450.ms).scale(begin: const Offset(0.92, 0.92), end: const Offset(1, 1)),
          const SizedBox(height: 8),
          Text(
            'Primera vista explosiva, motion continuo y controles de personalizacion para llevar M3E al limite.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: cs.onSurfaceVariant),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Personalizacion Viva', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 10),
                  Text('Intensidad de energia', style: Theme.of(context).textTheme.labelLarge),
                  Slider(
                    value: _energy,
                    onChanged: (value) => setState(() => _energy = value),
                  ),
                  Text('Organicidad de forma', style: Theme.of(context).textTheme.labelLarge),
                  Slider(
                    value: _organic,
                    onChanged: (value) => setState(() => _organic = value),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      m3shapes.M3EContainer.puffy(
                        width: 72 + (_energy * 36),
                        height: 72 + (_energy * 36),
                        color: cs.primary.withValues(alpha: 0.25 + (_energy * 0.55)),
                        child: Icon(Icons.waves, color: cs.primary),
                      ),
                      m3shapes.M3EContainer.bun(
                        width: 72 + (_organic * 34),
                        height: 72 + (_organic * 34),
                        color: cs.tertiary.withValues(alpha: 0.2 + (_organic * 0.6)),
                        child: Icon(Icons.blur_on, color: cs.tertiary),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(delay: 120.ms),
          const SizedBox(height: 16),
          Card(
            color: cs.tertiaryContainer.withValues(alpha: 0.45),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Color Burst', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text(
                    'Vista rápida de tonos activos del tema con animación de pulso.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _ColorPulseDot(color: cs.primary, label: 'Primary'),
                      _ColorPulseDot(color: cs.secondary, label: 'Secondary'),
                      _ColorPulseDot(color: cs.tertiary, label: 'Tertiary'),
                      _ColorPulseDot(color: cs.error, label: 'Error'),
                    ],
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(delay: 180.ms).slideY(begin: 0.06, end: 0),
          const SizedBox(height: 16),
          Card(
            clipBehavior: Clip.antiAlias,
            elevation: 4,
            shadowColor: cs.primary.withValues(alpha: 0.28),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ── Banner gradient header ──────────────────────────────────
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [cs.primaryContainer, cs.tertiaryContainer],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: Row(
                    children: [
                      m3shapes.M3EContainer.gem(
                        width: 46,
                        height: 46,
                        color: cs.primary,
                        child: Icon(Icons.smart_display_rounded, color: cs.onPrimary, size: 26),
                      ).animate(onPlay: (c) => c.repeat(reverse: true))
                       .shimmer(duration: 2800.ms, color: cs.onPrimary.withValues(alpha: 0.15)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'M3E Media Stage',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: cs.onPrimaryContainer,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              'Material 3 Expressive · Video oficial',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: cs.onPrimaryContainer.withValues(alpha: 0.72),
                                letterSpacing: 0.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Status badge animado
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, anim) => ScaleTransition(scale: anim, child: child),
                        child: Container(
                          key: ValueKey(_videoVM.playing),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: _videoVM.playing
                                ? cs.primary.withValues(alpha: 0.18)
                                : cs.outline.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: _videoVM.playing ? cs.primary : cs.outline.withValues(alpha: 0.5),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (_videoVM.playing)
                                Container(
                                  width: 7,
                                  height: 7,
                                  decoration: BoxDecoration(
                                    color: cs.primary,
                                    shape: BoxShape.circle,
                                  ),
                                ).animate(onPlay: (c) => c.repeat(reverse: true))
                                 .fadeIn(duration: 500.ms)
                              else
                                Icon(Icons.stop_circle_outlined, size: 8, color: cs.outline),
                              const SizedBox(width: 5),
                              Text(
                                _videoVM.playing ? 'PLAY' : 'M3E',
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: _videoVM.playing ? cs.primary : cs.outline,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // ── Zona de video / teaser ──────────────────────────────────
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    child: _videoVM.ready && _videoVM.controller != null
                        ? YoutubePlayer(
                            key: const ValueKey('player'),
                            controller: _videoVM.controller!,
                          )
                        : GestureDetector(
                            key: const ValueKey('teaser'),
                            onTap: _videoVM.enable,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.network(
                                  'https://img.youtube.com/vi/${_videoVM.videoId}/maxresdefault.jpg',
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, _, _) => Container(color: cs.primaryContainer),
                                ),
                                // Gradiente inferior
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withValues(alpha: 0.72),
                                      ],
                                      stops: const [0.35, 1.0],
                                    ),
                                  ),
                                ),
                                // Botón play animado con M3E shape
                                Center(
                                  child: m3shapes.M3EContainer.softBurst(
                                    width: 76,
                                    height: 76,
                                    color: cs.primary.withValues(alpha: 0.93),
                                    child: Icon(
                                      Icons.play_arrow_rounded,
                                      color: cs.onPrimary,
                                      size: 42,
                                    ),
                                  ).animate(onPlay: (c) => c.repeat(reverse: true))
                                   .scaleXY(
                                     begin: 1.0,
                                     end: 1.12,
                                     duration: 1300.ms,
                                     curve: Curves.easeInOut,
                                   ),
                                ),
                                // Etiqueta inferior
                                Positioned(
                                  bottom: 14,
                                  left: 0,
                                  right: 0,
                                  child: Text(
                                    'Toca para cargar · Material 3 Expressive',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black.withValues(alpha: 0.85),
                                          blurRadius: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
                // ── Controles M3E ───────────────────────────────────────────
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                  decoration: BoxDecoration(
                    color: cs.surfaceContainerHighest.withValues(alpha: 0.55),
                  ),
                  child: Column(
                    children: [
                      // Botón principal — ancho completo con icono
                      SizedBox(
                        width: double.infinity,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 220),
                          transitionBuilder: (child, anim) =>
                              FadeTransition(opacity: anim, child: ScaleTransition(scale: anim, child: child)),
                          child: ButtonM3E(
                            key: ValueKey(_videoVM.playing),
                            label: Text(_videoVM.playing ? '⏸  Pausar' : '▶  Reproducir'),
                            style: ButtonM3EStyle.filled,
                            onPressed: _videoVM.ready ? _videoVM.playPause : _videoVM.enable,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Fila de controles secundarios
                      Row(
                        children: [
                          Expanded(
                            child: ButtonM3E(
                              label: Text(_videoVM.muted ? '🔊  Sonido' : '🔇  Silenciar'),
                              style: ButtonM3EStyle.tonal,
                              onPressed: _videoVM.ready ? _videoVM.toggleMute : null,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ButtonM3E(
                              label: const Text('↺  Reiniciar'),
                              style: ButtonM3EStyle.outlined,
                              onPressed: _videoVM.ready ? _videoVM.restart : null,
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Botón fullscreen con shape M3E
                          GestureDetector(
                            onTap: _videoVM.ready ? _videoVM.openFullscreen : null,
                            child: m3shapes.M3EContainer.gem(
                              width: 42,
                              height: 42,
                              color: _videoVM.ready ? cs.primary : cs.surfaceContainerHighest,
                              child: Icon(
                                Icons.fullscreen_rounded,
                                color: _videoVM.ready ? cs.onPrimary : cs.onSurface.withValues(alpha: 0.38),
                                size: 22,
                              ),
                            ).animate(target: _videoVM.ready ? 1 : 0)
                             .scaleXY(begin: 0.88, end: 1.0, curve: Curves.easeOut, duration: 300.ms),
                          ),
                        ],
                      ),
                      // Hint cuando no está cargado
                      if (!_videoVM.ready) ...[
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            m3shapes.M3EContainer.pill(
                              width: 20,
                              height: 20,
                              color: cs.secondaryContainer,
                              child: Icon(Icons.info_outline_rounded, size: 12, color: cs.onSecondaryContainer),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Toca Reproducir o el thumbnail para cargar el video',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: cs.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(delay: 220.ms).slideY(begin: 0.06, end: 0),
          const SizedBox(height: 24),
          SearchBar(
            hintText: 'Busca una funcionalidad...',
            onChanged: (value) => setState(() => _query = value),
            leading: const Icon(Icons.search),
            trailing: [
              if (query.isNotEmpty)
                IconButton(
                  onPressed: () => setState(() => _query = ''),
                  icon: const Icon(Icons.clear),
                )
              else
                IconButton(onPressed: () {}, icon: const Icon(Icons.tune)),
            ],
            shape: const WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(28))),
            ),
          ).animate().fadeIn(delay: 100.ms),
          const SizedBox(height: 16),
          Card(
            color: cs.primaryContainer.withValues(alpha: 0.35),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text('Panel de Productividad', style: Theme.of(context).textTheme.titleLarge),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 62,
                        height: 62,
                        child: ProgressWithLabelM3E(value: _productivity),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  LinearProgressIndicatorM3E(value: _productivity),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      FilterChip(
                        label: const Text('Focus Mode'),
                        selected: _focusMode,
                        onSelected: (selected) => setState(() => _focusMode = selected),
                      ),
                      FilterChip(
                        label: const Text('Smart Alerts'),
                        selected: _smartAlerts,
                        onSelected: (selected) => setState(() => _smartAlerts = selected),
                      ),
                      ButtonM3E(
                        label: const Text('Boost +5%'),
                        style: ButtonM3EStyle.tonal,
                        onPressed: () => setState(() => _productivity = (_productivity + 0.05).clamp(0.0, 1.0)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(delay: 140.ms).slideY(begin: 0.06, end: 0),
          const SizedBox(height: 16),
          Text('Módulos activos', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          ...filteredModules.asMap().entries.map((entry) {
            final index = entry.key;
            final module = entry.value;
            final palette = [cs.primary, cs.secondary, cs.tertiary, cs.error];
            final tint = palette[index % palette.length];
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Card(
                color: tint.withValues(alpha: 0.14),
                child: ListTile(
                  onTap: () => _openModule(module),
                  leading: m3shapes.M3EContainer.pill(
                    width: 44,
                    height: 44,
                    color: tint,
                    child: Icon(module.icon, color: cs.onPrimary),
                  ),
                  title: Text(module.title),
                  subtitle: Text(module.subtitle),
                  trailing: IconButtonM3E(
                    icon: const Icon(Icons.launch),
                    onPressed: () => _openModule(module),
                    variant: IconButtonM3EVariant.tonal,
                  ),
                ),
              ).animate().fadeIn(delay: Duration(milliseconds: 90 + (index * 60))).slideX(begin: 0.04, end: 0),
            );
          }),
          if (filteredModules.isEmpty) ...[
            const SizedBox(height: 12),
            Text(
              'No se encontraron funcionalidades con "$query".',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
            ),
          ],
          const SizedBox(height: 12),
          Card(
            color: cs.secondaryContainer.withValues(alpha: 0.38),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Agenda inteligente de hoy', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  m3ec.M3ECardColumn(
                    children: List.generate(tasks.length, (index) {
                      final done = _doneTasks.contains(index);
                      return ListTile(
                        leading: Icon(done ? Icons.check_circle : Icons.radio_button_unchecked),
                        title: Text(
                          tasks[index],
                          style: TextStyle(
                            decoration: done ? TextDecoration.lineThrough : null,
                          ),
                        ),
                        trailing: ButtonM3E(
                          label: Text(done ? 'Hecho' : 'Marcar'),
                          size: ButtonM3ESize.sm,
                          style: done ? ButtonM3EStyle.tonal : ButtonM3EStyle.outlined,
                          onPressed: () {
                            setState(() {
                              if (done) {
                                _doneTasks.remove(index);
                                _productivity = (_productivity - 0.04).clamp(0.0, 1.0);
                              } else {
                                _doneTasks.add(index);
                                _productivity = (_productivity + 0.04).clamp(0.0, 1.0);
                              }
                            });
                          },
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(delay: 300.ms).slideX(begin: 0.08, end: 0),
        ],
      ),
    );
  }
}

class _UtilityModuleScreen extends StatelessWidget {
  const _UtilityModuleScreen({required this.module});

  final _UtilityModule module;

  @override
  Widget build(BuildContext context) {
    final Widget content = switch (module.kind) {
      _ModuleKind.routines => const _RoutinesModulePanel(),
      _ModuleKind.focus => const _FocusModulePanel(),
      _ModuleKind.finance => const _FinanceModulePanel(),
      _ModuleKind.health => const _HealthModulePanel(),
      _ModuleKind.agenda => const _AgendaModulePanel(),
      _ModuleKind.automation => const _AutomationModulePanel(),
    };

    return Scaffold(
      appBar: AppBarM3E(titleText: module.title),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _HeroBlast(
            title: module.title,
            subtitle: module.subtitle,
            icon: module.icon,
          ),
          const SizedBox(height: 16),
          content,
        ],
      ),
    );
  }
}

class _RoutinesModulePanel extends StatefulWidget {
  const _RoutinesModulePanel();

  @override
  State<_RoutinesModulePanel> createState() => _RoutinesModulePanelState();
}

class _RoutinesModulePanelState extends State<_RoutinesModulePanel> {
  final Set<int> _done = {1};
  final List<String> _habits = const ['Leer 20 min', 'Estirar 10 min', 'Planificar top 3', 'Inbox cero'];

  @override
  void initState() {
    super.initState();
    _loadState();
  }

  Future<void> _loadState() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(PrefKeys.routinesDone);
    if (raw == null || !mounted) {
      return;
    }
    setState(() {
      _done
        ..clear()
        ..addAll(raw.map(int.tryParse).whereType<int>());
    });
  }

  Future<void> _saveState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(PrefKeys.routinesDone, _done.map((e) => '$e').toList());
  }

  @override
  Widget build(BuildContext context) {
    final completed = _done.length / _habits.length;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Streak semanal', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            LinearProgressIndicatorM3E(value: completed),
            const SizedBox(height: 10),
            Text('${_done.length}/${_habits.length} hábitos completados', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 12),
            ...List.generate(_habits.length, (index) {
              final done = _done.contains(index);
              return CheckboxListTile(
                value: done,
                onChanged: (_) {
                  setState(() {
                    if (done) {
                      _done.remove(index);
                    } else {
                      _done.add(index);
                    }
                  });
                  _saveState();
                },
                title: Text(_habits[index]),
                controlAffinity: ListTileControlAffinity.leading,
              );
            }),
          ],
        ),
      ),
    ).animate().fadeIn().slideY(begin: 0.08, end: 0);
  }
}

class _FocusModulePanel extends StatefulWidget {
  const _FocusModulePanel();

  @override
  State<_FocusModulePanel> createState() => _FocusModulePanelState();
}

class _FocusModulePanelState extends State<_FocusModulePanel> {
  static const List<int> _presetMinutes = [5, 10, 15, 25, 45, 60];
  int _durationMinutes = 25;
  List<int> _favoriteMinutes = [15, 25, 45];
  Timer? _timer;
  int _remaining = 25 * 60;

  int get _totalSeconds => _durationMinutes * 60;

  @override
  void initState() {
    super.initState();
    _loadState();
  }

  Future<void> _loadState() async {
    final prefs = await SharedPreferences.getInstance();
    final duration = prefs.getInt(PrefKeys.focusDuration);
    final saved = prefs.getInt(PrefKeys.focusRemaining);
    final rawFavorites = prefs.getStringList(PrefKeys.focusFavorites);
    if (!mounted) {
      return;
    }
    setState(() {
      if (duration != null) {
        _durationMinutes = duration.clamp(5, 60);
      }
      if (rawFavorites != null && rawFavorites.isNotEmpty) {
        final ordered = <int>[];
        for (final value in rawFavorites.map(int.tryParse).whereType<int>()) {
          if (value >= 5 && value <= 60 && !ordered.contains(value)) {
            ordered.add(value);
          }
        }
        if (ordered.isNotEmpty) {
          _favoriteMinutes = ordered;
        }
      }
      if (saved != null) {
        _remaining = saved.clamp(0, _totalSeconds);
      } else {
        _remaining = _totalSeconds;
      }
    });
  }

  Future<void> _saveState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(PrefKeys.focusDuration, _durationMinutes);
    await prefs.setInt(PrefKeys.focusRemaining, _remaining);
    await prefs.setStringList(PrefKeys.focusFavorites, _favoriteMinutes.map((m) => '$m').toList());
  }

  void _setDurationMinutes(int minutes) {
    final normalized = minutes.clamp(5, 60);
    _timer?.cancel();
    _timer = null;
    setState(() {
      _durationMinutes = normalized;
      _remaining = _totalSeconds;
    });
    _saveState();
  }

  void _addCurrentToFavorites() {
    if (_favoriteMinutes.contains(_durationMinutes)) {
      return;
    }
    setState(() {
      _favoriteMinutes = [..._favoriteMinutes, _durationMinutes];
      if (_favoriteMinutes.length > 4) {
        _favoriteMinutes = _favoriteMinutes.sublist(1);
      }
    });
    _saveState();
  }

  void _removeFavorite(int minutes) {
    setState(() {
      _favoriteMinutes.remove(minutes);
      if (_favoriteMinutes.isEmpty) {
        _favoriteMinutes = [15, 25, 45];
      }
    });
    _saveState();
  }

  void _reorderFavorites(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final item = _favoriteMinutes.removeAt(oldIndex);
      _favoriteMinutes.insert(newIndex, item);
    });
    _saveState();
  }

  bool get _running => _timer != null;

  void _toggleTimer() {
    if (_running) {
      _timer?.cancel();
      _timer = null;
      setState(() {});
      _saveState();
      return;
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_remaining <= 0) {
        timer.cancel();
        _timer = null;
        setState(() {});
        _saveState();
        return;
      }
      setState(() => _remaining -= 1);
      _saveState();
    });
    setState(() {});
  }

  void _reset() {
    _timer?.cancel();
    _timer = null;
    setState(() => _remaining = _totalSeconds);
    _saveState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _saveState();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress = 1 - (_remaining / _totalSeconds);
    final minutes = (_remaining ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remaining % 60).toString().padLeft(2, '0');
    final selectedPreset = _presetMinutes.contains(_durationMinutes)
        ? _presetMinutes.indexOf(_durationMinutes)
        : null;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text('Focus Timer', style: Theme.of(context).textTheme.titleLarge),
                ),
                SizedBox(
                  width: 64,
                  height: 64,
                  child: ProgressWithLabelM3E(value: progress),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text('$minutes:$seconds', style: Theme.of(context).textTheme.displayMedium),
            const SizedBox(height: 10),
            LinearProgressIndicatorM3E(value: progress),
            const SizedBox(height: 14),
            Text('Duración acotada: $_durationMinutes min', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 10),
            ButtonGroupM3E(
              selection: true,
              selectedIndex: selectedPreset,
              actions: _presetMinutes
                  .map(
                    (m) => ButtonGroupM3EAction(
                      label: Text('${m}m'),
                      onPressed: () => _setDurationMinutes(m),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 52,
                    child: ReorderableListView.builder(
                      scrollDirection: Axis.horizontal,
                      buildDefaultDragHandles: false,
                      itemCount: _favoriteMinutes.length,
                      onReorder: _reorderFavorites,
                      itemBuilder: (context, index) {
                        final m = _favoriteMinutes[index];
                        return Padding(
                          key: ValueKey('fav-$m'),
                          padding: const EdgeInsets.only(right: 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InputChip(
                                label: Text('Fav ${m}m'),
                                selected: _durationMinutes == m,
                                onSelected: (_) => _setDurationMinutes(m),
                                onDeleted: _favoriteMinutes.length > 1 ? () => _removeFavorite(m) : null,
                              ),
                              ReorderableDragStartListener(
                                index: index,
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 4),
                                  child: Icon(Icons.drag_indicator, size: 18),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ButtonM3E(
                  label: const Text('Guardar'),
                  size: ButtonM3ESize.sm,
                  style: ButtonM3EStyle.outlined,
                  onPressed: _addCurrentToFavorites,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                IconButtonM3E(
                  icon: const Icon(Icons.remove),
                  onPressed: _durationMinutes > 5 ? () => _setDurationMinutes(_durationMinutes - 5) : null,
                ),
                Expanded(
                  child: SliderM3E(
                    value: (_durationMinutes - 5) / 55,
                    onChanged: (v) {
                      final stepped = (5 + (v * 11).round() * 5).clamp(5, 60);
                      _setDurationMinutes(stepped);
                    },
                    showValueIndicator: true,
                    startIcon: const Icon(Icons.timer_rounded),
                    endIcon: const Icon(Icons.hourglass_bottom),
                  ),
                ),
                IconButtonM3E(
                  icon: const Icon(Icons.add),
                  onPressed: _durationMinutes < 60 ? () => _setDurationMinutes(_durationMinutes + 5) : null,
                  variant: IconButtonM3EVariant.filled,
                ),
              ],
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 10,
              children: [
                ButtonM3E(
                  label: Text(_running ? 'Pausar' : 'Iniciar'),
                  style: ButtonM3EStyle.filled,
                  onPressed: _toggleTimer,
                ),
                ButtonM3E(
                  label: const Text('Reiniciar'),
                  style: ButtonM3EStyle.tonal,
                  onPressed: _reset,
                ),
              ],
            ),
          ],
        ),
      ),
    ).animate().fadeIn().slideY(begin: 0.08, end: 0);
  }
}

class _FinanceModulePanel extends StatefulWidget {
  const _FinanceModulePanel();

  @override
  State<_FinanceModulePanel> createState() => _FinanceModulePanelState();
}

class _FinanceModulePanelState extends State<_FinanceModulePanel> {
  double _spent = 0.56;

  @override
  void initState() {
    super.initState();
    _loadState();
  }

  Future<void> _loadState() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getDouble(PrefKeys.financeSpent);
    if (saved == null || !mounted) {
      return;
    }
    setState(() => _spent = saved.clamp(0.0, 1.0));
  }

  Future<void> _saveState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(PrefKeys.financeSpent, _spent);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final spentAmount = (2500 * _spent).round();
    final budgetAmount = 2500;

    return Card(
      color: cs.tertiaryContainer.withValues(alpha: 0.38),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Presupuesto mensual', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text('\$$spentAmount / \$$budgetAmount'),
            const SizedBox(height: 10),
            LinearProgressIndicatorM3E(value: _spent),
            const SizedBox(height: 12),
            SliderM3E(
              value: _spent,
              onChanged: (v) {
                setState(() => _spent = v);
                _saveState();
              },
              showValueIndicator: true,
            ),
            const SizedBox(height: 10),
            m3ec.M3ECardColumn(
              children: const [
                ListTile(leading: Icon(Icons.fastfood), title: Text('Comida'), trailing: Text('\$580')),
                ListTile(leading: Icon(Icons.directions_car), title: Text('Transporte'), trailing: Text('\$290')),
                ListTile(leading: Icon(Icons.movie), title: Text('Ocio'), trailing: Text('\$180')),
              ],
            ),
          ],
        ),
      ),
    ).animate().fadeIn().slideY(begin: 0.08, end: 0);
  }
}

class _HealthModulePanel extends StatefulWidget {
  const _HealthModulePanel();

  @override
  State<_HealthModulePanel> createState() => _HealthModulePanelState();
}

class _HealthModulePanelState extends State<_HealthModulePanel> {
  int _waterGlasses = 3;
  double _stepsProgress = 0.42;

  @override
  void initState() {
    super.initState();
    _loadState();
  }

  Future<void> _loadState() async {
    final prefs = await SharedPreferences.getInstance();
    final water = prefs.getInt(PrefKeys.healthWater);
    final steps = prefs.getDouble(PrefKeys.healthSteps);
    if (!mounted) {
      return;
    }
    setState(() {
      if (water != null) {
        _waterGlasses = water.clamp(0, 8);
      }
      if (steps != null) {
        _stepsProgress = steps.clamp(0.0, 1.0);
      }
    });
  }

  Future<void> _saveState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(PrefKeys.healthWater, _waterGlasses);
    await prefs.setDouble(PrefKeys.healthSteps, _stepsProgress);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bienestar diario', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Text('Hidratación: $_waterGlasses / 8 vasos'),
                ),
                IconButtonM3E(
                  icon: const Icon(Icons.remove),
                  onPressed: _waterGlasses > 0
                      ? () {
                          setState(() => _waterGlasses -= 1);
                          _saveState();
                        }
                      : null,
                ),
                IconButtonM3E(
                  icon: const Icon(Icons.add),
                  onPressed: _waterGlasses < 8
                      ? () {
                          setState(() => _waterGlasses += 1);
                          _saveState();
                        }
                      : null,
                  variant: IconButtonM3EVariant.filled,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text('Pasos del día', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            LinearProgressIndicatorM3E(value: _stepsProgress),
            const SizedBox(height: 10),
            Slider(
              value: _stepsProgress,
              onChanged: (v) {
                setState(() => _stepsProgress = v);
                _saveState();
              },
            ),
          ],
        ),
      ),
    ).animate().fadeIn().slideY(begin: 0.08, end: 0);
  }
}

class _AgendaModulePanel extends StatefulWidget {
  const _AgendaModulePanel();

  @override
  State<_AgendaModulePanel> createState() => _AgendaModulePanelState();
}

class _AgendaModulePanelState extends State<_AgendaModulePanel> {
  final Set<int> _confirmed = {};
  final List<String> _events = const ['Daily sync - 10:00', 'Diseño UX - 11:30', 'Deep work - 15:00', 'Retro - 18:00'];

  @override
  void initState() {
    super.initState();
    _loadState();
  }

  Future<void> _loadState() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(PrefKeys.agendaConfirmed);
    if (raw == null || !mounted) {
      return;
    }
    setState(() {
      _confirmed
        ..clear()
        ..addAll(raw.map(int.tryParse).whereType<int>());
    });
  }

  Future<void> _saveState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(PrefKeys.agendaConfirmed, _confirmed.map((e) => '$e').toList());
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Agenda priorizada', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),
            ...List.generate(_events.length, (index) {
              final ok = _confirmed.contains(index);
              return ListTile(
                leading: Icon(ok ? Icons.event_available : Icons.event_busy),
                title: Text(_events[index]),
                trailing: ButtonM3E(
                  label: Text(ok ? 'Confirmado' : 'Confirmar'),
                  size: ButtonM3ESize.sm,
                  style: ok ? ButtonM3EStyle.tonal : ButtonM3EStyle.outlined,
                  onPressed: () {
                    setState(() => _confirmed.add(index));
                    _saveState();
                  },
                ),
              );
            }),
          ],
        ),
      ),
    ).animate().fadeIn().slideY(begin: 0.08, end: 0);
  }
}

class _AutomationModulePanel extends StatefulWidget {
  const _AutomationModulePanel();

  @override
  State<_AutomationModulePanel> createState() => _AutomationModulePanelState();
}

class _AutomationModulePanelState extends State<_AutomationModulePanel> {
  bool _nightRoutine = true;
  bool _meetingMode = false;
  bool _budgetAlert = true;

  @override
  void initState() {
    super.initState();
    _loadState();
  }

  Future<void> _loadState() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) {
      return;
    }
    setState(() {
      _nightRoutine = prefs.getBool(PrefKeys.autoNight) ?? _nightRoutine;
      _meetingMode = prefs.getBool(PrefKeys.autoMeeting) ?? _meetingMode;
      _budgetAlert = prefs.getBool(PrefKeys.autoBudget) ?? _budgetAlert;
    });
  }

  Future<void> _saveState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(PrefKeys.autoNight, _nightRoutine);
    await prefs.setBool(PrefKeys.autoMeeting, _meetingMode);
    await prefs.setBool(PrefKeys.autoBudget, _budgetAlert);
  }

  @override
  Widget build(BuildContext context) {
    final active = [_nightRoutine, _meetingMode, _budgetAlert].where((item) => item).length;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Reglas activas: $active / 3', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),
            SwitchListTile(
              title: const Text('Rutina nocturna automática'),
              subtitle: const Text('Atenúa brillo y activa sonido ambiente'),
              value: _nightRoutine,
              onChanged: (v) {
                setState(() => _nightRoutine = v);
                _saveState();
              },
            ),
            SwitchListTile(
              title: const Text('Modo reuniones'),
              subtitle: const Text('Silencia notificaciones al iniciar calendario'),
              value: _meetingMode,
              onChanged: (v) {
                setState(() => _meetingMode = v);
                _saveState();
              },
            ),
            SwitchListTile(
              title: const Text('Alerta de presupuesto'),
              subtitle: const Text('Notifica al superar 80% del límite mensual'),
              value: _budgetAlert,
              onChanged: (v) {
                setState(() => _budgetAlert = v);
                _saveState();
              },
            ),
          ],
        ),
      ),
    ).animate().fadeIn().slideY(begin: 0.08, end: 0);
  }
}

class _ButtonsScreen extends StatelessWidget {
  const _ButtonsScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarM3E(titleText: 'Buttons & Toolbar M3E'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _HeroBlast(
              title: 'Buttons Playground',
              subtitle: 'Variantes expresivas, split actions y motion en estado puro.',
              icon: Icons.smart_button,
            ),
            const SizedBox(height: 16),
            Text('ButtonM3E Variants', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 14),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ButtonM3E(
                  label: const Text('Filled SM'),
                  style: ButtonM3EStyle.filled,
                  size: ButtonM3ESize.sm,
                  onPressed: () {},
                ),
                ButtonM3E(
                  label: const Text('Tonal MD'),
                  style: ButtonM3EStyle.tonal,
                  size: ButtonM3ESize.md,
                  onPressed: () {},
                ),
                ButtonM3E(
                  label: const Text('Outlined LG'),
                  style: ButtonM3EStyle.outlined,
                  size: ButtonM3ESize.lg,
                  onPressed: () {},
                ),
                ButtonM3E(
                  label: const Text('Text'),
                  style: ButtonM3EStyle.text,
                  onPressed: () {},
                ),
                ButtonM3E(
                  label: const Text('Elevated'),
                  style: ButtonM3EStyle.elevated,
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text('IconButtonM3E', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              children: [
                IconButtonM3E(icon: const Icon(Icons.favorite), onPressed: () {}),
                IconButtonM3E(icon: const Icon(Icons.bookmark), variant: IconButtonM3EVariant.tonal, onPressed: () {}),
                IconButtonM3E(icon: const Icon(Icons.share), variant: IconButtonM3EVariant.filled, onPressed: () {}),
                IconButtonM3E(icon: const Icon(Icons.delete), variant: IconButtonM3EVariant.outlined, onPressed: () {}),
              ],
            ),
            const SizedBox(height: 24),
            Text('SplitButtonM3E', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            SplitButtonM3E<String>(
              label: 'Guardar',
              onPressed: () {},
              items: const [
                SplitButtonM3EItem<String>(value: 'save', child: Text('Guardar')),
                SplitButtonM3EItem<String>(value: 'saveAs', child: Text('Guardar como')),
              ],
              onSelected: (value) {},
            ),
            const SizedBox(height: 24),
            Text('ButtonGroupM3E', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            ButtonGroupM3E(
              selection: true,
              selectedIndex: 1,
              actions: [
                ButtonGroupM3EAction(label: const Text('Dia'), onPressed: () {}),
                ButtonGroupM3EAction(label: const Text('Semana'), onPressed: () {}),
                ButtonGroupM3EAction(label: const Text('Mes'), onPressed: () {}),
              ],
            ),
            const SizedBox(height: 24),
            Text('ToolbarM3E', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            ToolbarM3E(
              titleText: 'Editor Expresivo',
              actions: [
                ToolbarActionM3E(icon: Icons.format_bold, onPressed: () {}, label: 'Negrita'),
                ToolbarActionM3E(icon: Icons.format_italic, onPressed: () {}, label: 'Cursiva'),
                ToolbarActionM3E(icon: Icons.format_underlined, onPressed: () {}, label: 'Subrayado'),
                ToolbarActionM3E(icon: Icons.delete_outline, onPressed: () {}, label: 'Borrar', isDestructive: true),
              ],
            ),
            const SizedBox(height: 24),
            Text('m3e_buttons package', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                m3eb.M3EButton(
                  onPressed: () {},
                  style: m3eb.M3EButtonStyle.filled,
                  child: const Text('M3E Filled'),
                ),
                m3eb.M3EButton(
                  onPressed: () {},
                  style: m3eb.M3EButtonStyle.tonal,
                  child: const Text('M3E Tonal'),
                ),
                m3eb.M3EButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text('Icon Button'),
                  style: m3eb.M3EButtonStyle.outlined,
                ),
              ],
            ),
            const SizedBox(height: 16),
            m3eb.M3ESplitButton<String>(
              label: 'Split v2',
              onPressed: () {},
              onSelected: (_) {},
              items: const [
                m3eb.M3ESplitButtonItem<String>(value: 'copy', child: Text('Copiar')),
                m3eb.M3ESplitButtonItem<String>(value: 'move', child: Text('Mover')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _NavigationScreen extends StatelessWidget {
  const _NavigationScreen();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: const AppBarM3E(titleText: 'Navigation M3E'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _HeroBlast(
              title: 'Navigation Experiments',
              subtitle: 'Destinos, rail y comportamiento expresivo de layout.',
              icon: Icons.alt_route,
            ),
            const SizedBox(height: 16),
            Text('NavigationBarM3E', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: cs.surfaceContainer,
                borderRadius: BorderRadius.circular(24),
              ),
              child: NavigationBarM3E(
                selectedIndex: 1,
                onDestinationSelected: (_) {},
                destinations: const [
                  NavigationDestinationM3E(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
                  NavigationDestinationM3E(icon: Icon(Icons.search_outlined), selectedIcon: Icon(Icons.search), label: 'Search'),
                  NavigationDestinationM3E(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text('NavigationRailM3E', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: cs.surfaceContainer,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    NavigationRailM3E(
                      selectedIndex: 0,
                      onDestinationSelected: (_) {},
                      sections: const [
                        NavigationRailM3ESection(
                          destinations: [
                            NavigationRailM3EDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard), label: 'Dashboard'),
                            NavigationRailM3EDestination(icon: Icon(Icons.explore_outlined), selectedIcon: Icon(Icons.explore), label: 'Explore'),
                            NavigationRailM3EDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings), label: 'Settings'),
                          ],
                        ),
                      ],
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Contenido de ejemplo',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProgressAndMotionScreen extends StatefulWidget {
  const _ProgressAndMotionScreen();

  @override
  State<_ProgressAndMotionScreen> createState() => _ProgressAndMotionScreenState();
}

class _ProgressAndMotionScreenState extends State<_ProgressAndMotionScreen> {
  double _value = 0.62;
  bool _toggled = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: const AppBarM3E(titleText: 'Progress, Slider & Motion'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _HeroBlast(
            title: 'Motion and Progress Lab',
            subtitle: 'Indicadores morfologicos, sliders y micro-animaciones continuas.',
            icon: Icons.animation,
          ),
          const SizedBox(height: 16),
          Text('Progress Indicator M3E', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 12),
          LinearProgressIndicatorM3E(value: _value),
          const SizedBox(height: 14),
          Row(
            children: [
              CircularProgressIndicatorM3E(value: _value),
              const SizedBox(width: 20),
              ProgressWithLabelM3E(value: _value),
              const SizedBox(width: 20),
              const LoadingIndicatorM3E(),
              const SizedBox(width: 20),
              const SizedBox(width: 48, height: 48, child: eli.ExpressiveLoadingIndicator()),
            ],
          ),
          const SizedBox(height: 28),
          Text('Slider M3E', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          SliderM3E(
            value: _value,
            onChanged: (v) => setState(() => _value = v),
            size: SliderM3ESize.large,
            showValueIndicator: true,
            startIcon: const Icon(Icons.volume_mute),
            endIcon: const Icon(Icons.volume_up),
          ),
          const SizedBox(height: 12),
          RangeSliderM3E(
            values: RangeValues(_value * 0.5, _value),
            onChanged: (_) {},
          ),
          const SizedBox(height: 28),
          Text('Motion demo', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () => setState(() => _toggled = !_toggled),
            child: AnimatedContainer(
              duration: 700.ms,
              curve: Curves.easeInOutCubicEmphasized,
              width: _toggled ? 260 : 140,
              height: _toggled ? 120 : 180,
              decoration: BoxDecoration(
                color: _toggled ? cs.primary : cs.tertiary,
                borderRadius: BorderRadius.circular(_toggled ? 60 : 24),
              ),
              child: Icon(_toggled ? Icons.play_arrow : Icons.pause, color: cs.onPrimary, size: 56),
            ),
          ).animate().fadeIn().shimmer(duration: 1800.ms, color: cs.primary.withValues(alpha: 0.1)),
        ],
      ),
    );
  }
}

class _RefreshAndAppBarScreen extends StatefulWidget {
  const _RefreshAndAppBarScreen();

  @override
  State<_RefreshAndAppBarScreen> createState() => _RefreshAndAppBarScreenState();
}

class _RefreshAndAppBarScreenState extends State<_RefreshAndAppBarScreen> {
  final List<int> _items = List<int>.generate(20, (i) => i + 1);
  bool _isRefreshing = false;
  int _refreshCount = 0;
  DateTime? _lastRefreshAt;

  Future<void> _onRefresh() async {
    if (_isRefreshing) {
      return;
    }
    setState(() => _isRefreshing = true);
    await Future<void>.delayed(const Duration(milliseconds: 900));
    if (!mounted) {
      return;
    }
    setState(() {
      for (var i = 0; i < 3; i++) {
        _items.insert(0, _items.length + 1);
      }
      _refreshCount += 1;
      _lastRefreshAt = DateTime.now();
      _isRefreshing = false;
    });
  }

  Future<void> _resetAndRefresh() async {
    if (_isRefreshing) {
      return;
    }
    setState(() {
      _items
        ..clear()
        ..addAll(List<int>.generate(10, (i) => i + 1));
    });
    await _onRefresh();
  }

  String _formatLastRefresh() {
    final date = _lastRefreshAt;
    if (date == null) {
      return 'Sin refrescos aún';
    }
    final h = date.hour.toString().padLeft(2, '0');
    final m = date.minute.toString().padLeft(2, '0');
    final s = date.second.toString().padLeft(2, '0');
    return 'Último refresh: $h:$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarM3E(
        titleText: 'expressive_refresh + app_bar_m3e',
        actions: [
          IconButtonM3E(icon: const Icon(Icons.replay), onPressed: _onRefresh),
          IconButtonM3E(icon: const Icon(Icons.cleaning_services_outlined), onPressed: _resetAndRefresh),
        ],
      ),
      body: ExpressiveRefreshIndicator.contained(
        onRefresh: _onRefresh,
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: _items.length + 1,
          separatorBuilder: (_, _) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            if (index == 0) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Laboratorio de Refresh', style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 6),
                      Text(
                        'Haz pull-to-refresh o usa los botones para forzar recarga y ver el comportamiento en vivo.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          ButtonM3E(
                            label: Text(_isRefreshing ? 'Refrescando...' : 'Forzar refresh'),
                            onPressed: _isRefreshing ? null : _onRefresh,
                            style: ButtonM3EStyle.filled,
                          ),
                          ButtonM3E(
                            label: const Text('Reset + Refresh'),
                            onPressed: _isRefreshing ? null : _resetAndRefresh,
                            style: ButtonM3EStyle.tonal,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(child: Text('Refresh ejecutados: $_refreshCount')),
                          if (_isRefreshing) const SizedBox(width: 24, height: 24, child: eli.ExpressiveLoadingIndicator()),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(_formatLastRefresh(), style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
              );
            }
            final item = _items[index - 1];
            return Card(
              child: ListTile(
                leading: Icon(item.isEven ? Icons.widgets : Icons.auto_awesome),
                title: Text('Componente demostrativo #$item'),
                subtitle: const Text('Haz pull-to-refresh para insertar más elementos'),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CoreWidgetsScreen extends StatefulWidget {
  const _CoreWidgetsScreen();

  @override
  State<_CoreWidgetsScreen> createState() => _CoreWidgetsScreenState();
}

class _CoreWidgetsScreenState extends State<_CoreWidgetsScreen> {
  final List<String> _demoItems = ['Alpha', 'Beta', 'Gamma', 'Delta'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarM3E(titleText: 'm3e_core gallery'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _HeroBlast(
            title: 'Core Widgets Studio',
            subtitle: 'Cards, dismiss, expand y dropdown para UX compleja.',
            icon: Icons.widgets,
          ),
          const SizedBox(height: 16),
          Text('M3ECardColumn', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          m3ec.M3ECardColumn(
            children: const [
              ListTile(leading: Icon(Icons.palette), title: Text('Card item 1')),
              ListTile(leading: Icon(Icons.layers), title: Text('Card item 2')),
              ListTile(leading: Icon(Icons.bolt), title: Text('Card item 3')),
            ],
          ),
          const SizedBox(height: 24),
          Text('M3EDismissibleCardColumn', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          m3ec.M3EDismissibleCardColumn(
            itemCount: _demoItems.length,
            itemBuilder: (context, index) => ListTile(
              title: Text('Dismissible ${_demoItems[index]}'),
              subtitle: const Text('Desliza a un lado para probar'),
            ),
            onDismiss: (index, direction) async => true,
          ),
          const SizedBox(height: 24),
          Text('M3EExpandableCardColumn', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          m3ec.M3EExpandableCardColumn(
            itemCount: 3,
            headerBuilder: (context, index, isExpanded) => Row(
              children: [
                Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
                const SizedBox(width: 8),
                Text('Seccion #${index + 1}'),
              ],
            ),
            bodyBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text('Contenido extendido de la seccion #${index + 1}.'),
            ),
          ),
          const SizedBox(height: 24),
          Text('M3EDropdownMenu', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          m3ec.M3EDropdownMenu<String>(
            singleSelect: true,
            searchEnabled: true,
            items: const [
              m3ec.M3EDropdownItem(label: 'Expressive Blue', value: 'blue'),
              m3ec.M3EDropdownItem(label: 'Expressive Green', value: 'green'),
              m3ec.M3EDropdownItem(label: 'Expressive Amber', value: 'amber'),
            ],
            onSelectionChanged: (items) {},
          ),
        ],
      ),
    );
  }
}

class _ShapesLabScreen extends StatelessWidget {
  const _ShapesLabScreen();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: const AppBarM3E(titleText: 'flutter_m3shapes_extended'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _HeroBlast(
            title: 'Shapes Lab',
            subtitle: 'Geometrias M3E para composiciones mas audaces.',
            icon: Icons.category,
          ),
          const SizedBox(height: 16),
          Text('Shape Lab', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 8),
          Text(
            'Contenedores clippeados con geometrías Material 3 expresivas.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
              m3shapes.M3EContainer.gem(
                width: 110,
                height: 110,
                color: cs.primaryContainer,
                child: Icon(Icons.diamond, color: cs.onPrimaryContainer),
              ),
              m3shapes.M3EContainer.flower(
                width: 110,
                height: 110,
                color: cs.secondaryContainer,
                child: Icon(Icons.local_florist, color: cs.onSecondaryContainer),
              ),
              m3shapes.M3EContainer.softBurst(
                width: 110,
                height: 110,
                color: cs.tertiaryContainer,
                child: Icon(Icons.brightness_high, color: cs.onTertiaryContainer),
              ),
              m3shapes.M3EContainer.puffyDiamond(
                width: 110,
                height: 110,
                color: cs.errorContainer,
                child: Icon(Icons.auto_awesome, color: cs.onErrorContainer),
              ),
              m3shapes.M3EContainer.boom(
                width: 110,
                height: 110,
                color: cs.surfaceContainerHighest,
                child: Icon(Icons.flash_on, color: cs.onSurface),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroBlast extends StatelessWidget {
  const _HeroBlast({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [cs.primaryContainer, cs.tertiaryContainer],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: [
          m3shapes.M3EContainer.softBurst(
            width: 58,
            height: 58,
            color: cs.primary,
            child: Icon(icon, color: cs.onPrimary),
          ).animate(onPlay: (controller) => controller.repeat(reverse: true)).scale(begin: const Offset(0.94, 0.94), end: const Offset(1.08, 1.08), duration: 1600.ms),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 2),
                Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 350.ms).slideY(begin: 0.08, end: 0);
  }
}

class _LibrariesScreen extends StatelessWidget {
  const _LibrariesScreen();

  static final List<_LibraryDoc> _docs = [
    _LibraryDoc(
      name: 'm3e_collection',
      description: 'Agregador principal de componentes M3E para acelerar integración UI.',
      icon: Icons.apps,
      tint: const Color(0xFF6750A4),
      highlights: ['ButtonM3E', 'FabM3E', 'NavigationBarM3E', 'ToolbarM3E'],
      sections: [
        _LibraryGuideSection(
          title: 'Integración base',
          bullets: [
            'Importa el paquete en la capa UI donde montas componentes expresivos.',
            'Centraliza tokens visuales en tu ThemeData y usa los widgets de colección para coherencia.',
            'Combina con flutter_animate para entradas y feedback de interacción.',
          ],
        ),
      ],
      samples: [
        _LibrarySample(
          id: 'm3e_collection.button_pack',
          title: 'Pack de acciones primarias',
          description: 'Ejemplo de botón principal + FAB contextual para acciones rápidas.',
          fileName: 'lib/ui/actions_panel.dart',
          code: "import 'package:m3e_collection/m3e_collection.dart';\n\nWrap(\n  spacing: 12,\n  children: [\n    ButtonM3E(\n      label: Text('Guardar cambios'),\n      style: ButtonM3EStyle.filled,\n      onPressed: () {},\n    ),\n    FabM3E(\n      icon: Icon(Icons.add),\n      kind: FabM3EKind.primary,\n      onPressed: () {},\n    ),\n  ],\n);",
        ),
        _LibrarySample(
          id: 'm3e_collection.nav_pack',
          title: 'Navegación expresiva',
          description: 'Navegación inferior con estados seleccionados y animación implícita.',
          fileName: 'lib/ui/navigation_shell.dart',
          code: "NavigationBarM3E(\n  selectedIndex: 1,\n  onDestinationSelected: (i) {},\n  destinations: const [\n    NavigationDestinationM3E(icon: Icon(Icons.home_outlined), label: 'Inicio'),\n    NavigationDestinationM3E(icon: Icon(Icons.search_outlined), label: 'Buscar'),\n    NavigationDestinationM3E(icon: Icon(Icons.person_outline), label: 'Perfil'),\n  ],\n);",
        ),
      ],
    ),
    _LibraryDoc(
      name: 'm3e_buttons',
      description: 'Botonera avanzada para flujos de decisión, split actions y acciones agrupadas.',
      icon: Icons.smart_button,
      tint: const Color(0xFF006E6D),
      highlights: ['M3EButton', 'M3ESplitButton', 'M3EButton.icon'],
      sections: [
        _LibraryGuideSection(
          title: 'Cuándo usarlo',
          bullets: [
            'Usa split button cuando una acción principal tiene variantes.',
            'Usa variante tonal para acciones secundarias y outlined para bajo énfasis.',
            'Alinea tamaños de botones por densidad de pantalla (sm, md, lg).',
          ],
        ),
      ],
      samples: [
        _LibrarySample(
          id: 'm3e_buttons.split',
          title: 'Split action de edición',
          description: 'Acción principal con menú alterno para flujos editoriales.',
          fileName: 'lib/ui/editor_actions.dart',
          code: "m3eb.M3ESplitButton<String>(\n  label: 'Publicar',\n  onPressed: () {},\n  onSelected: (value) {},\n  items: const [\n    m3eb.M3ESplitButtonItem(value: 'draft', child: Text('Guardar borrador')),\n    m3eb.M3ESplitButtonItem(value: 'schedule', child: Text('Programar')),\n  ],\n);",
        ),
      ],
    ),
    _LibraryDoc(
      name: 'm3e_core',
      description: 'Patrones de interfaz compleja: columnas de cards, expandibles, dismissibles y selección.',
      icon: Icons.extension,
      tint: const Color(0xFF7B5800),
      highlights: ['M3ECardColumn', 'M3EExpandableCardColumn', 'M3EDropdownMenu'],
      sections: [
        _LibraryGuideSection(
          title: 'Patrón recomendado',
          bullets: [
            'M3ECardColumn para listas estáticas con estructura visual fuerte.',
            'M3EExpandableCardColumn para documentación progresiva o FAQ técnico.',
            'M3EDropdownMenu con búsqueda para catálogos medianos o largos.',
          ],
        ),
      ],
      samples: [
        _LibrarySample(
          id: 'm3e_core.expand',
          title: 'Lista expandible de features',
          description: 'Despliegue progresivo de contenido técnico por secciones.',
          fileName: 'lib/ui/features_expand.dart',
          code: "m3ec.M3EExpandableCardColumn(\n  itemCount: 3,\n  headerBuilder: (c, i, expanded) => Text('Feature \${i + 1}'),\n  bodyBuilder: (c, i) => Text('Detalle funcional de la feature \${i + 1}'),\n);",
        ),
      ],
    ),
    _LibraryDoc(
      name: 'app_bar_m3e + expressive_refresh',
      description: 'Combinación para cabeceras dinámicas y refresh expresivo basado en gesto o trigger manual.',
      icon: Icons.refresh,
      tint: const Color(0xFF8A2846),
      highlights: ['AppBarM3E', 'ExpressiveRefreshIndicator.contained'],
      sections: [
        _LibraryGuideSection(
          title: 'Flujo productivo',
          bullets: [
            'Define una función onRefresh idempotente para evitar dobles ejecuciones.',
            'Combina pull-to-refresh con botón forzar refresh para demos y QA.',
            'Expón contador y timestamp de refresh para feedback visible.',
          ],
        ),
      ],
      samples: [
        _LibrarySample(
          id: 'refresh.integration',
          title: 'Integración de refresh controlado',
          description: 'Ejemplo completo con indicador expresivo y acciones manuales.',
          fileName: 'lib/ui/refresh_lab.dart',
          code: "ExpressiveRefreshIndicator.contained(\n  onRefresh: _onRefresh,\n  child: ListView.builder(\n    itemCount: items.length,\n    itemBuilder: (context, index) => ListTile(title: Text('Item \$index')),\n  ),\n);\n\nButtonM3E(\n  label: Text('Forzar refresh'),\n  onPressed: _onRefresh,\n);",
        ),
      ],
    ),
    _LibraryDoc(
      name: 'progress_indicator_m3e + expressive_loading_indicator',
      description: 'Sistema de carga y progreso expresivo para estados de espera, progreso parcial y completitud.',
      icon: Icons.hourglass_top,
      tint: const Color(0xFF004A77),
      highlights: ['LinearProgressIndicatorM3E', 'ProgressWithLabelM3E', 'ExpressiveLoadingIndicator'],
      sections: [
        _LibraryGuideSection(
          title: 'Buenas prácticas',
          bullets: [
            'Usa ProgressWithLabelM3E para tareas con avance cuantificable.',
            'Usa loading expresivo sólo para espera indeterminada real.',
            'Evita mezclar múltiples indicadores sin jerarquía visual.',
          ],
        ),
      ],
      samples: [
        _LibrarySample(
          id: 'progress.loading',
          title: 'Panel de progreso mixto',
          description: 'Combinación de indicadores lineales, circulares y carga morfológica.',
          fileName: 'lib/ui/progress_panel.dart',
          code: "Column(\n  children: [\n    LinearProgressIndicatorM3E(value: 0.62),\n    ProgressWithLabelM3E(value: 0.62),\n    SizedBox(width: 48, height: 48, child: eli.ExpressiveLoadingIndicator()),\n  ],\n);",
        ),
      ],
    ),
    _LibraryDoc(
      name: 'flutter_m3shapes_extended',
      description: 'Librería de formas expresivas para construir identidad visual no genérica en M3E.',
      icon: Icons.category,
      tint: const Color(0xFF944500),
      highlights: ['M3EContainer.gem', 'M3EContainer.flower', 'M3EContainer.softBurst'],
      sections: [
        _LibraryGuideSection(
          title: 'Estrategia visual',
          bullets: [
            'Define 1 o 2 formas protagonistas por pantalla para evitar ruido visual.',
            'Asocia forma a semántica: burst para alertas, gem para acciones premium.',
            'Usa contraste alto entre shape y foreground para accesibilidad.',
          ],
        ),
      ],
      samples: [
        _LibrarySample(
          id: 'shapes.palette',
          title: 'Galería de formas',
          description: 'Mosaico con formas expresivas y colores de la paleta activa.',
          fileName: 'lib/ui/shapes_gallery.dart',
          code: "Wrap(\n  spacing: 12,\n  children: [\n    m3shapes.M3EContainer.gem(width: 90, height: 90, color: cs.primaryContainer),\n    m3shapes.M3EContainer.flower(width: 90, height: 90, color: cs.secondaryContainer),\n    m3shapes.M3EContainer.softBurst(width: 90, height: 90, color: cs.tertiaryContainer),\n  ],\n);",
        ),
      ],
    ),
    _LibraryDoc(
      name: 'flutter_animate + dynamic_color',
      description: 'Motion declarativo + color dinámico para interfaces que se adaptan al usuario y al contexto.',
      icon: Icons.palette,
      tint: const Color(0xFF3B5E0B),
      highlights: ['fadeIn/slide/scale', 'Animate.defaultDuration', 'DynamicColorBuilder'],
      sections: [
        _LibraryGuideSection(
          title: 'Integración de motion y color',
          bullets: [
            'Centraliza duración por defecto con Animate.defaultDuration.',
            'Anima entradas críticas; evita animar todo al mismo tiempo.',
            'Usa DynamicColorBuilder con fallback ColorScheme.fromSeed.',
          ],
        ),
      ],
      samples: [
        _LibrarySample(
          id: 'animate.dynamic',
          title: 'Entrada animada con color dinámico',
          description: 'Componente animado utilizando el colorScheme activo del sistema.',
          fileName: 'lib/ui/motion_dynamic.dart',
          code: "Animate.defaultDuration = const Duration(milliseconds: 400);\n\nContainer(\n  padding: const EdgeInsets.all(12),\n  color: Theme.of(context).colorScheme.primaryContainer,\n  child: Text('Hola M3E'),\n).animate().fadeIn().slideY(begin: 0.2);",
        ),
      ],
    ),
  ];

  void _openDoc(BuildContext context, _LibraryDoc doc) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => _LibraryDocScreen(doc: doc)),
    );
  }

  Widget _packageCard(
    BuildContext context, {
    required _LibraryDoc doc,
  }) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      color: doc.tint.withValues(alpha: 0.18),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () => _openDoc(context, doc),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  m3shapes.M3EContainer.pill(
                    width: 44,
                    height: 44,
                    color: doc.tint,
                    child: Icon(doc.icon, color: cs.onPrimary),
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: Text(doc.name, style: Theme.of(context).textTheme.titleLarge)),
                  const Icon(Icons.chevron_right),
                ],
              ),
              const SizedBox(height: 6),
              Text(doc.description, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: doc.highlights.map((item) => Chip(label: Text(item))).toList(),
              ),
              const SizedBox(height: 10),
              ButtonM3E(
                label: const Text('Ver documentación avanzada'),
                style: ButtonM3EStyle.tonal,
                onPressed: () => _openDoc(context, doc),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarM3E(titleText: 'Librerias y Funcionalidades'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _HeroBlast(
            title: 'Librerias en uso',
            subtitle: 'Referencia rapida de paquetes y funcionalidades de esta demo.',
            icon: Icons.menu_book,
          ),
          const SizedBox(height: 16),
          Text('Stack de la mega galeria', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 8),
          Text('Documentación técnica navegable por librería con integración real, snippets y preview visual.'),
          const SizedBox(height: 16),
          ..._docs.map((doc) => _packageCard(context, doc: doc)),
          const SizedBox(height: 16),
          const SizedBox(height: 16),
          Card(
            color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.45),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Lineamientos de interfaz M3 Expressive', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text('1. Jerarquía visual fuerte con tipografía clara y bloques protagonistas.'),
                  Text('2. Movimiento significativo: transición de entrada, feedback y estado.'),
                  Text('3. Personalización visible: tema, tipografía y paleta accesibles.'),
                  Text('4. Color como sistema: usa seed + superficies para cohesión.'),
                  Text('5. Componentes expresivos sin sacrificar legibilidad y accesibilidad.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LibraryDocScreen extends StatelessWidget {
  const _LibraryDocScreen({required this.doc});

  final _LibraryDoc doc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarM3E(titleText: doc.name),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _HeroBlast(
            title: doc.name,
            subtitle: doc.description,
            icon: doc.icon,
          ),
          const SizedBox(height: 16),
          ...doc.sections.map(
            (section) => Card(
              color: doc.tint.withValues(alpha: 0.12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(section.title, style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 8),
                    ...section.bullets.map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Text('• $item'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text('Ejemplos de integración', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 10),
          ...doc.samples.map(
            (sample) => _CodeEditorPanel(
              sample: sample,
              preview: _LibrarySamplePreview(sampleId: sample.id),
            ),
          ),
        ],
      ),
    );
  }
}

class _CodeEditorPanel extends StatelessWidget {
  const _CodeEditorPanel({
    required this.sample,
    required this.preview,
  });

  final _LibrarySample sample;
  final Widget preview;

  @override
  Widget build(BuildContext context) {
    final lines = sample.code.split('\n');
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(sample.title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 6),
            Text(sample.description),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF10151E),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF232B38)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: const BoxDecoration(
                      color: Color(0xFF171F2C),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    child: Row(
                      children: [
                        Container(width: 10, height: 10, decoration: const BoxDecoration(color: Color(0xFFFF5F56), shape: BoxShape.circle)),
                        const SizedBox(width: 6),
                        Container(width: 10, height: 10, decoration: const BoxDecoration(color: Color(0xFFFFBD2E), shape: BoxShape.circle)),
                        const SizedBox(width: 6),
                        Container(width: 10, height: 10, decoration: const BoxDecoration(color: Color(0xFF27C93F), shape: BoxShape.circle)),
                        const SizedBox(width: 12),
                        Text(
                          sample.fileName,
                          style: GoogleFonts.jetBrainsMono(
                            fontSize: 12,
                            color: const Color(0xFF9EA7B8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 28,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: List.generate(
                              lines.length,
                              (index) => Padding(
                                padding: const EdgeInsets.only(bottom: 2),
                                child: Text(
                                  '${index + 1}',
                                  style: GoogleFonts.jetBrainsMono(
                                    fontSize: 12,
                                    color: const Color(0xFF6B778C),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: SelectableText(
                            sample.code,
                            style: GoogleFonts.jetBrainsMono(
                              fontSize: 12,
                              height: 1.4,
                              color: const Color(0xFFE4E8EF),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text('Preview renderizado', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Theme.of(context).colorScheme.surfaceContainer,
              ),
              child: preview,
            ),
          ],
        ),
      ),
    );
  }
}

class _LibrarySamplePreview extends StatelessWidget {
  const _LibrarySamplePreview({required this.sampleId});

  final String sampleId;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    switch (sampleId) {
      case 'm3e_collection.button_pack':
        return Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            ButtonM3E(label: const Text('Guardar cambios'), style: ButtonM3EStyle.filled, onPressed: () {}),
            FabM3E(icon: const Icon(Icons.add), kind: FabM3EKind.primary, onPressed: () {}),
          ],
        );
      case 'm3e_collection.nav_pack':
        return NavigationBarM3E(
          selectedIndex: 1,
          onDestinationSelected: (_) {},
          destinations: const [
            NavigationDestinationM3E(icon: Icon(Icons.home_outlined), label: 'Inicio'),
            NavigationDestinationM3E(icon: Icon(Icons.search_outlined), label: 'Buscar'),
            NavigationDestinationM3E(icon: Icon(Icons.person_outline), label: 'Perfil'),
          ],
        );
      case 'm3e_buttons.split':
        return m3eb.M3ESplitButton<String>(
          label: 'Publicar',
          onPressed: () {},
          onSelected: (_) {},
          items: const [
            m3eb.M3ESplitButtonItem(value: 'draft', child: Text('Guardar borrador')),
            m3eb.M3ESplitButtonItem(value: 'schedule', child: Text('Programar')),
          ],
        );
      case 'm3e_core.expand':
        return m3ec.M3EExpandableCardColumn(
          itemCount: 2,
          headerBuilder: (context, index, expanded) => Text('Feature ${index + 1}'),
          bodyBuilder: (context, index) => Text('Detalle técnico de la feature ${index + 1}'),
        );
      case 'refresh.integration':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ButtonM3E(label: const Text('Forzar refresh'), style: ButtonM3EStyle.tonal, onPressed: () {}),
            const SizedBox(height: 8),
            const Text('Combina pull-to-refresh + trigger manual para QA y demos.'),
          ],
        );
      case 'progress.loading':
        return Row(
          children: const [
            Expanded(child: LinearProgressIndicatorM3E(value: 0.62)),
            SizedBox(width: 10),
            SizedBox(width: 44, height: 44, child: ProgressWithLabelM3E(value: 0.62)),
            SizedBox(width: 10),
            SizedBox(width: 34, height: 34, child: eli.ExpressiveLoadingIndicator()),
          ],
        );
      case 'shapes.palette':
        return Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            m3shapes.M3EContainer.gem(width: 72, height: 72, color: cs.primaryContainer, child: Icon(Icons.diamond, color: cs.onPrimaryContainer)),
            m3shapes.M3EContainer.flower(width: 72, height: 72, color: cs.secondaryContainer, child: Icon(Icons.local_florist, color: cs.onSecondaryContainer)),
            m3shapes.M3EContainer.softBurst(width: 72, height: 72, color: cs.tertiaryContainer, child: Icon(Icons.brightness_high, color: cs.onTertiaryContainer)),
          ],
        );
      case 'animate.dynamic':
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cs.primaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text('Hola M3E', style: TextStyle(color: cs.onPrimaryContainer))
              .animate()
              .fadeIn(duration: 450.ms)
              .slideY(begin: 0.2, end: 0),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

class _LibraryDoc {
  const _LibraryDoc({
    required this.name,
    required this.description,
    required this.icon,
    required this.tint,
    required this.highlights,
    required this.sections,
    required this.samples,
  });

  final String name;
  final String description;
  final IconData icon;
  final Color tint;
  final List<String> highlights;
  final List<_LibraryGuideSection> sections;
  final List<_LibrarySample> samples;
}

class _LibraryGuideSection {
  const _LibraryGuideSection({required this.title, required this.bullets});

  final String title;
  final List<String> bullets;
}

class _LibrarySample {
  const _LibrarySample({
    required this.id,
    required this.title,
    required this.description,
    required this.fileName,
    required this.code,
  });

  final String id;
  final String title;
  final String description;
  final String fileName;
  final String code;
}

class _ColorPulseDot extends StatelessWidget {
  const _ColorPulseDot({
    required this.color,
    required this.label,
  });

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: color.withValues(alpha: 0.55), blurRadius: 16, spreadRadius: 1),
            ],
          ),
        ).animate(onPlay: (controller) => controller.repeat(reverse: true)).scale(begin: const Offset(0.92, 0.92), end: const Offset(1.08, 1.08), duration: 1200.ms),
        const SizedBox(height: 4),
        Text(label, style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }
}

enum _ModuleKind { routines, focus, finance, health, agenda, automation }

class _UtilityModule {
  const _UtilityModule(this.kind, this.title, this.subtitle, this.icon);

  final _ModuleKind kind;
  final String title;
  final String subtitle;
  final IconData icon;
}
