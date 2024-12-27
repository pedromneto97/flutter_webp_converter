import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/event_bus/base_event.dart';
import '../../../../core/event_bus/event_bus.dart';
import '../../../../domain/domain.dart';
import '../parameter_cubit/parameter_cubit.dart';

part 'convert_file_state.dart';

@injectable
class ConvertFileCubit extends Cubit<ConvertFileState> {
  ConvertFileCubit({
    required ConvertFileUseCase useCase,
    required ParameterCubit parameterCubit,
    @factoryParam required File file,
  })  : _useCase = useCase,
        _parameterCubit = parameterCubit,
        _file = file,
        super(const ConvertFileInitial()) {
    _subscription = EventBus.I.on<ConvertFiles>(
      (_) => _convertFile(),
    );
  }

  final ConvertFileUseCase _useCase;
  final ParameterCubit _parameterCubit;
  final File _file;
  late final StreamSubscription<BaseEvent> _subscription;

  Future<void> _convertFile() async {
    if (state is ConvertingFile) {
      return;
    }

    try {
      emit(const ConvertingFile());

      final convertedFile = await _useCase.call(_file, _parameterCubit.state);

      if (isClosed) {
        return;
      }

      emit(ConvertFileSuccess(convertedFile: convertedFile));
    } catch (_) {
      emit(const ConvertFileFailure());
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();

    return super.close();
  }
}
