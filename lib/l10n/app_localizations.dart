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
      // Buttons screen
      'buttons_playground_title': 'Buttons Playground',
      'buttons_playground_subtitle': 'M3E button variants and interactions',
      'buttons_variants_title': 'Button Variants',
      'buttons_filled_label': 'Filled',
      'buttons_tonal_label': 'Tonal',
      'buttons_outlined_label': 'Outlined',
      'buttons_text_label': 'Text',
      'buttons_elevated_label': 'Elevated',
      'buttons_icon_title': 'Icon Buttons',
      'buttons_split_title': 'Split Buttons',
      'buttons_split_save_label': 'Save',
      'buttons_split_save_as_label': 'Save As',
      'buttons_group_title': 'Button Groups',
      'buttons_group_day_label': 'Day',
      'buttons_group_week_label': 'Week',
      'buttons_group_month_label': 'Month',
      'buttons_toolbar_title': 'Toolbar',
      'buttons_editor_title': 'Editor',
      'buttons_toolbar_bold_label': 'Bold',
      'buttons_toolbar_italic_label': 'Italic',
      'buttons_toolbar_underline_label': 'Underline',
      'buttons_toolbar_delete_label': 'Delete',
      'buttons_m3e_package_title': 'M3E Buttons Package',
      'buttons_m3e_filled_label': 'M3E Filled',
      'buttons_m3e_tonal_label': 'M3E Tonal',
      'buttons_m3e_icon_label': 'M3E Icon',
      'buttons_split_v2_label': 'Split Button V2',
      'buttons_split_copy_label': 'Copy',
      'buttons_split_move_label': 'Move',
      // Core widgets screen
      'core_widgets_title': 'Core Widgets',
      'core_widgets_subtitle': 'Essential Material 3 Expressive components',
      'core_card_column_title': 'Card Column',
      'core_card_item1': 'Palette',
      'core_card_item2': 'Layers',
      'core_card_item3': 'Power',
      'core_dismissible_title': 'Dismissible',
      'core_dismissible_slide_hint': 'Slide to dismiss',
      'core_expandable_title': 'Expandable',
      'core_section_n': 'Section ',
      'core_section_content': 'Content ',
      'core_dropdown_title': 'Dropdown',
      'core_dropdown_blue': 'Blue',
      'core_dropdown_green': 'Green',
      'core_dropdown_amber': 'Amber',
      // Navigation screen
      'nav_screen_title': 'Navigation Screens',
      'nav_screen_subtitle': 'Explore M3E navigation components',
      'nav_bar_title': 'Navigation Bar',
      'nav_home_label': 'Home',
      'nav_search_label': 'Search',
      'nav_profile_label': 'Profile',
      'nav_rail_title': 'Navigation Rail',
      'nav_dashboard_label': 'Dashboard',
      'nav_explore_label': 'Explore',
      'nav_settings_label': 'Settings',
      'nav_example_content': 'You are here',
      // Progress & Motion screen
      'progress_lab_title': 'Progress & Motion Lab',
      'progress_lab_subtitle': 'Indicators, sliders, and animations',
      'progress_indicator_title': 'Progress Indicators',
      'progress_slider_title': 'Sliders',
      'progress_motion_demo_title': 'Motion Demo',
      // Refresh & AppBar screen
      'refresh_no_items_label': 'No refreshes yet',
      'refresh_last_refresh': 'Last refresh: ',
      'refresh_demo_title': 'Refresh Lab',
      'refresh_demo_subtitle': 'Try pull-to-refresh or use the buttons below',
      'refresh_force_btn': 'Force refresh',
      'refresh_refreshing': 'Refreshing...',
      'refresh_reset_btn': 'Reset + Refresh',
      'refresh_count_label': 'Refresh count: ',
      'refresh_component_item': 'Component item #',
      'refresh_insert_instruction': 'Pull-to-refresh to insert new item',
      // Shapes screen
      'shapes_title': 'Shapes Lab',
      'shapes_subtitle': 'M3E geometries for bolder compositions',
      'shapes_basic': 'Basic Shapes',
      'shapes_basic_desc': 'Foundation geometries',
      'shapes_animated': 'Animated Shapes',
      'shapes_animated_desc': 'Dynamic transitions',
      'shapes_advanced': 'Advanced Shapes',
      'shapes_advanced_desc': 'Complex geometries',
      'shapes_interactive': 'Interactive Shapes',
      'shapes_interactive_desc': 'User-controlled shapes',
      'shapes_usage': 'Usage Patterns',
      'shapes_usage_desc': 'Best practices',
      // Libraries screen
      'libraries_title': 'Libraries',
      'libraries_intro_title': 'Our Ecosystem',
      'libraries_intro_desc': 'Explore the M3E collection',
      'libraries_stack_title': 'Tech Stack',
      'libraries_stack_desc': 'Built with Flutter and Material 3',
      'libraries_guidelines_title': 'Design Guidelines',
      'libraries_guideline1': 'Follow Material 3 standards',
      'libraries_guideline2': 'Maintain accessibility',
      'libraries_guideline3': 'Use consistent spacing',
      'libraries_guideline4': 'Ensure responsive design',
      'libraries_guideline5': 'Test across devices',
      'libraries_credits_title': 'Credits',
      'libraries_open_source': 'Open Source',
      'm3_expressive': 'Material 3 Expressive',
      'libraries_author': 'Built by iCristian',
      'libraries_role1': 'Design & Development',
      'libraries_role2': 'Flutter & Dart expertise',
      'libraries_role3': 'UI/UX focus',
      'libraries_github_btn': 'Visit GitHub',
      'libraries_source_btn': 'View Source',
      // Showcase screen
      'task_energy_metrics': 'Review energy metrics',
      'task_sprint_report': 'Send sprint report',
      'task_focus_session': '45-min focus session',
      'task_budget_update': 'Update budget',
      'showcase_first_view_desc': 'Experience the power of Material 3 Expressive',
      'showcase_customization_title': 'Live Customization',
      'showcase_energy_intensity': 'Energy Intensity',
      'showcase_organicity_label': 'Organicity',
      'showcase_color_burst_title': 'Color Burst',
      'showcase_color_burst_desc': 'Quick view of tones',
      'showcase_media_stage_title': 'M3E Media Stage',
      'showcase_media_stage_subtitle': 'Material 3 Expressive · Vimeo',
      'showcase_video_load_hint': 'Tap to load · Vimeo',
      'showcase_video_play_btn': 'Play Vimeo',
      'showcase_video_pause_btn': 'Pause Vimeo',
      'showcase_video_unmute_btn': 'Unmute',
      'showcase_video_mute_btn': 'Mute',
      'showcase_video_restart_btn': 'Restart',
      'showcase_video_embed_fail_hint': 'If embedded fails...',
      'showcase_search_hint': 'Search functionality...',
      'showcase_productivity_panel_title': 'Productivity Panel',
      'showcase_focus_mode_label': 'Focus Mode',
      'showcase_smart_alerts_label': 'Smart Alerts',
      'showcase_boost_btn': 'Boost +5%',
      'showcase_active_modules_title': 'Active modules',
      'showcase_no_results': 'No functionality found with ',
      'showcase_agenda_today_title': 'Smart agenda today',
      'showcase_agenda_done_btn': 'Done',
      'showcase_agenda_mark_btn': 'Mark',
      'showcase_credits': 'Credits',
      'showcase_github_title': 'GitHub Repository',
      'showcase_github_desc': 'Explore the source code',
      'showcase_github_btn': 'Open GitHub',
      // Utilities/Routines
      'routines_habits_list1': 'Read 20 min',
      'routines_habits_list2': 'Stretch 10 min',
      'routines_habits_list3': 'Plan top 3',
      'routines_habits_list4': 'Inbox zero',
      'routines_streak_title': 'Weekly streak',
      'routines_habits_completed': 'habits completed',
    },
    'es': {
      'nav_showcase': 'Inicio',
      'nav_showcase_short': 'Inicio',
      'nav_buttons': 'Botones',
      'nav_buttons_short': 'Botones',
      'nav_navigation': 'Navegación',
      'nav_navigation_short': 'Nav',
      'nav_motion': 'Movimiento',
      'nav_motion_short': 'Movimiento',
      'nav_refresh': 'Refrescar',
      'nav_refresh_short': 'Refrescar',
      'nav_core': 'Core',
      'nav_core_short': 'Core',
      'nav_shapes': 'Formas',
      'nav_shapes_short': 'Formas',
      'nav_libraries': 'Librerías',
      'nav_libraries_short': 'Libs',
      'studio_title': 'Studio M3E',
      'studio_color_mode': 'Modo de color',
      'studio_light': 'Claro',
      'studio_dark': 'Oscuro',
      'studio_system': 'Sistema',
      'studio_typography': 'Tipografía activa',
      'studio_palette': 'Paleta de color',
      'studio_surprise': 'Color sorpresa',
      'studio_language': 'Idioma',
      'buttons_playground_title': 'Parque de Botones',
      'buttons_playground_subtitle': 'Variantes e interacciones de M3E',
      'buttons_variants_title': 'Variantes de Botón',
      'buttons_filled_label': 'Relleno',
      'buttons_tonal_label': 'Tonal',
      'buttons_outlined_label': 'Contorno',
      'buttons_text_label': 'Texto',
      'buttons_elevated_label': 'Elevado',
      'buttons_icon_title': 'Botones de Icono',
      'buttons_split_title': 'Botones Divididos',
      'buttons_split_save_label': 'Guardar',
      'buttons_split_save_as_label': 'Guardar Como',
      'buttons_group_title': 'Grupos de Botones',
      'buttons_group_day_label': 'Día',
      'buttons_group_week_label': 'Semana',
      'buttons_group_month_label': 'Mes',
      'buttons_toolbar_title': 'Barra de Herramientas',
      'buttons_editor_title': 'Editor',
      'buttons_toolbar_bold_label': 'Negrita',
      'buttons_toolbar_italic_label': 'Cursiva',
      'buttons_toolbar_underline_label': 'Subrayado',
      'buttons_toolbar_delete_label': 'Eliminar',
      'buttons_m3e_package_title': 'Paquete de Botones M3E',
      'buttons_m3e_filled_label': 'M3E Relleno',
      'buttons_m3e_tonal_label': 'M3E Tonal',
      'buttons_m3e_icon_label': 'M3E Icono',
      'buttons_split_v2_label': 'Botón Dividido V2',
      'buttons_split_copy_label': 'Copiar',
      'buttons_split_move_label': 'Mover',
      'core_widgets_title': 'Widgets Core',
      'core_widgets_subtitle': 'Componentes Material 3 Expressive esenciales',
      'core_card_column_title': 'Columna de Tarjetas',
      'core_card_item1': 'Paleta',
      'core_card_item2': 'Capas',
      'core_card_item3': 'Energía',
      'core_dismissible_title': 'Descartar',
      'core_dismissible_slide_hint': 'Desliza para descartar',
      'core_expandable_title': 'Expandible',
      'core_section_n': 'Sección ',
      'core_section_content': 'Contenido ',
      'core_dropdown_title': 'Menú Desplegable',
      'core_dropdown_blue': 'Azul',
      'core_dropdown_green': 'Verde',
      'core_dropdown_amber': 'Ámbar',
      'nav_screen_title': 'Pantallas de Navegación',
      'nav_screen_subtitle': 'Explora componentes de navegación M3E',
      'nav_bar_title': 'Barra de Navegación',
      'nav_home_label': 'Inicio',
      'nav_search_label': 'Buscar',
      'nav_profile_label': 'Perfil',
      'nav_rail_title': 'Carril de Navegación',
      'nav_dashboard_label': 'Panel',
      'nav_explore_label': 'Explorar',
      'nav_settings_label': 'Configuración',
      'nav_example_content': 'Estás aquí',
      'progress_lab_title': 'Laboratorio de Progreso y Movimiento',
      'progress_lab_subtitle': 'Indicadores, deslizadores y animaciones',
      'progress_indicator_title': 'Indicadores de Progreso',
      'progress_slider_title': 'Deslizadores',
      'progress_motion_demo_title': 'Demo de Movimiento',
      'refresh_no_items_label': 'Sin refrescos aún',
      'refresh_last_refresh': 'Último refresh: ',
      'refresh_demo_title': 'Laboratorio de Refresh',
      'refresh_demo_subtitle': 'Prueba pull-to-refresh o usa los botones',
      'refresh_force_btn': 'Forzar refresh',
      'refresh_refreshing': 'Refrescando...',
      'refresh_reset_btn': 'Reset + Refresh',
      'refresh_count_label': 'Refrescos: ',
      'refresh_component_item': 'Componente #',
      'refresh_insert_instruction': 'Pull-to-refresh para insertar nuevo',
      'shapes_title': 'Laboratorio de Formas',
      'shapes_subtitle': 'Geometrías M3E para composiciones audaces',
      'shapes_basic': 'Formas Básicas',
      'shapes_basic_desc': 'Geometrías de fundación',
      'shapes_animated': 'Formas Animadas',
      'shapes_animated_desc': 'Transiciones dinámicas',
      'shapes_advanced': 'Formas Avanzadas',
      'shapes_advanced_desc': 'Geometrías complejas',
      'shapes_interactive': 'Formas Interactivas',
      'shapes_interactive_desc': 'Formas controladas por el usuario',
      'shapes_usage': 'Patrones de Uso',
      'shapes_usage_desc': 'Mejores prácticas',
      'libraries_title': 'Librerías',
      'libraries_intro_title': 'Nuestro Ecosistema',
      'libraries_intro_desc': 'Explora la colección M3E',
      'libraries_stack_title': 'Stack Tecnológico',
      'libraries_stack_desc': 'Construido con Flutter y Material 3',
      'libraries_guidelines_title': 'Directrices de Diseño',
      'libraries_guideline1': 'Sigue estándares Material 3',
      'libraries_guideline2': 'Mantén accesibilidad',
      'libraries_guideline3': 'Usa espacios consistentes',
      'libraries_guideline4': 'Asegura diseño responsivo',
      'libraries_guideline5': 'Prueba en múltiples dispositivos',
      'libraries_credits_title': 'Créditos',
      'libraries_open_source': 'Código Abierto',
      'm3_expressive': 'Material 3 Expressive',
      'libraries_author': 'Construido por iCristian',
      'libraries_role1': 'Diseño y Desarrollo',
      'libraries_role2': 'Experiencia en Flutter & Dart',
      'libraries_role3': 'Enfoque UI/UX',
      'libraries_github_btn': 'Visita GitHub',
      'libraries_source_btn': 'Ver Código',
      'task_energy_metrics': 'Revisar métricas de energía',
      'task_sprint_report': 'Enviar reporte del sprint',
      'task_focus_session': 'Sesión de focus 45 min',
      'task_budget_update': 'Actualizar presupuesto',
      'showcase_first_view_desc': 'Experimenta el poder de Material 3 Expressive',
      'showcase_customization_title': 'Personalización en Vivo',
      'showcase_energy_intensity': 'Intensidad de Energía',
      'showcase_organicity_label': 'Organicidad',
      'showcase_color_burst_title': 'Explosión de Color',
      'showcase_color_burst_desc': 'Vista rápida de tonos',
      'showcase_media_stage_title': 'M3E Media Stage',
      'showcase_media_stage_subtitle': 'Material 3 Expressive · Vimeo',
      'showcase_video_load_hint': 'Toca para cargar · Vimeo',
      'showcase_video_play_btn': 'Reproducir Vimeo',
      'showcase_video_pause_btn': 'Pausar Vimeo',
      'showcase_video_unmute_btn': 'Sonido',
      'showcase_video_mute_btn': 'Silenciar',
      'showcase_video_restart_btn': 'Reiniciar',
      'showcase_video_embed_fail_hint': 'Si falla embebido...',
      'showcase_search_hint': 'Busca una funcionalidad...',
      'showcase_productivity_panel_title': 'Panel de Productividad',
      'showcase_focus_mode_label': 'Focus Mode',
      'showcase_smart_alerts_label': 'Smart Alerts',
      'showcase_boost_btn': 'Boost +5%',
      'showcase_active_modules_title': 'Módulos activos',
      'showcase_no_results': 'No se encontraron funcionalidades con ',
      'showcase_agenda_today_title': 'Agenda inteligente de hoy',
      'showcase_agenda_done_btn': 'Hecho',
      'showcase_agenda_mark_btn': 'Marcar',
      'showcase_credits': 'Créditos',
      'showcase_github_title': 'Repositorio GitHub',
      'showcase_github_desc': 'Explora el código fuente',
      'showcase_github_btn': 'Abrir GitHub',
      'routines_habits_list1': 'Leer 20 min',
      'routines_habits_list2': 'Estirar 10 min',
      'routines_habits_list3': 'Planificar top 3',
      'routines_habits_list4': 'Inbox cero',
      'routines_streak_title': 'Streak semanal',
      'routines_habits_completed': 'hábitos completados',
    },
    'de': {
      'nav_showcase': 'Startseite',
      'nav_showcase_short': 'Startseite',
      'nav_buttons': 'Schaltflächen',
      'nav_buttons_short': 'Schaltflächen',
      'nav_navigation': 'Navigation',
      'nav_navigation_short': 'Nav',
      'nav_motion': 'Bewegung',
      'nav_motion_short': 'Bewegung',
      'nav_refresh': 'Aktualisieren',
      'nav_refresh_short': 'Aktualisieren',
      'nav_core': 'Kern',
      'nav_core_short': 'Kern',
      'nav_shapes': 'Formen',
      'nav_shapes_short': 'Formen',
      'nav_libraries': 'Bibliotheken',
      'nav_libraries_short': 'Bib',
      'studio_title': 'Studio M3E',
      'studio_color_mode': 'Farbmodus',
      'studio_light': 'Hell',
      'studio_dark': 'Dunkel',
      'studio_system': 'System',
      'studio_typography': 'Aktive Typografie',
      'studio_palette': 'Farbpalette',
      'studio_surprise': 'Überraschungsfarbe',
      'studio_language': 'Sprache',
      'buttons_playground_title': 'Schaltflächenspielplatz',
      'buttons_playground_subtitle': 'M3E-Schaltflächenvarianten und Interaktionen',
      'buttons_variants_title': 'Schaltflächenvarianten',
      'buttons_filled_label': 'Gefüllt',
      'buttons_tonal_label': 'Tonal',
      'buttons_outlined_label': 'Umriss',
      'buttons_text_label': 'Text',
      'buttons_elevated_label': 'Erhöht',
      'buttons_icon_title': 'Icon-Schaltflächen',
      'buttons_split_title': 'Geteilte Schaltflächen',
      'buttons_split_save_label': 'Speichern',
      'buttons_split_save_as_label': 'Speichern unter',
      'buttons_group_title': 'Schaltflächengruppen',
      'buttons_group_day_label': 'Tag',
      'buttons_group_week_label': 'Woche',
      'buttons_group_month_label': 'Monat',
      'buttons_toolbar_title': 'Symbolleiste',
      'buttons_editor_title': 'Editor',
      'buttons_toolbar_bold_label': 'Fett',
      'buttons_toolbar_italic_label': 'Kursiv',
      'buttons_toolbar_underline_label': 'Unterstrichen',
      'buttons_toolbar_delete_label': 'Löschen',
      'buttons_m3e_package_title': 'M3E-Schaltflächenpaket',
      'buttons_m3e_filled_label': 'M3E Gefüllt',
      'buttons_m3e_tonal_label': 'M3E Tonal',
      'buttons_m3e_icon_label': 'M3E Icon',
      'buttons_split_v2_label': 'Geteilte Schaltfläche V2',
      'buttons_split_copy_label': 'Kopieren',
      'buttons_split_move_label': 'Verschieben',
      'core_widgets_title': 'Kern-Widgets',
      'core_widgets_subtitle': 'Wesentliche Material 3 Expressive-Komponenten',
      'core_card_column_title': 'Kartenspalte',
      'core_card_item1': 'Palette',
      'core_card_item2': 'Ebenen',
      'core_card_item3': 'Leistung',
      'core_dismissible_title': 'Verwerfbar',
      'core_dismissible_slide_hint': 'Zum Verwerfen schieben',
      'core_expandable_title': 'Erweiterbar',
      'core_section_n': 'Abschnitt ',
      'core_section_content': 'Inhalt ',
      'core_dropdown_title': 'Dropdown',
      'core_dropdown_blue': 'Blau',
      'core_dropdown_green': 'Grün',
      'core_dropdown_amber': 'Bernstein',
      'nav_screen_title': 'Navigationsbildschirme',
      'nav_screen_subtitle': 'Erkunden Sie M3E-Navigationskomponenten',
      'nav_bar_title': 'Navigationsleiste',
      'nav_home_label': 'Startseite',
      'nav_search_label': 'Suchen',
      'nav_profile_label': 'Profil',
      'nav_rail_title': 'Navigationsleiste',
      'nav_dashboard_label': 'Dashboard',
      'nav_explore_label': 'Erkunden',
      'nav_settings_label': 'Einstellungen',
      'nav_example_content': 'Du bist hier',
      'progress_lab_title': 'Fortschritts- und Bewegungslabor',
      'progress_lab_subtitle': 'Indikatoren, Regler und Animationen',
      'progress_indicator_title': 'Fortschrittsanzeigen',
      'progress_slider_title': 'Regler',
      'progress_motion_demo_title': 'Bewegungs-Demo',
      'refresh_no_items_label': 'Noch keine Aktualisierungen',
      'refresh_last_refresh': 'Letzte Aktualisierung: ',
      'refresh_demo_title': 'Aktualisierungslabor',
      'refresh_demo_subtitle': 'Versuchen Sie Pull-to-Refresh oder verwenden Sie die Schaltflächen',
      'refresh_force_btn': 'Aktualisierung erzwingen',
      'refresh_refreshing': 'Aktualisierung läuft...',
      'refresh_reset_btn': 'Reset + Aktualisierung',
      'refresh_count_label': 'Aktualisierungsanzahl: ',
      'refresh_component_item': 'Komponentenelement #',
      'refresh_insert_instruction': 'Pull-to-Refresh zum Einfügen',
      'shapes_title': 'Formenlabor',
      'shapes_subtitle': 'M3E-Geometrien für kühnere Kompositionen',
      'shapes_basic': 'Grundformen',
      'shapes_basic_desc': 'Grundgeometrien',
      'shapes_animated': 'Animierte Formen',
      'shapes_animated_desc': 'Dynamische Übergänge',
      'shapes_advanced': 'Erweiterte Formen',
      'shapes_advanced_desc': 'Komplexe Geometrien',
      'shapes_interactive': 'Interaktive Formen',
      'shapes_interactive_desc': 'Vom Benutzer gesteuerte Formen',
      'shapes_usage': 'Verwendungsmuster',
      'shapes_usage_desc': 'Best Practices',
      'libraries_title': 'Bibliotheken',
      'libraries_intro_title': 'Unser Ökosystem',
      'libraries_intro_desc': 'Erkunden Sie die M3E-Sammlung',
      'libraries_stack_title': 'Tech-Stack',
      'libraries_stack_desc': 'Gebaut mit Flutter und Material 3',
      'libraries_guidelines_title': 'Designrichtlinien',
      'libraries_guideline1': 'Befolgen Sie Material 3-Standards',
      'libraries_guideline2': 'Gewährleisten Sie Zugänglichkeit',
      'libraries_guideline3': 'Verwenden Sie konsistente Abstände',
      'libraries_guideline4': 'Stellen Sie responsives Design sicher',
      'libraries_guideline5': 'Testen Sie auf verschiedenen Geräten',
      'libraries_credits_title': 'Danksagungen',
      'libraries_open_source': 'Open Source',
      'm3_expressive': 'Material 3 Expressive',
      'libraries_author': 'Gebaut von iCristian',
      'libraries_role1': 'Design & Entwicklung',
      'libraries_role2': 'Flutter & Dart Expertise',
      'libraries_role3': 'UI/UX-Fokus',
      'libraries_github_btn': 'GitHub besuchen',
      'libraries_source_btn': 'Quellcode anzeigen',
      'task_energy_metrics': 'Energiemetriken überprüfen',
      'task_sprint_report': 'Sprint-Bericht senden',
      'task_focus_session': '45-Min-Fokus-Sitzung',
      'task_budget_update': 'Budget aktualisieren',
      'showcase_first_view_desc': 'Erleben Sie die Kraft von Material 3 Expressive',
      'showcase_customization_title': 'Live-Anpassung',
      'showcase_energy_intensity': 'Energieintensität',
      'showcase_organicity_label': 'Organicität',
      'showcase_color_burst_title': 'Farbausbruch',
      'showcase_color_burst_desc': 'Schnelle Ansicht von Tönen',
      'showcase_media_stage_title': 'M3E Media Stage',
      'showcase_media_stage_subtitle': 'Material 3 Expressive · Vimeo',
      'showcase_video_load_hint': 'Zum Laden tippen · Vimeo',
      'showcase_video_play_btn': 'Vimeo abspielen',
      'showcase_video_pause_btn': 'Vimeo pausieren',
      'showcase_video_unmute_btn': 'Ton aktivieren',
      'showcase_video_mute_btn': 'Stummschalten',
      'showcase_video_restart_btn': 'Neu starten',
      'showcase_video_embed_fail_hint': 'Wenn Einbettung fehlschlägt...',
      'showcase_search_hint': 'Suchen Sie Funktionalität...',
      'showcase_productivity_panel_title': 'Produktivitätsbereich',
      'showcase_focus_mode_label': 'Fokus-Modus',
      'showcase_smart_alerts_label': 'Smart Alerts',
      'showcase_boost_btn': 'Boost +5%',
      'showcase_active_modules_title': 'Aktive Module',
      'showcase_no_results': 'Keine Funktionalität gefunden mit ',
      'showcase_agenda_today_title': 'Intelligente Agenda heute',
      'showcase_agenda_done_btn': 'Fertig',
      'showcase_agenda_mark_btn': 'Markieren',
      'showcase_credits': 'Danksagungen',
      'showcase_github_title': 'GitHub-Repository',
      'showcase_github_desc': 'Erkunden Sie den Quellcode',
      'showcase_github_btn': 'GitHub öffnen',
      'routines_habits_list1': '20 Min lesen',
      'routines_habits_list2': '10 Min dehnen',
      'routines_habits_list3': 'Top 3 planen',
      'routines_habits_list4': 'Posteingang leer',
      'routines_streak_title': 'Wöchentliche Serie',
      'routines_habits_completed': 'Gewohnheiten abgeschlossen',
    },
    'zh': {
      'nav_showcase': '首页',
      'nav_showcase_short': '首页',
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
      'nav_libraries': '库',
      'nav_libraries_short': '库',
      'studio_title': 'Studio M3E',
      'studio_color_mode': '颜色模式',
      'studio_light': '浅色',
      'studio_dark': '深色',
      'studio_system': '系统',
      'studio_typography': '活跃排版',
      'studio_palette': '颜色调板',
      'studio_surprise': '惊喜颜色',
      'studio_language': '语言',
      'buttons_playground_title': '按钮游乐场',
      'buttons_playground_subtitle': 'M3E 按钮变体和交互',
      'buttons_variants_title': '按钮变体',
      'buttons_filled_label': '填充',
      'buttons_tonal_label': '色调',
      'buttons_outlined_label': '描边',
      'buttons_text_label': '文本',
      'buttons_elevated_label': '提升',
      'buttons_icon_title': '图标按钮',
      'buttons_split_title': '分割按钮',
      'buttons_split_save_label': '保存',
      'buttons_split_save_as_label': '另存为',
      'buttons_group_title': '按钮组',
      'buttons_group_day_label': '天',
      'buttons_group_week_label': '周',
      'buttons_group_month_label': '月',
      'buttons_toolbar_title': '工具栏',
      'buttons_editor_title': '编辑器',
      'buttons_toolbar_bold_label': '粗体',
      'buttons_toolbar_italic_label': '斜体',
      'buttons_toolbar_underline_label': '下划线',
      'buttons_toolbar_delete_label': '删除',
      'buttons_m3e_package_title': 'M3E 按钮包',
      'buttons_m3e_filled_label': 'M3E 填充',
      'buttons_m3e_tonal_label': 'M3E 色调',
      'buttons_m3e_icon_label': 'M3E 图标',
      'buttons_split_v2_label': '分割按钮 V2',
      'buttons_split_copy_label': '复制',
      'buttons_split_move_label': '移动',
      'core_widgets_title': '核心小部件',
      'core_widgets_subtitle': '必要的 Material 3 Expressive 组件',
      'core_card_column_title': '卡片列',
      'core_card_item1': '调板',
      'core_card_item2': '图层',
      'core_card_item3': '力量',
      'core_dismissible_title': '可取消',
      'core_dismissible_slide_hint': '滑动以取消',
      'core_expandable_title': '可展开',
      'core_section_n': '部分 ',
      'core_section_content': '内容 ',
      'core_dropdown_title': '下拉菜单',
      'core_dropdown_blue': '蓝色',
      'core_dropdown_green': '绿色',
      'core_dropdown_amber': '琥珀',
      'nav_screen_title': '导航屏幕',
      'nav_screen_subtitle': '探索 M3E 导航组件',
      'nav_bar_title': '导航栏',
      'nav_home_label': '首页',
      'nav_search_label': '搜索',
      'nav_profile_label': '配置文件',
      'nav_rail_title': '导航栏',
      'nav_dashboard_label': '仪表盘',
      'nav_explore_label': '探索',
      'nav_settings_label': '设置',
      'nav_example_content': '你在这里',
      'progress_lab_title': '进度和动效实验室',
      'progress_lab_subtitle': '指示器、滑块和动画',
      'progress_indicator_title': '进度指示器',
      'progress_slider_title': '滑块',
      'progress_motion_demo_title': '动效演示',
      'refresh_no_items_label': '还没有刷新',
      'refresh_last_refresh': '最后刷新: ',
      'refresh_demo_title': '刷新实验室',
      'refresh_demo_subtitle': '尝试下拉刷新或使用下面的按钮',
      'refresh_force_btn': '强制刷新',
      'refresh_refreshing': '正在刷新...',
      'refresh_reset_btn': '重置 + 刷新',
      'refresh_count_label': '刷新次数: ',
      'refresh_component_item': '组件项目 #',
      'refresh_insert_instruction': '下拉刷新以插入新项',
      'shapes_title': '形状实验室',
      'shapes_subtitle': 'M3E 几何图形用于更大胆的组合',
      'shapes_basic': '基本形状',
      'shapes_basic_desc': '基础几何',
      'shapes_animated': '动画形状',
      'shapes_animated_desc': '动态过渡',
      'shapes_advanced': '高级形状',
      'shapes_advanced_desc': '复杂几何',
      'shapes_interactive': '交互式形状',
      'shapes_interactive_desc': '用户控制的形状',
      'shapes_usage': '使用模式',
      'shapes_usage_desc': '最佳实践',
      'libraries_title': '库',
      'libraries_intro_title': '我们的生态系统',
      'libraries_intro_desc': '探索 M3E 集合',
      'libraries_stack_title': '技术栈',
      'libraries_stack_desc': '使用 Flutter 和 Material 3 构建',
      'libraries_guidelines_title': '设计指南',
      'libraries_guideline1': '遵循 Material 3 标准',
      'libraries_guideline2': '保持无障碍',
      'libraries_guideline3': '使用一致的间距',
      'libraries_guideline4': '确保响应式设计',
      'libraries_guideline5': '在多个设备上测试',
      'libraries_credits_title': '致谢',
      'libraries_open_source': '开源',
      'm3_expressive': 'Material 3 Expressive',
      'libraries_author': '由 iCristian 构建',
      'libraries_role1': '设计和开发',
      'libraries_role2': 'Flutter 和 Dart 专长',
      'libraries_role3': '用户界面/用户体验焦点',
      'libraries_github_btn': '访问 GitHub',
      'libraries_source_btn': '查看源代码',
      'task_energy_metrics': '审查能量指标',
      'task_sprint_report': '发送 Sprint 报告',
      'task_focus_session': '45 分钟专注会话',
      'task_budget_update': '更新预算',
      'showcase_first_view_desc': '体验 Material 3 Expressive 的力量',
      'showcase_customization_title': '实时自定义',
      'showcase_energy_intensity': '能量强度',
      'showcase_organicity_label': '有机性',
      'showcase_color_burst_title': '色彩爆发',
      'showcase_color_burst_desc': '色调快速查看',
      'showcase_media_stage_title': 'M3E Media Stage',
      'showcase_media_stage_subtitle': 'Material 3 Expressive · Vimeo',
      'showcase_video_load_hint': '点击加载 · Vimeo',
      'showcase_video_play_btn': '播放 Vimeo',
      'showcase_video_pause_btn': '暂停 Vimeo',
      'showcase_video_unmute_btn': '取消静音',
      'showcase_video_mute_btn': '静音',
      'showcase_video_restart_btn': '重新开始',
      'showcase_video_embed_fail_hint': '如果嵌入失败...',
      'showcase_search_hint': '搜索功能...',
      'showcase_productivity_panel_title': '生产力面板',
      'showcase_focus_mode_label': '专注模式',
      'showcase_smart_alerts_label': '智能提醒',
      'showcase_boost_btn': '提升 +5%',
      'showcase_active_modules_title': '活跃模块',
      'showcase_no_results': '未找到包含 ',
      'showcase_agenda_today_title': '今天的智能议程',
      'showcase_agenda_done_btn': '完成',
      'showcase_agenda_mark_btn': '标记',
      'showcase_credits': '致谢',
      'showcase_github_title': 'GitHub 仓库',
      'showcase_github_desc': '探索源代码',
      'showcase_github_btn': '打开 GitHub',
      'routines_habits_list1': '阅读 20 分钟',
      'routines_habits_list2': '拉伸 10 分钟',
      'routines_habits_list3': '计划前 3',
      'routines_habits_list4': '收件箱归零',
      'routines_streak_title': '每周连胜',
      'routines_habits_completed': '习惯完成',
    },
  };

  String _t(String key) {
    final langCode = locale.languageCode;
    return _strings[langCode]?[key] ?? _strings['en']?[key] ?? key;
  }

  // Nav labels
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

  // Studio M3E
  String get studioTitle => _t('studio_title');
  String get studioColorMode => _t('studio_color_mode');
  String get studioLight => _t('studio_light');
  String get studioDark => _t('studio_dark');
  String get studioSystem => _t('studio_system');
  String get studioTypography => _t('studio_typography');
  String get studioPalette => _t('studio_palette');
  String get studioSurprise => _t('studio_surprise');
  String get studioLanguage => _t('studio_language');

  // Buttons screen
  String get buttonsPlaygroundTitle => _t('buttons_playground_title');
  String get buttonsPlaygroundSubtitle => _t('buttons_playground_subtitle');
  String get buttonsVariantsTitle => _t('buttons_variants_title');
  String get buttonsFilledLabel => _t('buttons_filled_label');
  String get buttonsTonalLabel => _t('buttons_tonal_label');
  String get buttonsOutlinedLabel => _t('buttons_outlined_label');
  String get buttonsTextLabel => _t('buttons_text_label');
  String get buttonsElevatedLabel => _t('buttons_elevated_label');
  String get buttonsIconTitle => _t('buttons_icon_title');
  String get buttonsSplitTitle => _t('buttons_split_title');
  String get buttonsSplitSaveLabel => _t('buttons_split_save_label');
  String get buttonsSplitSaveAsLabel => _t('buttons_split_save_as_label');
  String get buttonsGroupTitle => _t('buttons_group_title');
  String get buttonsGroupDayLabel => _t('buttons_group_day_label');
  String get buttonsGroupWeekLabel => _t('buttons_group_week_label');
  String get buttonsGroupMonthLabel => _t('buttons_group_month_label');
  String get buttonsToolbarTitle => _t('buttons_toolbar_title');
  String get buttonsEditorTitle => _t('buttons_editor_title');
  String get buttonsToolbarBoldLabel => _t('buttons_toolbar_bold_label');
  String get buttonsToolbarItalicLabel => _t('buttons_toolbar_italic_label');
  String get buttonsToolbarUnderlineLabel => _t('buttons_toolbar_underline_label');
  String get buttonsToolbarDeleteLabel => _t('buttons_toolbar_delete_label');
  String get buttonsM3ePackageTitle => _t('buttons_m3e_package_title');
  String get buttonsM3eFilledLabel => _t('buttons_m3e_filled_label');
  String get buttonsM3eTonalLabel => _t('buttons_m3e_tonal_label');
  String get buttonsM3eIconLabel => _t('buttons_m3e_icon_label');
  String get buttonsSplitV2Label => _t('buttons_split_v2_label');
  String get buttonsSplitCopyLabel => _t('buttons_split_copy_label');
  String get buttonsSplitMoveLabel => _t('buttons_split_move_label');

  // Core widgets screen
  String get coreWidgetsTitle => _t('core_widgets_title');
  String get coreWidgetsSubtitle => _t('core_widgets_subtitle');
  String get coreCardColumnTitle => _t('core_card_column_title');
  String get coreCardItem1 => _t('core_card_item1');
  String get coreCardItem2 => _t('core_card_item2');
  String get coreCardItem3 => _t('core_card_item3');
  String get coreDismissibleTitle => _t('core_dismissible_title');
  String get coreDismissibleSlideHint => _t('core_dismissible_slide_hint');
  String get coreExpandableTitle => _t('core_expandable_title');
  String get coreSectionN => _t('core_section_n');
  String get coreSectionContent => _t('core_section_content');
  String get coreDropdownTitle => _t('core_dropdown_title');
  String get coreDropdownBlue => _t('core_dropdown_blue');
  String get coreDropdownGreen => _t('core_dropdown_green');
  String get coreDropdownAmber => _t('core_dropdown_amber');

  // Navigation screen
  String get navScreenTitle => _t('nav_screen_title');
  String get navScreenSubtitle => _t('nav_screen_subtitle');
  String get navBarTitle => _t('nav_bar_title');
  String get navHomeLabel => _t('nav_home_label');
  String get navSearchLabel => _t('nav_search_label');
  String get navProfileLabel => _t('nav_profile_label');
  String get navRailTitle => _t('nav_rail_title');
  String get navDashboardLabel => _t('nav_dashboard_label');
  String get navExploreLabel => _t('nav_explore_label');
  String get navSettingsLabel => _t('nav_settings_label');
  String get navExampleContent => _t('nav_example_content');

  // Progress & Motion screen
  String get progressLabTitle => _t('progress_lab_title');
  String get progressLabSubtitle => _t('progress_lab_subtitle');
  String get progressIndicatorTitle => _t('progress_indicator_title');
  String get progressSliderTitle => _t('progress_slider_title');
  String get progressMotionDemoTitle => _t('progress_motion_demo_title');

  // Refresh & AppBar screen
  String get refreshNoItemsLabel => _t('refresh_no_items_label');
  String get refreshLastRefresh => _t('refresh_last_refresh');
  String get refreshDemoTitle => _t('refresh_demo_title');
  String get refreshDemoSubtitle => _t('refresh_demo_subtitle');
  String get refreshForceBtn => _t('refresh_force_btn');
  String get refreshRefreshing => _t('refresh_refreshing');
  String get refreshResetBtn => _t('refresh_reset_btn');
  String get refreshCountLabel => _t('refresh_count_label');
  String get refreshComponentItem => _t('refresh_component_item');
  String get refreshInsertInstruction => _t('refresh_insert_instruction');

  // Shapes screen
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

  // Libraries screen
  String get librariesTitle => _t('libraries_title');
  String get librariesIntroTitle => _t('libraries_intro_title');
  String get librariesIntroDesc => _t('libraries_intro_desc');
  String get librariesStackTitle => _t('libraries_stack_title');
  String get librariesStackDesc => _t('libraries_stack_desc');
  String get librariesGuidelinesTitle => _t('libraries_guidelines_title');
  String get librariesGuideline1 => _t('libraries_guideline1');
  String get librariesGuideline2 => _t('libraries_guideline2');
  String get librariesGuideline3 => _t('libraries_guideline3');
  String get librariesGuideline4 => _t('libraries_guideline4');
  String get librariesGuideline5 => _t('libraries_guideline5');
  String get librariesCreditsTitle => _t('libraries_credits_title');
  String get librariesOpenSource => _t('libraries_open_source');
  String get m3Expressive => _t('m3_expressive');
  String get librariesAuthor => _t('libraries_author');
  String get librariesRole1 => _t('libraries_role1');
  String get librariesRole2 => _t('libraries_role2');
  String get librariesRole3 => _t('libraries_role3');
  String get librariesGithubBtn => _t('libraries_github_btn');
  String get librariesSourceBtn => _t('libraries_source_btn');
  String get librariesViewDocs => _t('libraries_view_docs');

  // Showcase screen
  String get taskEnergyMetrics => _t('task_energy_metrics');
  String get taskSprintReport => _t('task_sprint_report');
  String get taskFocusSession => _t('task_focus_session');
  String get taskBudgetUpdate => _t('task_budget_update');
  String get showcaseFirstViewDesc => _t('showcase_first_view_desc');
  String get showcaseCustomizationTitle => _t('showcase_customization_title');
  String get showcaseEnergyIntensity => _t('showcase_energy_intensity');
  String get showcaseOrganicityLabel => _t('showcase_organicity_label');
  String get showcaseColorBurstTitle => _t('showcase_color_burst_title');
  String get showcaseColorBurstDesc => _t('showcase_color_burst_desc');
  String get showcaseMediaStageTitle => _t('showcase_media_stage_title');
  String get showcaseMediaStageSubtitle => _t('showcase_media_stage_subtitle');
  String get showcaseVideoLoadHint => _t('showcase_video_load_hint');
  String get showcaseVideoPlayBtn => _t('showcase_video_play_btn');
  String get showcaseVideoPauseBtn => _t('showcase_video_pause_btn');
  String get showcaseVideoUnmuteBtn => _t('showcase_video_unmute_btn');
  String get showcaseVideoMuteBtn => _t('showcase_video_mute_btn');
  String get showcaseVideoRestartBtn => _t('showcase_video_restart_btn');
  String get showcaseVideoEmbedFailHint => _t('showcase_video_embed_fail_hint');
  String get showcaseSearchHint => _t('showcase_search_hint');
  String get showcaseProductivityPanelTitle => _t('showcase_productivity_panel_title');
  String get showcaseFocusModeLabel => _t('showcase_focus_mode_label');
  String get showcaseSmartAlertsLabel => _t('showcase_smart_alerts_label');
  String get showcaseBoostBtn => _t('showcase_boost_btn');
  String get showcaseActiveModulesTitle => _t('showcase_active_modules_title');
  String get showcaseNoResults => _t('showcase_no_results');
  String get showcaseAgendaTodayTitle => _t('showcase_agenda_today_title');
  String get showcaseAgendaDoneBtn => _t('showcase_agenda_done_btn');
  String get showcaseAgendaMarkBtn => _t('showcase_agenda_mark_btn');
  String get showcaseCredits => _t('showcase_credits');
  String get showcaseGithubTitle => _t('showcase_github_title');
  String get showcaseGithubDesc => _t('showcase_github_desc');
  String get showcaseGithubBtn => _t('showcase_github_btn');

  // Routines/Utilities
  String get routinesHabitsList1 => _t('routines_habits_list1');
  String get routinesHabitsList2 => _t('routines_habits_list2');
  String get routinesHabitsList3 => _t('routines_habits_list3');
  String get routinesHabitsList4 => _t('routines_habits_list4');
  String get routinesStreakTitle => _t('routines_streak_title');
  String get routinesHabitsCompleted => _t('routines_habits_completed');
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLocalizations.supportedLocales.contains(locale);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return Future.value(AppLocalizations(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
