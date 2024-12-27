import 'package:equatable/equatable.dart';

sealed class BaseEvent with EquatableMixin {
  const BaseEvent();

  @override
  List<Object> get props => [];
}

final class ConvertFiles extends BaseEvent {
  const ConvertFiles();
}
