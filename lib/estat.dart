library estat;

import 'dart:async' show Stream, StreamController, StreamTransformer;
import 'package:flutter/material.dart';

class StateContainer<T> {
  final _controller = StreamController<T>.broadcast();
  Stream<T> get stream => _controller.stream;
  Function(T) get addInStream => _controller.sink.add;
  Sink<T> get sink => _controller.sink;

  addTransformer({@required void Function(T value, Sink sink) transformer}) {
    stream.transform(StreamTransformer.fromHandlers(
      handleData: transformer,
    ));
  }

  stateListener({@required Widget Function(BuildContext context, T object) child}) {
    return StreamBuilder(
      stream: this.stream,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        return child(context, snapshot.data);
      },
    );
  }

  dispose() {
    _controller.close();
  }
}