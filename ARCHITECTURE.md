## Arquitectura M3E Demo - Patrón MVVM + Service Locator

Esta app implementa un patrón arquitectónico moderno y escalable basado en **MVVM + Inyección de Dependencias (GetIt)** para facilitar la reutilización de código y el mantenimiento.

---

## 🏗️ Estructura de Carpetas

```
lib/
├── main.dart                          # Punto de entrada (limpio)
├── service_locator.dart              # Configuración de GetIt (inyección)
├── models/
│   └── app_models.dart               # Enums, constantes, extensiones
├── services/
│   └── preferences_service.dart      # Servicio de persistencia
├── viewmodels/
│   └── video_player_viewmodel.dart   # ViewModel del reproductor
├── widgets/
│   └── reusable_widgets.dart         # Componentes reutilizables
├── screens/
│   └── [Pantallas principales]       # A implementar
└── utils/
    └── [Utilidades]                  # A implementar
```

---

## 📋 Capas y Responsabilidades

### 1. **Models** (`lib/models/app_models.dart`)
Define tipos y constantes compartidas.

**Contenido:**
- `DemoFontPack` enum - Packs de fuentes disponibles
- `DemoColorPack` enum - Packs de colores disponibles  
- `PrefKeys` class - Claves de preferencias (constantes)
- Extensiones: `DemoFontPackLabel`, `DemoColorPackLabel`

**Uso:**
```dart
import 'models/app_models.dart';

print(DemoColorPack.oceanNeon.label);  // "Ocean Neon"
print(DemoColorPack.oceanNeon.seed);   // Color(0xFF0A7B83)
```

---

### 2. **Services** (`lib/services/preferences_service.dart`)
Encapsula acceso a datos persistentes. Proporciona una interfaz limpia.

**Métodos:**
- `initialize()` - Inicializa SharedPreferences (llamar en main)
- `getThemeMode()` / `setThemeMode()` - Tema de la app
- `getFontPack()` / `setFontPack()` - Pack de fuentes
- `getColorPack()` / `setColorPack()` - Pack de colores
- Métodos específicos por módulo (Routines, Focus, Finance, Health, etc.)

**Uso:**
```dart
import 'services/preferences_service.dart';

final prefs = AppPreferencesService();
await prefs.initialize();  // Solo una vez en main()

// Acceder
final theme = prefs.getThemeMode();
final font = prefs.getFontPack();

// Guardar
await prefs.setThemeMode('dark');
await prefs.setFontPack(DemoFontPack.spaceGrotesk);
```

**Ventajas:**
- Cambios en SharedPreferences se hacen en un solo lugar
- Fácil de testear (mockear)
- Interfaz consistente

---

### 3. **ViewModels** (`lib/viewmodels/video_player_viewmodel.dart`)
Gestiona lógica de negocio y estado. Extiende `ChangeNotifier`.

**VideoPlayerViewModel:**
- `enable()` - Inicializa controlador YouTube
- `playPause()` - Alterna play/pause
- `toggleMute()` - Silencia/dessilencia
- `restart()` - Reinicia video
- `openFullscreen()` - Pantalla completa

**Getters:**
- `ready` - Si está inicializado
- `playing` - Si está reproduciendo
- `muted` - Si está silenciado
- `controller` - Controlador YouTube
- `videoId` - ID del video

**Uso:**
```dart
import 'viewmodels/video_player_viewmodel.dart';

final vm = VideoPlayerViewModel();
vm.enable();           // Inicializar
vm.playPause();        // Reproducir/pausar
vm.toggleMute();       // Silenciar

// Escuchar cambios
vm.addListener(() => print('Estado cambió'));

// Limpiar
vm.removeListener(callback);
vm.dispose();
```

---

### 4. **Service Locator** (`lib/service_locator.dart`)
Configura inyección de dependencias con GetIt. **Llamar en main().**

**Dependencias Registradas (Singletons):**
- `AppPreferencesService` - Accesible vía `preferencesService`
- `VideoPlayerViewModel` - Accesible vía `videoPlayerViewModel`

