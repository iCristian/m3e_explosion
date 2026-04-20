/// Servicio para gestionar preferencias persistentes de la app.
///
/// Esta clase proporciona una interfaz limpia para guardar y restaurar
/// configuraciones del usuario, facilitando el mantenimiento y testeo.
/// Todos los datos se persisten en SharedPreferences.

import 'package:shared_preferences/shared_preferences.dart';

import '../models/app_models.dart';

/// Servicio centralizado para acceso a preferencias de la aplicación.
///
/// Proporciona métodos tipados para guardar y recuperar configuraciones,
/// evitando referencias directas a SharedPreferences en toda la app.
///
/// Uso:
/// ```dart
/// final prefs = AppPreferencesService();
/// await prefs.setThemeMode(ThemeMode.dark);
/// final theme = await prefs.getThemeMode();
/// ```
class AppPreferencesService {
  /// Instancia compartida de SharedPreferences.
  late SharedPreferences _prefs;

  /// Inicializa el servicio. Debe llamarse una sola vez en main().
  ///
  /// Throws: [Exception] si no se puede inicializar SharedPreferences.
  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // TEMA

  /// Obtiene el modo de tema guardado ('light', 'dark', o 'system').
  ///
  /// Retorna 'system' por defecto si no hay valor guardado.
  String getThemeMode() {
    return _prefs.getString(PrefKeys.themeMode) ?? 'system';
  }

  /// Guarda el modo de tema seleccionado.
  Future<void> setThemeMode(String mode) {
    return _prefs.setString(PrefKeys.themeMode, mode);
  }

  // FUENTES

  /// Obtiene el pack de fuentes seleccionado.
  ///
  /// Retorna [DemoFontPack.inter] por defecto.
  DemoFontPack getFontPack() {
    final value = _prefs.getString(PrefKeys.fontPack) ?? 'inter';
    return DemoFontPack.values.firstWhere(
      (e) => e.name == value,
      orElse: () => DemoFontPack.inter,
    );
  }

  /// Guarda el pack de fuentes seleccionado.
  Future<void> setFontPack(DemoFontPack pack) {
    return _prefs.setString(PrefKeys.fontPack, pack.name);
  }

  // COLORES

  /// Obtiene el pack de colores seleccionado.
  ///
  /// Retorna [DemoColorPack.ultraViolet] por defecto.
  DemoColorPack getColorPack() {
    final value = _prefs.getString(PrefKeys.colorPack) ?? 'ultraViolet';
    return DemoColorPack.values.firstWhere(
      (e) => e.name == value,
      orElse: () => DemoColorPack.ultraViolet,
    );
  }

  /// Guarda el pack de colores seleccionado.
  Future<void> setColorPack(DemoColorPack pack) {
    return _prefs.setString(PrefKeys.colorPack, pack.name);
  }

  // MÓDULO: ROUTINES

  /// Obtiene cantidad de rutinas completadas.
  int getRoutinesDone() => _prefs.getInt(PrefKeys.routinesDone) ?? 0;

  /// Incrementa el contador de rutinas completadas.
  Future<void> incrementRoutinesDone() {
    return _prefs.setInt(PrefKeys.routinesDone, getRoutinesDone() + 1);
  }

  /// Resetea el contador de rutinas.
  Future<void> resetRoutinesDone() {
    return _prefs.remove(PrefKeys.routinesDone);
  }

  // MÓDULO: FOCUS

  /// Obtiene minutos restantes de la sesión de foco.
  int getFocusRemaining() => _prefs.getInt(PrefKeys.focusRemaining) ?? 25;

  /// Establece minutos restantes de foco.
  Future<void> setFocusRemaining(int minutes) {
    return _prefs.setInt(PrefKeys.focusRemaining, minutes);
  }

  /// Obtiene duración de sesión de foco (en minutos).
  int getFocusDuration() => _prefs.getInt(PrefKeys.focusDuration) ?? 25;

