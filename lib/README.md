## 📁 Estructura de Capas de la Aplicación

Esta carpeta contiene la lógica de la aplicación M3E Demo organizada en capas siguiendo el patrón **MVVM + Service Locator**.

### 🗂️ Contenido

```
lib/
├── main.dart                          # 🎯 Punto de entrada (limpio y simple)
├── service_locator.dart              # 🔧 Inyección de dependencias (GetIt)
│
├── models/                           # 📦 Tipos y Constantes
│   └── app_models.dart              # Enums, constantes, extensiones
│
├── services/                         # 🔌 Servicios de Negocio
│   └── preferences_service.dart     # Persistencia y preferencias
│
├── viewmodels/                       # 🧠 Lógica de Negocio
│   └── video_player_viewmodel.dart  # ViewModel del reproductor
│
├── widgets/                          # 🎨 Componentes Reutilizables
│   └── reusable_widgets.dart        # ModuleCard, CounterWidget, etc.
│
├── screens/                          # 📱 Pantallas Principales (futuro)
│
└── utils/                            # 🛠️ Utilidades (futuro)
```

---

## 🎯 main.dart

**Responsabilidad:** Punto de entrada limpio.

**Contenido:**
1. Configuración de `Animate.defaultDuration`
2. Inicialización de `setupServiceLocator()` 
3. Creación de app principal

**Patrón:** Limpio, sin lógica de negocio

---

## 🔧 service_locator.dart

**Responsabilidad:** Gestionar inyección de dependencias.

**Función principal:**
- `setupServiceLocator()` - Registra todos los Singletons
- Getters convenientes (`preferencesService`, `videoPlayerViewModel`)

**Uso en main.dart:**
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();  // ⚠️ OBLIGATORIO
  runApp(const M3EDemoApp());
}
```

---

## 📦 models/app_models.dart

**Responsabilidad:** Definir tipos compartidos.

**Contenido:**
- `DemoFontPack` enum - Packs de fuentes
- `DemoColorPack` enum - Packs de colores
- `PrefKeys` class - Claves de persistencia
- Extensiones `.label`, `.seed`

**Uso:**
```dart
import 'models/app_models.dart';

final colorSeed = DemoColorPack.oceanNeon.seed;
final fontLabel = DemoFontPack.spaceGrotesk.label;
```

---

## 🔌 services/preferences_service.dart

**Responsabilidad:** Encapsular acceso a SharedPreferences.

**Métodos:**
- `initialize()` - Inicializar (llamar en main)
- Getters/Setters para: tema, fuentes, colores, módulos
- `clearAll()` - Limpiar todo

**Patrón:** Interfaz tipada, fácil de mockear

**Uso:**
```dart
final prefs = preferencesService;
await prefs.setThemeMode('dark');
print(prefs.getThemeMode());
```

---

## 🧠 viewmodels/video_player_viewmodel.dart

**Responsabilidad:** Gestionar lógica del reproductor de video.

**Extiende:** `ChangeNotifier` (para reactividad)

**Métodos:**
- `enable()` - Inicializar controlador
- `playPause()` - Reproducir/pausar
- `toggleMute()` - Silenciar/dessilenciar
- `restart()` - Reiniciar video
- `openFullscreen()` - Pantalla completa

**Patrón:** Lógica desacoplada de UI, fácil de testear

---

## 🎨 widgets/reusable_widgets.dart

**Responsabilidad:** Proporcionar componentes reutilizables.

**Componentes:**
1. **ModuleCard** - Tarjeta de módulo con animaciones
2. **CounterWidget** - Contador con botones
3. **ControlButton** - Botón de control con icono
4. **ValueDisplay** - Valor grande con descripción

**Patrón:** Props bien documentados, reutilizables en múltiples contextos

---

## 📖 Cómo Navegar el Código

### Para agregar una nueva pantalla:
1. Crear archivo en `screens/mi_pantalla.dart`
2. Importar ViewModels de `viewmodels/`
3. Usar componentes de `widgets/`
4. Acceder a servicios vía `service_locator.dart`

### Para cambiar la persistencia:
1. Modificar `services/preferences_service.dart`
2. No tocar el resto del código (desacoplado)

### Para reutilizar un widget:
1. Importar de `widgets/reusable_widgets.dart`
2. Usar en cualquier pantalla/widget

---

## 🔗 Documentación Completa

Ver [ARCHITECTURE.md](../ARCHITECTURE.md) para:
- Patrón MVVM detallado
- Ejemplos de uso completos
- Cómo crear ViewModels/Servicios nuevos
- Principios de diseño implementados

---

## ✨ Beneficios de esta Arquitectura

| Beneficio | Cómo se logra |
|-----------|--------------|
| **Reutilizable** | Componentes en `widgets/`, ViewModels en `viewmodels/` |
| **Mantenible** | Responsabilidades claras, separación de concerns |
| **Testeable** | ViewModels sin UI, Servicios inyectables |
| **Escalable** | Fácil agregar nuevas capas/componentes |
| **Documentado** | Comentarios Dartdoc en cada clase |

---

## 📋 Tareas Pendientes

- [ ] Crear pantallas en `screens/`
- [ ] Crear utilidades en `utils/`
- [ ] Agregar más ViewModels según necesidades
- [ ] Tests unitarios para ViewModels
- [ ] Tests de widgets para componentes reutilizables
- [ ] Integración con CI/CD

---

**Última actualización**: 19 de abril de 2026
