import 'package:flutter/widgets.dart';

/// Localization support for EN, ES, DE, ZH.
/// No code generation — just a map-based lookup with English fallback.
class AppLocalizations {
  AppLocalizations(this.locale);
  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const AppLocalizationsDelegate delegate = AppLocalizationsDelegate();

  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('es'),
    Locale('de'),
    Locale('zh'),
  ];

  static const Map<String, Map<String, String>> _strings = {
    'en': {
      // Nav labels
      'nav_showcase': 'Showcase',
      'nav_showcase_short': 'Home',
      'nav_buttons': 'Buttons',
      'nav_buttons_short': 'Buttons',
      'nav_navigation': 'Navigation',
      'nav_navigation_short': 'Nav',
      'nav_motion': 'Motion',
      'nav_motion_short': 'Motion',
      'nav_refresh': 'Refresh',
      'nav_refresh_short': 'Refresh',
      'nav_core': 'Core',
      'nav_core_short': 'Core',
      'nav_shapes': 'Shapes',
      'nav_shapes_short': 'Shapes',
      'nav_libraries': 'Libraries',
      'nav_libraries_short': 'Libs',
      // Studio M3E
      'studio_title': 'Studio M3E',
      'studio_color_mode': 'Color mode',
      'studio_light': 'Light',
      'studio_dark': 'Dark',
      'studio_system': 'System',
      'studio_typography': 'Active typography',
      'studio_palette': 'Color palette',
      'studio_surprise': 'Surprise color',
      'studio_language': 'Language',
      // Shapes screen
      'shapes_title': 'Shapes Lab',
      'shapes_subtitle': 'M3E geometries for bolder compositions.',
      'shapes_basic': 'Basic Shapes',
      'shapes_basic_desc': 'Clipped containers with expressive Material 3 geometries.',
      'shapes_animated': 'Animated Shapes',
      'shapes_animated_desc': 'Shapes with continuous motion and pulse effects.',
      'shapes_advanced': 'Advanced Compositions',
      'shapes_advanced_desc': 'Combined shapes with color and layering effects.',
      'shapes_interactive': 'Interactive Playground',
      'shapes_interactive_desc': 'Tap and hold shapes to see interaction effects.',
      'shapes_usage': 'Usage Examples',
      'shapes_usage_desc': 'Real-world patterns using M3E shapes in UI.',
      // Showcase
      'showcase_personalization': 'Live Personalization',
      'showcase_energy': 'Energy intensity',
      'showcase_organic': 'Form organicity',
      'showcase_color_burst': 'Color Burst',
      'showcase_color_burst_desc': 'Quick view of active theme tones with pulse animation.',
      'showcase_credits': 'Credits & Source Code',
      'showcase_github_title': 'Open Source Project',
      'showcase_github_desc': 'Download the complete source code, create your own version or contribute to the project.',
      'showcase_github_btn': 'View on GitHub',
      // Video player
      'tap_to_load': 'Tap to load · Vimeo',
      'play_vimeo': '▶  Play Vimeo',
      'pause_vimeo': '⏸  Pause Vimeo',
      'sound': '🔊  Sound',
      'mute': '🔇  Mute',
      'restart': '↺  Restart',
      'fullscreen_hint': 'If embedded fails, use fullscreen to open Vimeo',
    },
    'es': {
      // Nav labels
      'nav_showcase': 'Showcase',
      'nav_showcase_short': 'Inicio',
      'nav_buttons': 'Botones',
      'nav_buttons_short': 'Botones',
      'nav_navigation': 'Navegación',
      'nav_navigation_short': 'Nav',
      'nav_motion': 'Motion',
      'nav_motion_short': 'Motion',
      'nav_refresh': 'Refresh',
      'nav_refresh_short': 'Refresh',
      'nav_core': 'Core',
      'nav_core_short': 'Core',
      'nav_shapes': 'Formas',
      'nav_shapes_short': 'Formas',
      'nav_libraries': 'Librerias',
      'nav_libraries_short': 'Libs',
      // Studio M3E
      'studio_title': 'Studio M3E',
      'studio_color_mode': 'Modo de color',
      'studio_light': 'Claro',
      'studio_dark': 'Oscuro',
      'studio_system': 'Sistema',
      'studio_typography': 'Tipografia activa',
      'studio_palette': 'Paleta colorida',
      'studio_surprise': 'Color sorpresa',
      'studio_language': 'Idioma',
      // Shapes screen
      'shapes_title': 'Shapes Lab',
      'shapes_subtitle': 'Geometrias M3E para composiciones mas audaces.',
      'shapes_basic': 'Formas Basicas',
      'shapes_basic_desc': 'Contenedores clippeados con geometrias Material 3 expresivas.',
      'shapes_animated': 'Formas Animadas',
      'shapes_animated_desc': 'Formas con movimiento continuo y efectos de pulso.',
      'shapes_advanced': 'Composiciones Avanzadas',
      'shapes_advanced_desc': 'Formas combinadas con efectos de color y capas.',
      'shapes_interactive': 'Playground Interactivo',
      'shapes_interactive_desc': 'Toca y manten las formas para ver efectos de interaccion.',
      'shapes_usage': 'Ejemplos de Uso',
      'shapes_usage_desc': 'Patrones del mundo real usando formas M3E en UI.',
      // Showcase
      'showcase_personalization': 'Personalizacion Viva',
      'showcase_energy': 'Intensidad de energia',
      'showcase_organic': 'Organicidad de forma',
      'showcase_color_burst': 'Color Burst',
      'showcase_color_burst_desc': 'Vista rapida de tonos activos del tema con animacion de pulso.',
      'showcase_credits': 'Creditos y Codigo Fuente',
      'showcase_github_title': 'Proyecto Open Source',
      'showcase_github_desc': 'Descarga el codigo fuente completo, crea tu propia version o contribuye al proyecto.',
      'showcase_github_btn': 'Ver en GitHub',
      // Video player
      'tap_to_load': 'Toca para cargar · Vimeo',
      'play_vimeo': '▶  Reproducir Vimeo',
      'pause_vimeo': '⏸  Pausar Vimeo',
      'sound': '🔊  Sonido',
      'mute': '🔇  Silenciar',
      'restart': '↺  Reiniciar',
      'fullscreen_hint': 'Si falla embebido, usa fullscreen para abrir Vimeo',
    },
    'de': {
      // Nav labels
      'nav_showcase': 'Showcase',
      'nav_showcase_short': 'Start',
      'nav_buttons': 'Schaltflächen',
      'nav_buttons_short': 'Btns',
      'nav_navigation': 'Navigation',
      'nav_navigation_short': 'Nav',
      'nav_motion': 'Bewegung',
      'nav_motion_short': 'Motion',
      'nav_refresh': 'Aktualisieren',
      'nav_refresh_short': 'Refresh',
      'nav_core': 'Kern',
      'nav_core_short': 'Core',
      'nav_shapes': 'Formen',
      'nav_shapes_short': 'Formen',
      'nav_libraries': 'Bibliotheken',
      'nav_libraries_short': 'Libs',
      // Studio M3E
      'studio_title': 'Studio M3E',
      'studio_color_mode': 'Farbmodus',
      'studio_light': 'Hell',
      'studio_dark': 'Dunkel',
      'studio_system': 'System',
      'studio_typography': 'Aktive Typografie',
      'studio_palette': 'Farbpalette',
      'studio_surprise': 'Überraschungsfarbe',
      'studio_language': 'Sprache',
      // Shapes screen
      'shapes_title': 'Shapes Lab',
      'shapes_subtitle': 'M3E-Geometrien für ausdrucksstärkere Kompositionen.',
      'shapes_basic': 'Grundformen',
      'shapes_basic_desc': 'Geklippte Container mit expressiven Material 3-Geometrien.',
      'shapes_animated': 'Animierte Formen',
      'shapes_animated_desc': 'Formen mit kontinuierlicher Bewegung und Pulseffekten.',
      'shapes_advanced': 'Erweiterte Kompositionen',
      'shapes_advanced_desc': 'Kombinierte Formen mit Farb- und Schichteffekten.',
      'shapes_interactive': 'Interaktiver Spielplatz',
      'shapes_interactive_desc': 'Tippen und halten Sie Formen, um Interaktionseffekte zu sehen.',
      'shapes_usage': 'Anwendungsbeispiele',
      'shapes_usage_desc': 'Reale Muster mit M3E-Formen in der UI.',
      // Showcase
      'showcase_personalization': 'Live-Personalisierung',
      'showcase_energy': 'Energieintensität',
      'showcase_organic': 'Organische Form',
      'showcase_color_burst': 'Farbexplosion',
      'showcase_color_burst_desc': 'Schnellansicht aktiver Themenfarbtöne mit Pulsanimation.',
      'showcase_credits': 'Danksagungen & Quellcode',
      'showcase_github_title': 'Open-Source-Projekt',
      'showcase_github_desc': 'Laden Sie den vollständigen Quellcode herunter, erstellen Sie Ihre eigene Version oder tragen Sie zum Projekt bei.',
      'showcase_github_btn': 'Auf GitHub ansehen',
      // Video player
      'tap_to_load': 'Tippen zum Laden · Vimeo',
      'play_vimeo': '▶  Vimeo abspielen',
      'pause_vimeo': '⏸  Vimeo pausieren',
      'sound': '🔊  Ton',
      'mute': '🔇  Stummschalten',
      'restart': '↺  Neustart',
      'fullscreen_hint': 'Bei Einbettungsfehler Vollbild verwenden, um Vimeo zu öffnen',
    },
    'zh': {
      // Nav labels
      'nav_showcase': '展示',
      'nav_showcase_short': '主页',
      'nav_buttons': '按钮',
      'nav_buttons_short': '按钮',
      'nav_navigation': '导航',
      'nav_navigation_short': '导航',
      'nav_motion': '动效',
      'nav_motion_short': '动效',
      'nav_refresh': '刷新',
      'nav_refresh_short': '刷新',
      'nav_core': '核心',
      'nav_core_short': '核心',
      'nav_shapes': '形状',
      'nav_shapes_short': '形状',
      'nav_libraries': '组件库',
      'nav_libraries_short': '库',
      // Studio M3E
      'studio_title': 'Studio M3E',
      'studio_color_mode': '颜色模式',
      'studio_light': '浅色',
      'studio_dark': '深色',
      'studio_system': '系统',
      'studio_typography': '当前字体',
      'studio_palette': '颜色方案',
      'studio_surprise': '随机颜色',
      'studio_language': '语言',
      // Shapes screen
      'shapes_title': '形状实验室',
      'shapes_subtitle': '用于更大胆构图的 M3E 几何图形。',
      'shapes_basic': '基本形状',
      'shapes_basic_desc': '使用 Material 3 几何图形裁剪的容器。',
      'shapes_animated': '动画形状',
      'shapes_animated_desc': '具有连续运动和脉冲效果的形状。',
      'shapes_advanced': '高级组合',
      'shapes_advanced_desc': '具有颜色和分层效果的组合形状。',
      'shapes_interactive': '交互式游乐场',
      'shapes_interactive_desc': '点击并按住形状以查看交互效果。',
      'shapes_usage': '使用示例',
      'shapes_usage_desc': '在 UI 中使用 M3E 形状的真实模式。',
      // Showcase
      'showcase_personalization': '实时个性化',
      'showcase_energy': '能量强度',
      'showcase_organic': '形态有机感',
      'showcase_color_burst': '颜色爆发',
      'showcase_color_burst_desc': '带有脉冲动画的活跃主题色调快速查看。',
      'showcase_credits': '致谢与源代码',
      'showcase_github_title': '开源项目',
      'showcase_github_desc': '下载完整源代码，创建您自己的版本或为项目做贡献。',
      'showcase_github_btn': '在 GitHub 上查看',
      // Video player
      'tap_to_load': '点击加载 · Vimeo',
      'play_vimeo': '▶  播放 Vimeo',
      'pause_vimeo': '⏸  暂停 Vimeo',
      'sound': '🔊  声音',
      'mute': '🔇  静音',
      'restart': '↺  重新开始',
      'fullscreen_hint': '如果嵌入失败，请使用全屏打开 Vimeo',
    },
  };

  String _t(String key) {
    final lang = locale.languageCode;
    return _strings[lang]?[key] ?? _strings['en']![key] ?? key;
  }

  // Nav
  String get navShowcase => _t('nav_showcase');
  String get navShowcaseShort => _t('nav_showcase_short');
  String get navButtons => _t('nav_buttons');
  String get navButtonsShort => _t('nav_buttons_short');
  String get navNavigation => _t('nav_navigation');
  String get navNavigationShort => _t('nav_navigation_short');
  String get navMotion => _t('nav_motion');
  String get navMotionShort => _t('nav_motion_short');
  String get navRefresh => _t('nav_refresh');
  String get navRefreshShort => _t('nav_refresh_short');
  String get navCore => _t('nav_core');
  String get navCoreShort => _t('nav_core_short');
  String get navShapes => _t('nav_shapes');
  String get navShapesShort => _t('nav_shapes_short');
  String get navLibraries => _t('nav_libraries');
  String get navLibrariesShort => _t('nav_libraries_short');
  // Studio
  String get studioTitle => _t('studio_title');
  String get studioColorMode => _t('studio_color_mode');
  String get studioLight => _t('studio_light');
  String get studioDark => _t('studio_dark');
  String get studioSystem => _t('studio_system');
  String get studioTypography => _t('studio_typography');
  String get studioPalette => _t('studio_palette');
  String get studioSurprise => _t('studio_surprise');
  String get studioLanguage => _t('studio_language');
  // Shapes
  String get shapesTitle => _t('shapes_title');
  String get shapesSubtitle => _t('shapes_subtitle');
  String get shapesBasic => _t('shapes_basic');
  String get shapesBasicDesc => _t('shapes_basic_desc');
  String get shapesAnimated => _t('shapes_animated');
  String get shapesAnimatedDesc => _t('shapes_animated_desc');
  String get shapesAdvanced => _t('shapes_advanced');
  String get shapesAdvancedDesc => _t('shapes_advanced_desc');
  String get shapesInteractive => _t('shapes_interactive');
  String get shapesInteractiveDesc => _t('shapes_interactive_desc');
  String get shapesUsage => _t('shapes_usage');
  String get shapesUsageDesc => _t('shapes_usage_desc');
  // Showcase
  String get showcasePersonalization => _t('showcase_personalization');
  String get showcaseEnergy => _t('showcase_energy');
  String get showcaseOrganic => _t('showcase_organic');
  String get showcaseColorBurst => _t('showcase_color_burst');
  String get showcaseColorBurstDesc => _t('showcase_color_burst_desc');
  String get showcaseCredits => _t('showcase_credits');
  String get showcaseGithubTitle => _t('showcase_github_title');
  String get showcaseGithubDesc => _t('showcase_github_desc');
  String get showcaseGithubBtn => _t('showcase_github_btn');
  // Video
  String get tapToLoad => _t('tap_to_load');
  String get playVimeo => _t('play_vimeo');
  String get pauseVimeo => _t('pause_vimeo');
  String get sound => _t('sound');
  String get mute => _t('mute');
  String get restart => _t('restart');
  String get fullscreenHint => _t('fullscreen_hint');
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'es', 'de', 'zh'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async => AppLocalizations(locale);

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
