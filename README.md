# Material 3 Expressive Explosion

Aplicacion Flutter de demostracion avanzada para Material 3 Expressive, con arquitectura MVVM + Service Locator, componentes reutilizables y enfoque de calidad para evolucionar el proyecto en equipo.

## Estado Del Proyecto

- Nombre de paquete: `m3e_explosion`
- Plataforma: Android, iOS, Web
- Arquitectura activa: MVVM + GetIt
- Estado de calidad esperado:
	- `flutter analyze` sin errores
	- `flutter test` pasando

## Caracteristicas Clave

- UI Expressive con componentes M3E y `flutter_m3shapes_extended`
- Navegacion principal adaptable a movil y escritorio
- Personalizacion de tema, tipografia y paleta de color
- Modulos de showcase (routines, focus, finance, health, agenda, automation)
- Integracion de video con Vimeo via `webview_flutter` y fallback externo

## Arquitectura Tecnica

El proyecto sigue un flujo MVVM desacoplado:

1. UI (widgets/pantallas) renderiza estado y despacha acciones.
2. ViewModel (`ChangeNotifier`) centraliza estado y reglas de negocio.
3. Servicios encapsulan persistencia y recursos externos.
4. Inyeccion de dependencias via GetIt (`service_locator.dart`).

### Estructura De Carpetas

```text
lib/
	main.dart
	service_locator.dart
	models/
		app_models.dart
	services/
		preferences_service.dart
	viewmodels/
		video_player_viewmodel.dart
	widgets/
		reusable_widgets.dart
	screens/
	utils/
```

### Convenciones De Desarrollo

- Mantener `main.dart` enfocado en composicion, no en logica de negocio.
- Toda logica de estado nuevo va a `viewmodels/`.
- Todo acceso a almacenamiento o SDK externo va a `services/`.
- Reutilizar componentes de `widgets/reusable_widgets.dart` antes de crear nuevos.

## Dependencias Principales

- `get_it`: inyeccion de dependencias
- `shared_preferences`: persistencia local
- `webview_flutter`: video embebido
- `url_launcher`: fallback externo del video
- `m3e_collection`, `m3e_core`, `m3e_buttons`, `flutter_m3shapes_extended`: sistema UI Expressive
- `flutter_animate`: motion
- `google_fonts`: tipografias

## Setup Local

### Requisitos

- Flutter SDK compatible con `sdk: ^3.11.3`
- Xcode (iOS) y Android SDK (Android)

### Instalacion

```bash
git clone https://github.com/iCristian/m3e_explosion.git
cd m3e_explosion
flutter pub get
```

### Configuracion Local De Datos Sensibles

El repositorio es publico y usa valores genericos por seguridad.

1. Crear archivo local:

```bash
cp .env.example .env.local
```

2. Ajustar identificadores en entorno local (no versionar):
	 - Android: `android/app/build.gradle.kts` (`applicationId`)
	 - iOS: `ios/Runner.xcworkspace` (`Bundle Identifier`)

3. Opcional: ejecutar asistente local:

```bash
chmod +x setup_local.sh
./setup_local.sh
```

## Ejecucion Y Build

### Desarrollo

```bash
flutter run
```

### Android

```bash
flutter build apk
flutter build appbundle
```

Salida App Bundle esperada:

```text
build/app/outputs/bundle/release/app-release.aab
```

### iOS

```bash
flutter build ios
```

### Web

```bash
flutter build web --wasm
```

## Calidad De Codigo

### Analisis Estatico

```bash
flutter analyze
```

### Tests

```bash
flutter test
```

Test base de smoke UI:

- `test/widget_test.dart`

## Seguridad Y Publicacion

### Nunca Versionar

- `.env.local`, `.env`
- certificados y llaves (`*.jks`, `*.keystore`, `*.p8`, `*.mobileprovision`)
- credenciales (`credentials.json`, `service-account-key.json`)
- configuraciones IDE locales sensibles

### Checklist Rapido Antes De Push

```bash
git status
git diff --cached
git check-ignore -v .env.local
```

Verificacion simple de secretos:

```bash
git grep -i "password\|secret\|api[_.-]*key\|token" -- "*.dart" "*.gradle" "*.xml" "*.plist"
```

## Guia De Mantenimiento

### Agregar Un Nuevo ViewModel

1. Crear archivo en `lib/viewmodels/`.
2. Registrar singleton en `lib/service_locator.dart`.
3. Inyectar con getter o `getIt<T>()`.
4. Suscribir y limpiar listeners en pantalla.

### Agregar Un Nuevo Servicio

1. Crear archivo en `lib/services/`.
2. Encapsular completamente el acceso externo.
3. Registrar en `setupServiceLocator()`.
4. Consumir desde ViewModels, no directo en UI.

## Troubleshooting

### Error De Build Android

```bash
cd android && ./gradlew clean && cd ..
flutter clean
flutter pub get
flutter run
```

### Error De Build iOS

```bash
cd ios && rm -rf Pods Podfile.lock && cd ..
flutter clean
flutter pub get
flutter run
```

### Video No Reproduce Embebido

- Revisar conectividad.
- Probar boton de abrir externo (fallback Vimeo).
- Validar restricciones del dispositivo/navegador.

## Contribucion

1. Crear branch de feature.
2. Mantener cambios acotados por modulo.
3. Ejecutar `flutter analyze` y `flutter test` antes de PR.
4. Documentar decisiones tecnicas en el PR.

## Licencia

Este proyecto usa licencia MIT.
