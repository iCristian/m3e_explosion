# Material 3 Expressive Explosion

Aplicación Flutter de demostración avanzada para Material 3 Expressive, con arquitectura MVVM + Service Locator, componentes reutilizables y enfoque de calidad para evolucionar el proyecto en equipo.

## 🎯 Estado Del Proyecto

- **Nombre de paquete**: `m3e_explosion`
- **Plataforma**: Android, iOS, Web
- **Arquitectura activa**: MVVM + GetIt
- **Soporte multiidioma**: EN, ES, DE, ZH
- **Estado de calidad esperado**:
	- `flutter analyze` sin errores
	- `flutter test` pasando

## 📋 Cambios Recientes (v1.1.0)

- ✨ **Navegación Mejorada**: Unificada a usar `_CompactBottomNav` colorida y animada en todas las resoluciones. Ahora en pantallas grandes se muestra con etiquetas completas mientras que en móvil se usan etiquetas cortas.
- 🎨 **Diseño M3E en Secciones Clave**: Rediseño de "Créditos y Código Fuente" con gradientes, formas geométricas y botones M3E en `showcase_screen.part.dart` y `libraries_screen.part.dart`.
- 🐛 **Fixes en Shapes**: Corrección de parámetros requeridos en `M3EContainer` para `softBurst`, `flower` y `boom`.
- 🌍 **Auditoría de i18n**: Identificación de textos hardcodeados en español para migración a multiidioma completo (EN, ES, DE, ZH).

## ✨ Características Clave

- 🎨 **UI Expressive** con componentes M3E y `flutter_m3shapes_extended` — formas geométricas audaces
- 📱 **Navegación Adaptable** con `_CompactBottomNav` colorida (móvil y escritorio)
- 🎭 **Personalización de Tema** — color, tipografía, paleta y modo claro/oscuro en vivo
- 🌍 **Multiidioma** — Soporta EN, ES, DE, ZH con fallback automático
- 📦 **Modulos Showcase** — Routines, Focus, Finance, Health, Agenda, Automation
- 🎥 **Integración de Video** — Vimeo embebido con webview + fallback externo

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

## 🌍 Localización (i18n)

El proyecto soporta **inglés (EN), español (ES), alemán (DE) y chino simplificado (ZH)** usando un sistema map-based en `lib/l10n/app_localizations.dart`.

### Agregar Un Nuevo String Localizado

1. **Abre** `lib/l10n/app_localizations.dart` y localiza la estructura `_strings`
2. **Agrega clave** en inglés primero:
   ```dart
   'my_new_key': 'English text',
   ```
3. **Replica en otros idiomas**:
   ```dart
   'es': {'my_new_key': 'Texto en español'},
   'de': {'my_new_key': 'Deutscher Text'},
   'zh': {'my_new_key': '中文文本'},
   ```
4. **Usa en UI**:
   ```dart
   final l10n = AppLocalizations.of(context);
   Text(l10n.myNewKey)  // Automáticamente toma valor según locale
   ```

### Convención De Nombres De Claves

- `nav_*` — Etiquetas de navegación
- `studio_*` — Configuración del Studio M3E
- `shapes_*` — Pantalla de shapes
- `showcase_*` — Pantalla de showcase
- `video_*` — Controles de video

### Fallback De Idioma

Si el dispositivo tiene locale no soportado, automáticamente cae a **inglés (EN)**.

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

## 🔒 Política de Privacidad / Privacy Policy

**Última actualización / Last updated:** 1 de mayo de 2026 / May 1, 2026

### Español

**M3E Explosion** es una aplicación de demostración de código abierto desarrollada por Cristian Carreño León ("el desarrollador"). Esta política describe cómo la aplicación maneja la información del usuario.

#### Recopilación de datos

Esta aplicación **no recopila, almacena ni transmite datos personales** de ningún tipo. En particular:

- **No se requiere registro** ni creación de cuenta.
- **No se recopilan datos de ubicación**, contactos, cámara, micrófono ni archivos del dispositivo.
- **No se utilizan servicios de analítica** (Google Analytics, Firebase Analytics, ni similares).
- **No se muestran anuncios** ni se integran redes publicitarias.
- **No se comparten datos con terceros.**

