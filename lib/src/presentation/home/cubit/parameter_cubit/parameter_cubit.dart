import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/domain.dart';

class ParameterCubit extends Cubit<Parameters> {
  ParameterCubit(super.parameters);

  void changeMultiThreading(bool isMultiThreading) => emit(state.copyWith(multiThreading: isMultiThreading));

  void changeLossless(bool lossless) => emit(state.copyWith(lossless: lossless));

  void changeCompression(int compressionMethod) => emit(
        state.copyWith(compressionMethod: compressionMethod),
      );

  void changeQuality(int quality) => emit(state.copyWith(quality: quality));

  Future<void> changeOutputDirectory() async {
    final result = await FilePicker.platform.getDirectoryPath(
      initialDirectory: state.outputFolder,
    );
    if (result != null) {
      emit(state.copyWith(outputFolder: result));
    }
  }
}
