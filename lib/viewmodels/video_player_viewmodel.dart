// ViewModel para gestionar la lógica y estado del reproductor de Vimeo.
//
// Este ViewModel encapsula toda la lógica de reproducción de video,
// permitiendo reutilización en múltiples pantallas y facilita el testeo.

import 'dart:async';
import 'dart:ui' show Color;

import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// ViewModel que gestiona el estado del reproductor de Vimeo.
///
/// Extiende [ChangeNotifier] para integración con el patrón MVVM.
/// Proporciona métodos para controlar reproducción, silenciado y pantalla completa.
///
/// Ejemplo:
/// ```dart
/// final viewModel = VideoPlayerViewModel();
/// viewModel.enable(); // Inicializa el controlador
/// viewModel.playPause(); // Alterna play/pause
/// ```
class VideoPlayerViewModel extends ChangeNotifier {
  /// ID del video de Vimeo que se reproduce.
  static const String _videoId = '1169250968';

  static const String _videoPageUrl = 'https://vimeo.com/1169250968';

  /// Controlador del WebView que renderiza Vimeo.
  WebViewController? _controller;

  /// `true` cuando el reproductor ha sido inicializado.
  bool _ready = false;

  /// `true` cuando el video está en reproducción.
  bool _playing = false;

  /// `true` cuando el audio está silenciado.
  bool _muted = false;

  /// Controlador del WebView de Vimeo. `null` hasta que se llame [enable].
  WebViewController? get controller => _controller;

  /// `true` cuando el reproductor ha sido inicializado.
  bool get ready => _ready;

  /// `true` cuando el video está en reproducción.
  bool get playing => _playing;

  /// `true` cuando el audio está silenciado.
  bool get muted => _muted;

  /// ID del video de Vimeo que se reproduce.
  String get videoId => _videoId;

  String _embedUrl({required bool autoplay, required bool muted}) {
    final autoplayValue = autoplay ? 1 : 0;
    final mutedValue = muted ? 1 : 0;
    return 'https://player.vimeo.com/video/$_videoId?autoplay=$autoplayValue&muted=$mutedValue&title=0&byline=0&portrait=0';
  }

  Future<void> _loadVideo({required bool autoplay}) async {
    if (_controller == null) return;
    await _controller!.loadRequest(
      Uri.parse(_embedUrl(autoplay: autoplay, muted: _muted)),
    );
  }

  /// Inicializa el [WebViewController] de Vimeo. Solo ejecuta una vez.
  ///
  /// Este método debe llamarse cuando la UI necesite mostrar el reproductor.
  /// Las llamadas posteriores son ignoradas (idempotente).
  Future<void> enable() async {
    if (_controller != null) {
      _playing = true;
      await _loadVideo(autoplay: true);
      notifyListeners();
      return;
    }

    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000));

    _controller = controller;
    _ready = true;
    _playing = true;
    await _loadVideo(autoplay: true);
    notifyListeners();
  }

  /// Alterna entre reproducción y pausa.
  ///
  /// Si el controlador no está inicializado, inicializa y reproduce.
  Future<void> playPause() async {
    if (_controller == null) {
      await enable();
      return;
    }

    _playing = !_playing;
    await _loadVideo(autoplay: _playing);
    notifyListeners();
  }

  /// Alterna entre silenciado y con sonido.
  ///
  /// Si el controlador no está inicializado, no hace nada.
  Future<void> toggleMute() async {
    if (_controller == null) return;

    _muted = !_muted;
    await _loadVideo(autoplay: _playing);
    notifyListeners();
  }

  /// Reinicia el video desde el principio y lo pone a reproducir.
  ///
  /// Si el controlador no está inicializado, no hace nada.
  Future<void> restart() async {
    if (_controller == null) return;

    _playing = true;
    await _loadVideo(autoplay: true);
    notifyListeners();
  }

  /// Abre el video de Vimeo fuera de la app para una reproducción estable.
  ///
  /// Esto evita restricciones de reproducción embebida en algunos dispositivos.
  void openFullscreen() {
    unawaited(launchUrl(Uri.parse(_videoPageUrl), mode: LaunchMode.externalApplication));
  }

  /// Limpia recursos del controlador.
  ///
  /// Debe llamarse en `dispose()` del widget para evitar memory leaks.
  @override
  void dispose() {
    _controller = null;
    super.dispose();
  }
}