#### Almacenamiento local

La aplicación utiliza `shared_preferences` para guardar preferencias de interfaz (como el tema de color y el idioma seleccionado) **exclusivamente en el dispositivo del usuario**. Estos datos nunca se transmiten a servidores externos.

#### Contenido de terceros

La aplicación puede reproducir videos educativos embebidos desde **Vimeo** mediante WebView. Al reproducir un video, se aplican las políticas de privacidad de Vimeo ([vimeo.com/privacy](https://vimeo.com/privacy)). La aplicación no envía datos del usuario a Vimeo.

#### Permisos

La aplicación solo solicita acceso a **Internet** para cargar contenido de video. No solicita permisos sensibles del dispositivo.

#### Cambios en esta política

Si esta política se actualiza, los cambios se publicarán en este mismo archivo del repositorio público.

#### Contacto

Para consultas sobre privacidad:
- **Email:** icristian.mac@gmail.com
- **GitHub:** [github.com/iCristian/m3e_explosion](https://github.com/iCristian/m3e_explosion)

---

### English

**M3E Explosion** is an open-source demo application developed by Cristian Carreño León ("the developer"). This policy describes how the application handles user information.

#### Data Collection

This application **does not collect, store, or transmit any personal data**. Specifically:

- **No registration** or account creation is required.
- **No location data**, contacts, camera, microphone, or device files are accessed.
- **No analytics services** (Google Analytics, Firebase Analytics, or similar) are used.
- **No advertisements** are displayed and no ad networks are integrated.
- **No data is shared with third parties.**

#### Local Storage

The application uses `shared_preferences` to save interface preferences (such as color theme and selected language) **exclusively on the user's device**. This data is never transmitted to external servers.

#### Third-Party Content

The application may play embedded educational videos from **Vimeo** via WebView. When playing a video, Vimeo's privacy policies apply ([vimeo.com/privacy](https://vimeo.com/privacy)). The application does not send user data to Vimeo.

#### Permissions

The application only requests **Internet** access to load video content. It does not request sensitive device permissions.

#### Changes to This Policy

If this policy is updated, changes will be published in this file within the public repository.

#### Contact

For privacy inquiries:
- **Email:** icristian.mac@gmail.com
- **GitHub:** [github.com/iCristian/m3e_explosion](https://github.com/iCristian/m3e_explosion)

---

## 📜 Licencia

Este proyecto está licenciado bajo la **Licencia MIT**.

### Términos Principales

- ✅ **Permitido**: Uso comercial, copia, distribución, modificación
- ⚠️ **Condición**: Incluir aviso de licencia y copyright en distribuciones
- ❌ **No permitido**: Responsabilidad del autor ni garantía de uso

Para más detalles, consulta el archivo `LICENSE` en la raíz del repositorio o visita [opensource.org/licenses/MIT](https://opensource.org/licenses/MIT).

## 👤 Créditos

**Proyecto Creado por**: [iCristian](https://github.com/iCristian)

### Contribuidores y Inspiración

- **Material 3 Expressive**: Conjunto de paquetes M3E (`m3e_collection`, `m3e_core`, `m3e_buttons`, `flutter_m3shapes_extended`)
- **Flutter & Dart**: Google y comunidad de Flutter
- **Inspiración de Diseño**: Material Design 3 guidelines

### Cómo Contribuir

Si deseas contribuir al proyecto:

1. Fork el repositorio desde [iCristian/m3e_explosion](https://github.com/iCristian/m3e_explosion)
2. Crea una rama para tu feature (`git checkout -b feature/mi-feature`)
3. Haz commit de tus cambios (`git commit -am 'Agrega mi feature'`)
4. Push a la rama (`git push origin feature/mi-feature`)
5. Abre un Pull Request con descripción clara

Por favor mantén cambios acotados por módulo y ejecuta `flutter analyze` + `flutter test` antes de PR.
