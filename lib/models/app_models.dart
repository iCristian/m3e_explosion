/// Modelos, enums y constantes compartidas de la aplicación M3E Demo.
///
/// Este archivo centraliza todas las definiciones de tipos y constantes
/// que se usan en toda la app, facilitando la reutilización y mantenimiento.

import 'package:flutter/material.dart';

/// Packs de fuentes disponibles en la demo.
///
/// Se utiliza en [AppPreferencesService] para guardar/restaurar la preferencia
/// del usuario. Cada pack define un conjunto de fuentes Google Fonts.
enum DemoFontPack {
  /// Fuente Inter (sans-serif moderna)
  inter,

  /// Fuente Space Grotesk (futurista)
  spaceGrotesk,

  /// Fuente Playfair Display (serif elegante)
  playfairDisplay,

  /// Fuente Sora (geométrica)
  sora,
}

/// Extension para obtener etiqueta legible de [DemoFontPack].
///
/// Ejemplo:
/// ```dart
/// print(DemoFontPack.spaceGrotesk.label); // "Space Grotesk"
/// ```
extension DemoFontPackLabel on DemoFontPack {
  /// Retorna la etiqueta legible de este pack de fuentes.
  String get label {
    switch (this) {
      case DemoFontPack.inter:
        return 'Inter';
      case DemoFontPack.spaceGrotesk:
        return 'Space Grotesk';
      case DemoFontPack.playfairDisplay:
        return 'Playfair Display';
      case DemoFontPack.sora:
        return 'Sora';
    }
  }
}

/// Packs de colores disponibles en la demo.
///
/// Cada pack define una paleta de colores Material 3 completa,
/// utilizada para temas dinámicos de la app.
enum DemoColorPack {
  /// Paleta morada ultravioleta
  ultraViolet,

  /// Paleta coral sunset
  sunsetCoral,

  /// Paleta azul neon oceánico
  oceanNeon,

  /// Paleta verde lima pop
  limePop,

  /// Paleta rojo fuego cereza
  cherryFire,

  /// Paleta menta aurora
  auroraMint,
}

/// Extension para obtener etiqueta legible de [DemoColorPack].
///
/// Ejemplo:
/// ```dart
/// print(DemoColorPack.oceanNeon.label); // "Ocean Neon"
/// print(DemoColorPack.oceanNeon.seed); // Color(0xFF0A7B83)
/// ```
extension DemoColorPackLabel on DemoColorPack {
  /// Retorna la etiqueta legible de este pack de colores.
  String get label {
    switch (this) {
      case DemoColorPack.ultraViolet:
        return 'Ultra Violet';
      case DemoColorPack.sunsetCoral:
        return 'Sunset Coral';
      case DemoColorPack.oceanNeon:
        return 'Ocean Neon';
      case DemoColorPack.limePop:
        return 'Lime Pop';
      case DemoColorPack.cherryFire:
        return 'Cherry Fire';
      case DemoColorPack.auroraMint:
        return 'Aurora Mint';
    }
  }

  /// Retorna el color seed de Material 3 para este pack.
  /// Se usa para generar la paleta de colores dinámicamente.
  Color get seed {
    switch (this) {
      case DemoColorPack.ultraViolet:
        return const Color(0xFF6750A4);
      case DemoColorPack.sunsetCoral:
        return const Color(0xFFE35D5B);
      case DemoColorPack.oceanNeon:
        return const Color(0xFF0A7B83);
      case DemoColorPack.limePop:
        return const Color(0xFF6FAF1B);
      case DemoColorPack.cherryFire:
        return const Color(0xFFB3261E);
      case DemoColorPack.auroraMint:
        return const Color(0xFF1D9E8A);
    }
  }
}

/// Constantes de claves para almacenamiento en SharedPreferences.
///
/// Se utiliza en [AppPreferencesService] para una gestión centralizada
/// de las claves de persistencia. Esto permite refactorizar sin errores.
abstract class PrefKeys {
  /// Clave para tema (light/dark/system)
  static const String themeMode = 'settings.themeMode';

  /// Clave para pack de fuentes
  static const String fontPack = 'settings.fontPack';

  /// Clave para pack de colores
  static const String colorPack = 'settings.colorPack';

  /// Clave para contador de rutinas completadas
  static const String routinesDone = 'module.routines.done';

  /// Clave para tiempo restante de foco (en minutos)
  static const String focusRemaining = 'module.focus.remaining';

  /// Clave para duración de sesión de foco (en minutos)
  static const String focusDuration = 'module.focus.duration';

  /// Clave para lista de favoritos de foco
  static const String focusFavorites = 'module.focus.favorites';

  /// Clave para gasto financiero total
  static const String financeSpent = 'module.finance.spent';

  /// Clave para vasos de agua consumidos (salud)
  static const String healthWater = 'module.health.water';

  /// Clave para pasos caminados (salud)
  static const String healthSteps = 'module.health.steps';

  /// Clave para agenda confirmada
  static const String agendaConfirmed = 'module.agenda.confirmed';

  /// Clave para activar modo oscuro automático
  static const String autoNight = 'module.auto.night';

  /// Clave para automatización de reuniones
  static const String autoMeeting = 'module.auto.meeting';

  /// Clave para automatización de presupuesto
  static const String autoBudget = 'module.auto.budget';

  /// Clave para idioma de la interfaz ('en', 'es', 'de', 'zh')
  static const String locale = 'settings.locale';
}
