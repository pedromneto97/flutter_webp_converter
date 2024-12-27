import 'dart:async';

import 'base_event.dart';

abstract interface class EventBus {
  static final EventBus I = _EventBusImpl();

  void fire(BaseEvent event);

  StreamSubscription<T> on<T extends BaseEvent>(
    void Function(T event) callback,
  );
}

class _EventBusImpl implements EventBus {
  final _stream = StreamController<BaseEvent>.broadcast();

  @override
  void fire(BaseEvent event) => _stream.add(event);

  @override
  StreamSubscription<T> on<T extends BaseEvent>(
    void Function(T event) callback,
  ) =>
      _stream.stream
          .where(
            (event) => event is T,
          )
          .cast<T>()
          .listen(callback);
}
