import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'file_selector_state.dart';

@injectable
class FileSelectorCubit extends Cubit<FileSelectorState> {
  FileSelectorCubit() : super(const FileSelectorInitial());

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
      type: FileType.image,
    );

    if (result != null) {
      final paths = result.paths;
      final currentState = state;
      final currentSelectedFiles = <File>[
        if (currentState is FileSelectorSelected) ...currentState.selectedFiles,
      ];

      for (int i = 0; i < paths.length; i++) {
        final file = File(paths[i]!);

        if (!currentSelectedFiles.contains(file)) {
          currentSelectedFiles.add(file);
        }
      }
      emit(
        FileSelectorSelected(
          selectedFiles: currentSelectedFiles,
        ),
      );
    }
  }

  void removeFile(File file) {
    final currentState = state;
    if (currentState is FileSelectorSelected) {
      final files = [...currentState.selectedFiles];
      files.remove(file);
      emit(
        FileSelectorSelected(selectedFiles: files),
      );
    }
  }

  void clear() => emit(const FileSelectorInitial());
}
