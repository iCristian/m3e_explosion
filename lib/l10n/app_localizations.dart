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
      // Utility modules
      'module_routines': 'Routines',
      'module_routines_desc': 'Habits, streaks and daily goals',
      'module_focus': 'Focus',
      'module_focus_desc': 'Distractions block and deep work sessions',
      'module_finance': 'Finance',
      'module_finance_desc': 'Spending tracking and budget alerts',
      'module_health': 'Health',
      'module_health_desc': 'Hydration, sleep and movement',
      'module_agenda': 'Agenda',
      'module_agenda_desc': 'Events, reminders and priorities',
      'module_automation': 'Automation',
      'module_automation_desc': 'Smart rules based on context',
      // Tasks in showcase
      'task_energy_metrics': 'Review energy metrics',
      'task_sprint_report': 'Send sprint report',
      'task_focus_session': 'Focus session 45 min',
      'task_budget_update': 'Update budget',
      // Refresh screen
      'refresh_lab_title': 'Refresh Lab',
      'refresh_no_items': 'No items yet',
      'refresh_instruction': 'Pull-to-refresh or use buttons to force reload and see the behavior live.',
      'refresh_force_btn': 'Force refresh',
      'refresh_refreshing': 'Refreshing...',
      'refresh_insert_instruction': 'Pull-to-refresh to insert more items',
      // Finance module
      'finance_monthly_budget': 'Monthly budget',
      'finance_budget_alert': 'Budget alert',
      'finance_alert_notify': 'Notify when exceeding 80% of monthly limit',
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
      // Utility modules
      'module_routines': 'Rutinas',
      'module_routines_desc': 'Hábitos, streaks y objetivos diarios',
      'module_focus': 'Focus',
      'module_focus_desc': 'Bloqueo de distracciones y bloques deep work',
      'module_finance': 'Finanzas',
      'module_finance_desc': 'Seguimiento de gasto y alertas de presupuesto',
      'module_health': 'Salud',
      'module_health_desc': 'Hidratación, sueño y movimiento',
      'module_agenda': 'Agenda',
      'module_agenda_desc': 'Eventos, recordatorios y prioridades',
      'module_automation': 'Automatización',
      'module_automation_desc': 'Reglas inteligentes según contexto',
      // Tasks in showcase
      'task_energy_metrics': 'Revisar métricas de energía',
      'task_sprint_report': 'Enviar reporte del sprint',
      'task_focus_session': 'Sesión de focus 45 min',
      'task_budget_update': 'Actualizar presupuesto',
      // Refresh screen
      'refresh_lab_title': 'Laboratorio de Refresh',
      'refresh_no_items': 'Sin refrescos aún',
      'refresh_instruction': 'Haz pull-to-refresh o usa los botones para forzar recarga y ver el comportamiento en vivo.',
      'refresh_force_btn': 'Forzar refresh',
      'refresh_refreshing': 'Refrescando...',
      'refresh_insert_instruction': 'Haz pull-to-refresh para insertar más elementos',
      // Finance module
      'finance_monthly_budget': 'Presupuesto mensual',
      'finance_budget_alert': 'Alerta de presupuesto',
      'finance_alert_notify': 'Notifica al superar 80% del límite mensual',
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
      // Utility modules
      'module_routines': 'Routinen',
      'module_routines_desc': 'Gewohnheiten, Streaks und tägliche Ziele',
      'module_focus': 'Fokus',
      'module_focus_desc': 'Ablenkungssperre und Deep-Work-Blöcke',
      'module_finance': 'Finanzen',
      'module_finance_desc': 'Ausgabenverfolgung und Budgetwarnungen',
      'module_health': 'Gesundheit',
      'module_health_desc': 'Flüssigkeitszufuhr, Schlaf und Bewegung',
      'module_agenda': 'Agenda',
      'module_agenda_desc': 'Ereignisse, Erinnerungen und Prioritäten',
      'module_automation': 'Automatisierung',
      'module_automation_desc': 'Intelligente Regeln basierend auf Kontext',
      // Tasks in showcase
      'task_energy_metrics': 'Energiemetrics überprüfen',
      'task_sprint_report': 'Sprint-Bericht senden',
      'task_focus_session': 'Fokussitzung 45 Min',
      'task_budget_update': 'Budget aktualisieren',
      // Refresh screen
      'refresh_lab_title': 'Aktualisierungs-Labor',
      'refresh_no_items': 'Keine Elemente vorhanden',
      'refresh_instruction': 'Ziehen Sie zum Aktualisieren oder verwenden Sie die Schaltflächen, um die Neuladen zu erzwingen und das Verhalten live zu sehen.',
      'refresh_force_btn': 'Aktualisierung erzwingen',
      'refresh_refreshing': 'Wird aktualisiert...',
      'refresh_insert_instruction': 'Zum Aktualisieren ziehen, um mehr Elemente einzufügen',
      // Finance module
      'finance_monthly_budget': 'Monatliches Budget',
      'finance_budget_alert': 'Budgetwarnung',
      'finance_alert_notify': 'Benachrichtige, wenn Limit von 80% überschritten wird',
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
      // Utility modules
      'module_routines': '日常安排',
      'module_routines_desc': '习惯、连续记录和每日目标',
      'module_focus': '专注',
      'module_focus_desc': '分心拦截和深度工作块',
      'module_finance': '财务',
      'module_finance_desc': '支出跟踪和预算提醒',
      'module_health': '健康',
      'module_health_desc': '水分摄入、睡眠和运动',
      'module_agenda': '日程',
      'module_agenda_desc': '事件、提醒和优先级',
      'module_automation': '自动化',
      'module_automation_desc': '基于上下文的智能规则',
      // Tasks in showcase
      'task_energy_metrics': '查看能量指标',
      'task_sprint_report': '发送冲刺报告',
      'task_focus_session': '专注会话 45 分钟',
      'task_budget_update': '更新预算',
      // Refresh screen
      'refresh_lab_title': '刷新实验室',
      'refresh_no_items': '暂无项目',
      'refresh_instruction': '下拉刷新或使用按钮强制重新加载并查看实时行为。',
      'refresh_force_btn': '强制刷新',
      'refresh_refreshing': '刷新中...',
      'refresh_insert_instruction': '下拉刷新以插入更多项目',
      // Finance module
      'finance_monthly_budget': '月度预算',
      'finance_budget_alert': '预算提醒',
      'finance_alert_notify': '超过每月限额的 80% 时通知',
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
  // Modules
  String get moduleRoutines => _t('module_routines');
  String get moduleRoutinesDesc => _t('module_routines_desc');
  String get moduleFocus => _t('module_focus');
  String get moduleFocusDesc => _t('module_focus_desc');
  String get moduleFinance => _t('module_finance');
  String get moduleFinanceDesc => _t('module_finance_desc');
  String get moduleHealth => _t('module_health');
  String get moduleHealthDesc => _t('module_health_desc');
  String get moduleAgenda => _t('module_agenda');
  String get moduleAgendaDesc => _t('module_agenda_desc');
  String get moduleAutomation => _t('module_automation');
  String get moduleAutomationDesc => _t('module_automation_desc');
  // Tasks
  String get taskEnergyMetrics => _t('task_energy_metrics');
  String get taskSprintReport => _t('task_sprint_report');
  String get taskFocusSession => _t('task_focus_session');
  String get taskBudgetUpdate => _t('task_budget_update');
  // Refresh
  String get refreshLabTitle => _t('refresh_lab_title');
  String get refreshNoItems => _t('refresh_no_items');
  String get refreshInstruction => _t('refresh_instruction');
  String get refreshForceBtn => _t('refresh_force_btn');
  String get refreshRefreshing => _t('refresh_refreshing');
  String get refreshInsertInstruction => _t('refresh_insert_instruction');
  // Finance
  String get financeMonthlyBudget => _t('finance_monthly_budget');
  String get financeBudgetAlert => _t('finance_budget_alert');
  String get financeAlertNotify => _t('finance_alert_notify');
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
