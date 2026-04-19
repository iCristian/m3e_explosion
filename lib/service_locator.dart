/// Configuración centralizada del service locator (GetIt) para inyección de dependencias.
///
/// Este archivo gestiona toda la creación e inyección de dependencias de la app,
/// permitiendo que los widgets accedan a servicios y ViewModels de forma limpia.

import 'package:get_it/get_it.dart';

import 'services/preferences_service.dart';
import 'viewmodels/video_player_viewmodel.dart';

/// Instancia global del service locator.
final getIt = GetIt.instance;

/// Inicializa todas las dependencias de la aplicación.
///
/// Esta función debe llamarse una única vez en `main()` antes de runApp().
///
/// Registra:
/// - [AppPreferencesService]: Servicio de preferencias persistentes
/// - [VideoPlayerViewModel]: ViewModel del reproductor de YouTube
///
/// Ejemplo:
/// ```dart
/// void main() async {
///   WidgetsFlutterBinding.ensureInitialized();
///   await setupServiceLocator();
///   runApp(const M3EDemoApp());
/// }
/// ```
Future<void> setupServiceLocator() async {
  // SERVICIOS
  // Se crea una sola instancia compartida (Singleton)

  /// Servicio de preferencias persistentes.
  /// Se inicializa antes de registrar.
  final prefsService = AppPreferencesService();
  await prefsService.initialize();
  getIt.registerSingleton<AppPreferencesService>(prefsService);

  // VIEWMODELS
  // Se registran como Singletons (reutilizables en toda la app)

  /// ViewModel del reproductor de YouTube.
  /// Se crea una sola instancia que se comparte.
  getIt.registerSingleton<VideoPlayerViewModel>(
    VideoPlayerViewModel(),
  );
}

/// Acceso conveniente al servicio de preferencias.
///
/// Equivalente a `getIt<AppPreferencesService>()`.
AppPreferencesService get preferencesService =>
    getIt<AppPreferencesService>();

/// Acceso conveniente al ViewModel del reproductor de video.
///
/// Equivalente a `getIt<VideoPlayerViewModel>()`.
VideoPlayerViewModel get videoPlayerViewModel =>
    getIt<VideoPlayerViewModel>();
