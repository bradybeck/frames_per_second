import 'dart:async';
import 'dart:html';

export 'src/frames_per_second_base.dart';

/// Calculates the pages frames per second. Provides a stream so a consume can stream the changes.
class FramesPerSecond {
  int _currentFps;
  StreamController _fpsController;
  Stream fpsUpdateStream;

  bool _active;
  int _timeLastSecond;
  int _frameCount;
  int _time;

  int get totalItems => document.querySelectorAll('*').length;

  /// Creates a class and starts recording by default.
  FramesPerSecond() {
    _currentFps = 0;
    _frameCount = 0;
    _timeLastSecond = 0;
    _fpsController = new StreamController.broadcast();
    _active = true;
    fpsUpdateStream = _fpsController.stream;
    _loop();
  }

  int get currentFps => _currentFps;

  /// Start recording frames per second.
  start() {
    _active = true;
    _loop();
  }

  /// Stop recording frames per second.
  stop() {
    _active = false;
  }

  /// Updates the [_currentFps] and streams out the update.
  _update() {
    _time = new DateTime.now().millisecondsSinceEpoch;
    _frameCount++;

    // at least a second has passed...
    if (_time > _timeLastSecond + 1000) {
      _currentFps = _frameCount;
      _timeLastSecond = _time;
      _frameCount = 0;

      // let the consumer know of the change.
      _fpsController.add(null);
    }
  }

  /// Kicks off a call to update the [_currentFps] every animation frame.
  _loop() {
    if (!_active) return;
    _update();
    window.requestAnimationFrame((_) => _loop());
  }
}
