/// ViewModel para gestionar la lógica y estado del reproductor de YouTube.
///
/// Este ViewModel encapsula toda la lógica de reproducción de video,
/// permitiendo reutilización en múltiples pantallas y facilita el testeo.

import 'package:flutter/foundation.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

/// ViewModel que gestiona el estado del reproductor de YouTube.
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
  /// ID del video de YouTube que se reproduce.
  static const String _videoId = '6YD25EoV5Oo';

  /// Controlador del iframe de YouTube.
  YoutubePlayerController? _controller;

  /// `true` cuando el reproductor ha sido inicializado.
  bool _ready = false;

  /// `true` cuando el video está en reproducción.
  bool _playing = false;

  /// `true` cuando el audio está silenciado.
  bool _muted = false;

  /// Controlador del iframe de YouTube. `null` hasta que se llame [enable].
  YoutubePlayerController? get controller => _controller;

  /// `true` cuando el reproductor ha sido inicializado.
  bool get ready => _ready;

  /// `true` cuando el video está en reproducción.
  bool get playing => _playing;

  /// `true` cuando el audio está silenciado.
  bool get muted => _muted;

  /// ID del video de YouTube que se reproduce.
  String get videoId => _videoId;

  /// Inicializa el [YoutubePlayerController]. Solo ejecuta una vez.
  ///
  /// Este método debe llamarse cuando la UI necesite mostrar el reproductor.
  /// Las llamadas posteriores son ignoradas (idempotente).
  void enable() {
    if (_controller != null) return;

    _controller = YoutubePlayerController.fromVideoId(
      videoId: _videoId,
      autoPlay: false,
      params: const YoutubePlayerParams(
        showControls: false,
        showFullscreenButton: false,
        enableCaption: false,
        strictRelatedVideos: true,
      ),
    );

    _ready = true;
    notifyListeners();
  }

  /// Alterna entre reproducción y pausa.
  ///
  /// Si el controlador no está inicializado, no hace nada.
  void playPause() {
    if (_controller == null) return;

    _playing ? _controller!.pauseVideo() : _controller!.playVideo();
    _playing = !_playing;
    notifyListeners();
  }

  /// Alterna entre silenciado y con sonido.
  ///
  /// Si el controlador no está inicializado, no hace nada.
  void toggleMute() {
    if (_controller == null) return;

    _muted ? _controller!.unMute() : _controller!.mute();
    _muted = !_muted;
    notifyListeners();
  }

  /// Reinicia el video desde el principio y lo pone a reproducir.
  ///
  /// Si el controlador no está inicializado, no hace nada.
  void restart() {
    if (_controller == null) return;

    _controller!.seekTo(seconds: 0);
    _controller!.playVideo();
    _playing = true;
    notifyListeners();
  }

  /// Solicita pantalla completa nativa del iframe.
  ///
  /// Si el controlador no está inicializado, no hace nada.
  void openFullscreen() => _controller?.enterFullScreen();

  /// Limpia recursos del controlador.
  ///
  /// Debe llamarse en `dispose()` del widget para evitar memory leaks.
  @override
  void dispose() {
    _controller?.close();
    super.dispose();
  }
}
