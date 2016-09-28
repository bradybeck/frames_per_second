# Frames Per Second [![Build Status](https://travis-ci.org/bradybeck/frames_per_second.svg?branch=master)](https://travis-ci.org/bradybeck/frames_per_second)

A lightweight library to calculate frames per second.

## Usage

A simple usage example:

```dart
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
```

## Development

`frames_per_second` leverages the [dart_dev](https://github.com/Workiva/dart_dev) package for most of its
tooling needs, including static analysis, code formatting, running tests, collecting coverage,
and serving examples. Check out the dart_dev readme for more information.

#### Testing - `pub run dart_dev test`

#### Examples - `pub run dart_dev examples`

#### Formatting - `pub run dart_dev format`