**Uso en main():**
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // ⚠️ OBLIGATORIO: Inicializar service locator
  await setupServiceLocator();
  
  runApp(const M3EDemoApp());
}
```

**Acceso en cualquier parte del código:**
```dart
import 'service_locator.dart';

// Vía getter conveniente
final prefs = preferencesService;
final videoVM = videoPlayerViewModel;

// O vía getIt directamente
final prefs = getIt<AppPreferencesService>();
final videoVM = getIt<VideoPlayerViewModel>();
```

---

### 5. **Widgets Reutilizables** (`lib/widgets/reusable_widgets.dart`)
Componentes UI consistentes que se reutilizan en múltiples pantallas.

**ModuleCard**
```dart
ModuleCard(
  title: 'Focus',
  icon: Icons.focus_center,
  backgroundColor: Colors.blue,
  child: Text('Contenido...'),
  onTap: () { ... },
  hasAnimation: true,
)
```

**CounterWidget**
```dart
CounterWidget(
  value: 42,
  label: 'Pasos',
  color: Colors.green,
  onIncrement: () { ... },
  onDecrement: () { ... },
)
```

**ControlButton**
```dart
ControlButton(
  icon: Icons.play_arrow,
  label: 'Play',
  onPressed: () { ... },
  color: Colors.blue,
)
```

**ValueDisplay**
```dart
ValueDisplay(
  value: '42',
  label: 'Horas',
  icon: Icons.schedule,
  valueColor: Colors.purple,
)
```

---

## 🔄 Flujo de Datos (MVVM)

```
UI (Widget)
    ↓
ChangeNotifier.addListener()
    ↓
ViewModel (ChangeNotifier)
    ↓ [notifyListeners]
setState() → Reconstruir UI
    ↑
    └─ Lee datos del ViewModel
```

**Ejemplo:**
```dart
class _ShowcaseScreenState extends State<_ShowcaseScreen> {
  late VideoPlayerViewModel _videoVM;

  @override
  void initState() {
    super.initState();
    _videoVM = videoPlayerViewModel;  // Obtener del service locator
    _videoVM.addListener(_onStateChange);
  }

  void _onStateChange() => setState(() {});  // Reconstruir cuando cambie

  @override
  void dispose() {
    _videoVM.removeListener(_onStateChange);  // Limpiar
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Leer del ViewModel
        Text(_videoVM.playing ? 'Reproduciendo' : 'Pausado'),
        
        // Ejecutar método del ViewModel
        IconButton(
          icon: const Icon(Icons.play_arrow),
          onPressed: _videoVM.playPause,
        ),
      ],
    );
  }
}
```

---

## 🚀 Cómo Agregar un Nuevo ViewModel

### Paso 1: Crear el archivo
`lib/viewmodels/mi_viewmodel.dart`:
```dart
import 'package:flutter/foundation.dart';

/// ViewModel para gestionar lógica de [MiFeature].
/// 
/// Ejemplo de uso:
/// ```dart
/// final vm = MiViewModel();
/// vm.cargarDatos();
/// ```
class MiViewModel extends ChangeNotifier {
  bool _cargando = false;
  String _datos = '';

  bool get cargando => _cargando;
  String get datos => _datos;

