import 'dart:html';

import 'package:frames_per_second/frames_per_second.dart';

main() {
  FramesPerSecond fps = new FramesPerSecond();

  DivElement fpsDiv = new DivElement();
  DivElement totalElements = new DivElement();
  document.body.append(fpsDiv);
  document.body.append(totalElements);

  fps.fpsUpdateStream.listen((_) {
    fpsDiv.text = fps.currentFps.toString();
    totalElements.text = fps.totalItems.toString();
  });
}
