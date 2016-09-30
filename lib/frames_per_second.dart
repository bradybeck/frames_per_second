import 'dart:async';
import 'dart:html';

export 'src/frames_per_second_base.dart';

/// Calculates the pages frames per second. Provides a stream so a consumer can stream the changes.
class FramesPerSecond {
  int _currentFps;
  StreamController _fpsController;
  Stream fpsUpdateStream;

  bool _active;
  int _timeLastSecond;
  int _frameCount;
  int _time;

  Element _fpsContainer;
  Element _totalItems;

  int get totalItems => document.querySelectorAll('*').length;

  /// Creates a class and starts recording by default.
  FramesPerSecond({addRibbon: false}) {
    _currentFps = 0;
    _frameCount = 0;
    _timeLastSecond = 0;
    _fpsController = new StreamController.broadcast();
    _active = true;
    fpsUpdateStream = _fpsController.stream;
    _loop();

    if (addRibbon) {
      this.addRibbon();
    }
  }

  int get currentFps => _currentFps;

  // adding a ribbon to the top for debugging.
  addRibbon() {
    DivElement div = new DivElement();
    div.id = 'FPSDisplay';
    div.className = 'fpsDisplay';
    div.style.backgroundColor = 'black';
    div.style.color = 'white';
    div.style.fontFamily = 'Helvetica';
    div.style.padding = '0.5em';
    div.style.opacity = '0.5';
    div.style.position = 'relative';
    div.style.top = '0';
    div.style.right = '0';
    div.style.left = '0';
    div.style.zIndex = '1000';

    DivElement elementContainer = new DivElement();
    elementContainer.style.padding = '5px';

    _totalItems = new SpanElement();
    _totalItems = new DivElement()..text = 'Loading...';

    _fpsContainer = new SpanElement();

    elementContainer.children.add(_fpsContainer);
    elementContainer.children.add(_totalItems);

    div.children.add(elementContainer);

    document.body.children.insert(0, div);
  }

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

      if (_totalItems != null) {
        _totalItems.children = [
          new SpanElement()..text = 'total elements: ${totalItems.toString()}'
        ];
        _fpsContainer.children = [
          new SpanElement()..text = 'fps: ${_currentFps.toString()}'
        ];
      }
    }
  }

  /// Kicks off a call to update the [_currentFps] every animation frame.
  _loop() {
    if (!_active) return;
    _update();
    window.requestAnimationFrame((_) => _loop());
  }
}