  Future<void> cargarDatos() async {
    _cargando = true;
    notifyListeners();

    try {
      // Hacer algo...
      _datos = 'Resultado';
    } catch (e) {
      _datos = 'Error: $e';
    } finally {
      _cargando = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
```

### Paso 2: Registrar en service_locator
`lib/service_locator.dart`:
```dart
Future<void> setupServiceLocator() async {
  // ... código existente ...
  
  getIt.registerSingleton<MiViewModel>(
    MiViewModel(),
  );
}

/// Acceso conveniente
MiViewModel get miViewmodel => getIt<MiViewModel>();
```

### Paso 3: Usar en una pantalla
```dart
import 'service_locator.dart';

class _MiScreenState extends State<MiScreen> {
  late MiViewModel _vm;

  @override
  void initState() {
    super.initState();
    _vm = miViewmodel;
    _vm.addListener(_onVMChange);
  }

  void _onVMChange() => setState(() {});

  @override
  void dispose() {
    _vm.removeListener(_onVMChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _vm.cargando
        ? const CircularProgressIndicator()
        : Text(_vm.datos);
  }
}
```

---

## 🛠️ Cómo Agregar un Nuevo Servicio

### Paso 1: Crear archivo
`lib/services/mi_servicio.dart`:
```dart
/// Servicio para [funcionalidad].
/// 
/// Se registra como Singleton en setupServiceLocator().
class MiServicio {
  Future<void> initialize() async {
    // Inicialización
  }

  Future<String> obtenerDatos() async {
    return 'datos';
  }
}
```

### Paso 2: Registrar en service_locator
```dart
Future<void> setupServiceLocator() async {
  final miServicio = MiServicio();
  await miServicio.initialize();
  
  getIt.registerSingleton<MiServicio>(miServicio);
}

MiServicio get miServicio => getIt<MiServicio>();
```

---

## 🎨 Cómo Reutilizar Widgets

Todos los widgets reutilizables están en `lib/widgets/reusable_widgets.dart`.

### Importar:
```dart
import 'widgets/reusable_widgets.dart';
```

### Usar en tu pantalla:
```dart
@override
Widget build(BuildContext context) {
  return ModuleCard(
    title: 'Mi Módulo',
    icon: Icons.star,
    backgroundColor: Colors.amber,
    child: CounterWidget(
      value: 42,
      label: 'Items',
    ),
  );
}
```

---

## 📚 Principios Implementados

| Principio | Implementación |
|-----------|----------------|
| **Single Responsibility** | Cada clase tiene una responsabilidad clara |
| **Dependency Injection** | Servicios inyectados via GetIt |
| **Separation of Concerns** | Capas: Models, Services, ViewModels, Widgets |
| **DRY** | Componentes reutilizables, constantes centralizadas |
| **Testability** | ViewModels desacoplados de UI, Servicios mockeables |
| **Scalability** | Fácil agregar nuevos ViewModels, Servicios, Widgets |

---

## 📝 Documentación en Código

Todos los archivos incluyen **comentarios Dartdoc** (`///`):

```dart
/// Servicio centralizado para acceso a preferencias.
///
/// Proporciona métodos tipados para guardar y recuperar configuraciones.
///
/// Uso:
/// ```dart
/// final prefs = preferencesService;
/// await prefs.setThemeMode('dark');
/// ```
class AppPreferencesService {
  /// Obtiene el tema guardado ('light', 'dark', o 'system').
  String getThemeMode() => _prefs.getString(PrefKeys.themeMode) ?? 'system';
}
```

Genera documentación automática con:
```bash
dart doc
```

---

## 🔗 Archivo de Configuración

`pubspec.yaml`:
```yaml
dependencies:
  flutter:
    sdk: flutter
  get_it: ^8.0.0
  shared_preferences: ^2.5.3
  youtube_player_iframe: ^5.2.2
  # ... otros paquetes
```

---

## ✅ Checklist para Nuevas Features

- [ ] Crear modelo/enum en `lib/models/`
- [ ] Crear servicio en `lib/services/` (si aplica)
- [ ] Crear ViewModel en `lib/viewmodels/`
- [ ] Registrar en `lib/service_locator.dart`
- [ ] Crear componentes reutilizables en `lib/widgets/`
- [ ] Crear pantalla en `lib/screens/`
- [ ] Documentar con comentarios Dartdoc
- [ ] Ejecutar `flutter analyze` ✅ Sin errores
- [ ] Ejecutar `flutter test` (agregar tests)

---

## 📖 Recursos

- **GetIt**: https://pub.dev/packages/get_it
- **ChangeNotifier**: https://api.flutter.dev/flutter/foundation/ChangeNotifier-class.html
- **Dart Documentation**: https://dart.dev/guides/language/effective-dart

---

**Última actualización**: 19 de abril de 2026  
**Mantenedor**: M3E Demo Team
