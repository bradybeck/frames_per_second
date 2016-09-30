import 'dart:html';

import 'package:frames_per_second/frames_per_second.dart';

main() {
  FramesPerSecond fps = new FramesPerSecond(addRibbon: true);

  DivElement fpsDiv = new DivElement();
  DivElement totalElements = new DivElement();
  document.body.append(fpsDiv);
  document.body.append(totalElements);

  var listener = fps.fpsUpdateStream.listen((_) {
    fpsDiv.text = fps.currentFps.toString();
    totalElements.text = fps.totalItems.toString();
  });

  window.onBeforeUnload.listen((_) {
    listener.cancel();
  });
}