  /// Establece duración de sesión de foco.
  Future<void> setFocusDuration(int minutes) {
    return _prefs.setInt(PrefKeys.focusDuration, minutes);
  }

  /// Obtiene lista de favoritos de foco.
  List<String> getFocusFavorites() =>
      _prefs.getStringList(PrefKeys.focusFavorites) ?? [];

  /// Guarda lista de favoritos de foco.
  Future<void> setFocusFavorites(List<String> favorites) {
    return _prefs.setStringList(PrefKeys.focusFavorites, favorites);
  }

  // MÓDULO: FINANCE

  /// Obtiene gasto financiero total acumulado.
  double getFinanceSpent() {
    return _prefs.getDouble(PrefKeys.financeSpent) ?? 0.0;
  }

  /// Incrementa gasto financiero.
  Future<void> addFinanceSpent(double amount) {
    return _prefs.setDouble(
      PrefKeys.financeSpent,
      getFinanceSpent() + amount,
    );
  }

  /// Resetea gasto financiero.
  Future<void> resetFinanceSpent() {
    return _prefs.remove(PrefKeys.financeSpent);
  }

  // MÓDULO: HEALTH

  /// Obtiene vasos de agua consumidos.
  int getHealthWater() => _prefs.getInt(PrefKeys.healthWater) ?? 0;

  /// Incrementa vasos de agua consumidos.
  Future<void> incrementHealthWater() {
    return _prefs.setInt(PrefKeys.healthWater, getHealthWater() + 1);
  }

  /// Resetea contador de agua.
  Future<void> resetHealthWater() {
    return _prefs.remove(PrefKeys.healthWater);
  }

  /// Obtiene pasos caminados.
  int getHealthSteps() => _prefs.getInt(PrefKeys.healthSteps) ?? 0;

  /// Establece pasos caminados.
  Future<void> setHealthSteps(int steps) {
    return _prefs.setInt(PrefKeys.healthSteps, steps);
  }

  // MÓDULO: AGENDA

  /// Obtiene lista de agenda confirmada.
  List<String> getAgendaConfirmed() =>
      _prefs.getStringList(PrefKeys.agendaConfirmed) ?? [];

  /// Guarda lista de agenda confirmada.
  Future<void> setAgendaConfirmed(List<String> items) {
    return _prefs.setStringList(PrefKeys.agendaConfirmed, items);
  }

  // MÓDULO: AUTOMATION

  /// Obtiene estado de modo oscuro automático.
  bool getAutoNight() => _prefs.getBool(PrefKeys.autoNight) ?? false;

  /// Establece modo oscuro automático.
  Future<void> setAutoNight(bool enabled) {
    return _prefs.setBool(PrefKeys.autoNight, enabled);
  }

  /// Obtiene estado de automatización de reuniones.
  bool getAutoMeeting() => _prefs.getBool(PrefKeys.autoMeeting) ?? false;

  /// Establece automatización de reuniones.
  Future<void> setAutoMeeting(bool enabled) {
    return _prefs.setBool(PrefKeys.autoMeeting, enabled);
  }

  /// Obtiene estado de automatización de presupuesto.
  bool getAutoBudget() => _prefs.getBool(PrefKeys.autoBudget) ?? false;

  /// Establece automatización de presupuesto.
  Future<void> setAutoBudget(bool enabled) {
    return _prefs.setBool(PrefKeys.autoBudget, enabled);
  }

  // IDIOMA

  /// Obtiene el código de idioma guardado ('en', 'es', 'de', 'zh').
  /// Retorna null si no hay valor guardado (auto-detectar).
  String? getLocale() {
    return _prefs.getString(PrefKeys.locale);
  }

  /// Guarda el código de idioma seleccionado.
  Future<void> setLocale(String languageCode) {
    return _prefs.setString(PrefKeys.locale, languageCode);
  }

  /// Limpia todas las preferencias.
  Future<void> clearAll() {
    return _prefs.clear();
  }
}
