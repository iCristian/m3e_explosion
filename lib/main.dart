import 'dart:async';
import 'dart:math' as math;

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
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';

// ARQUITECTURA: Models, Services, ViewModels, Widgets
import 'models/app_models.dart';
import 'service_locator.dart';
import 'viewmodels/video_player_viewmodel.dart';

part 'screens/buttons_screen.part.dart';
part 'screens/core_widgets_screen.part.dart';
// Vista desacoplada por secciones en lib/screens/*.part.dart
// para mantener este main enfocado en bootstrap, tema global e inyección de dependencias.
part 'screens/home_shell.part.dart';
part 'screens/libraries_screen.part.dart';
part 'screens/navigation_screen.part.dart';
part 'screens/progress_motion_screen.part.dart';
part 'screens/refresh_appbar_screen.part.dart';
part 'screens/shapes_screen.part.dart';
part 'screens/shared_ui.part.dart';
part 'screens/showcase_screen.part.dart';
part 'screens/utility_modules_screen.part.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Animate.defaultDuration = const Duration(milliseconds: 400);
  
  // Inicializar el service locator (inyección de dependencias)
  await setupServiceLocator();
  
  runApp(const M3EDemoApp());
}

Widget _appBarBrandIcon() {
  return Padding(
    padding: const EdgeInsets.only(right: 8),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset('lib/assets/icono.png', width: 24, height: 24, fit: BoxFit.cover),
    ),
  );
}

PreferredSizeWidget _buildAnimatedHeader(
  BuildContext context, {
  required String titleText,
  List<Widget>? actions,
}) {
  return _AnimatedPaletteHeader(titleText: titleText, actions: actions ?? const []);
}

class _AnimatedPaletteHeader extends StatelessWidget implements PreferredSizeWidget {
  const _AnimatedPaletteHeader({
    required this.titleText,
    required this.actions,
  });

  final String titleText;
  final List<Widget> actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 4);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return AppBar(
      toolbarHeight: preferredSize.height,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      foregroundColor: cs.onPrimary,
      iconTheme: IconThemeData(color: cs.onPrimary),
      actionsIconTheme: IconThemeData(color: cs.onPrimary),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(22),
          bottomRight: Radius.circular(22),
        ),
      ),
      title: Text(
        titleText,
        style: theme.textTheme.titleLarge?.copyWith(
          color: cs.onPrimary,
          fontWeight: FontWeight.w800,
        ),
      ),
      actions: actions,
      flexibleSpace: _AnimatedPaletteGradientBand(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(22),
          bottomRight: Radius.circular(22),
        ),
        showShadow: true,
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _AnimatedPaletteGradientBand extends StatefulWidget {
  const _AnimatedPaletteGradientBand({
    required this.child,
    this.borderRadius = BorderRadius.zero,
    this.showShadow = false,
  });

  final Widget child;
  final BorderRadius borderRadius;
  final bool showShadow;

  @override
  State<_AnimatedPaletteGradientBand> createState() => _AnimatedPaletteGradientBandState();
}

class _AnimatedPaletteGradientBandState extends State<_AnimatedPaletteGradientBand>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 8400),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final c1 = Color.lerp(cs.primary, cs.tertiary, 0.34)!;
    final c2 = Color.lerp(cs.secondary, cs.primary, 0.46)!;
    final c3 = Color.lerp(cs.tertiary, cs.secondary, 0.52)!;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final t = _controller.value;
        final phaseA = t * math.pi * 2;
        final phaseB = (1 - t) * math.pi * 2;

        return DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(math.sin(phaseA), -1 + (0.42 * math.cos(phaseB))),
              end: Alignment(-math.sin(phaseB), 1 - (0.35 * math.cos(phaseA))),
              colors: [
                c1.withValues(alpha: 0.96),
                c2.withValues(alpha: 0.94),
                c3.withValues(alpha: 0.96),
              ],
            ),
            borderRadius: widget.borderRadius,
            boxShadow: widget.showShadow
                ? [
                    BoxShadow(
                      color: c1.withValues(alpha: 0.28),
                      blurRadius: 22,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : null,
          ),
          child: ClipRRect(
            borderRadius: widget.borderRadius,
            child: widget.child,
          ),
        );
      },
    );
  }
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
  Locale _locale = const Locale('en');

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

      // Cargar idioma: guardado o auto-detectado del sistema
      final savedLocale = prefs.getLocale();
      if (savedLocale != null) {
        _locale = Locale(savedLocale);
      } else {
        final systemLang =
            WidgetsBinding.instance.platformDispatcher.locale.languageCode;
        const supported = ['en', 'es', 'de', 'zh'];
        _locale = Locale(supported.contains(systemLang) ? systemLang : 'en');
      }
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

  /// Guarda el idioma seleccionado en preferencias.
  Future<void> _setLocale(String languageCode) async {
    setState(() => _locale = Locale(languageCode));
    await preferencesService.setLocale(languageCode);
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
      builder: (_, __) {
        final seed = _colorPack.seed;
        final light = ColorScheme.fromSeed(seedColor: seed);
        final dark = ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.dark);

        return MaterialApp(
          title: 'M3 Expressive Mega Gallery',
          debugShowCheckedModeBanner: false,
          themeMode: _themeMode,
          theme: _buildTheme(light, _fontPack),
          darkTheme: _buildTheme(dark, _fontPack),
          locale: _locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: widget.enableIntro
              ? IntroGate(
                  child: HomeScreen(
                    themeMode: _themeMode,
                    onThemeModeChanged: (mode) => _setThemeMode(mode),
                    fontPack: _fontPack,
                    onFontPackChanged: (pack) => _setFontPack(pack),
                    colorPack: _colorPack,
                    onColorPackChanged: (pack) => _setColorPack(pack),
                    locale: _locale,
                    onLocaleChanged: (lc) => _setLocale(lc),
                  ),
                )
              : HomeScreen(
                  themeMode: _themeMode,
                  onThemeModeChanged: (mode) => _setThemeMode(mode),
                  fontPack: _fontPack,
                  onFontPackChanged: (pack) => _setFontPack(pack),
                  colorPack: _colorPack,
                  onColorPackChanged: (pack) => _setColorPack(pack),
                  locale: _locale,
                  onLocaleChanged: (lc) => _setLocale(lc),
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

