@TestOn('browser')
import 'dart:async';

import 'package:frames_per_second/frames_per_second.dart';
import 'package:test/test.dart';

void main() {
  group('Frames Per Second', () {
    test('Should stream fps', () async {
      FramesPerSecond fps = new FramesPerSecond();
      Completer c = new Completer();
      var listener = fps.fpsUpdateStream.listen((_) {
        c.complete();
      });

      await c.future;
      listener.cancel();
    });

    test('should stop streaming', () async {
      FramesPerSecond fps = new FramesPerSecond();
      Completer c = new Completer();
      var listener = fps.fpsUpdateStream.listen((_) {
        c.complete();
      });

      await c.future;
      listener.cancel();
      fps.stop();

      int called = 0;
      fps.fpsUpdateStream.listen((_) {
        called++;
      });

      await new Timer(new Duration(seconds: 2), () {
        expect(called, 0);
      });
    });

    test('should stop and start streaming', () async {
      FramesPerSecond fps = new FramesPerSecond();
      Completer c = new Completer();
      var listener = fps.fpsUpdateStream.listen((_) {
        c.complete();
      });

      await c.future;
      listener.cancel();
      fps.stop();

      int called = 0;
      fps.fpsUpdateStream.listen((_) {
        called++;
      });

      await new Timer(new Duration(seconds: 2), () {
        expect(called, 0);
      });

      fps.start();

      await new Timer(new Duration(seconds: 2), () {
        expect(called, 2);
      });
    });
  });
}
