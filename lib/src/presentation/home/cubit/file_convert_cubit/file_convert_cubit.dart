import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/entities.dart';
import '../../../../domain/exceptions/exceptions.dart';
import '../../../../domain/use_cases/convert_file_use_case.dart';

part 'file_convert_state.dart';

@injectable
class FileConvertCubit extends Cubit<FileConvertState> {
  FileConvertCubit(this._useCase) : super(const FileConvertInitial());

  final ConvertFileUseCase _useCase;

  Future<void> convertFiles(List<File> files, Parameters parameters) async {
    try {
      emit(const FileConvertLoading());

      final futures = <Future>[];
      final convertedFiles = <File>[];
      final failedFiles = <ConversionException>[];

      for (var index = 0; index < files.length; index++) {
        futures.add(
          _useCase
              .call(files[index], parameters)
              .then(
                convertedFiles.add,
              )
              .catchError(
                failedFiles.add,
                test: (exception) => exception is ConversionException,
              ),
        );
      }

      await Future.wait(futures);

      emit(
        FileConvertSuccess(
          convertedFiles: convertedFiles,
          failedFiles: failedFiles,
        ),
      );
    } on ExecutableNotFound catch (exception) {
      emit(
        FileConvertFailure(exception: exception),
      );
    } catch (_) {
      emit(const FileConvertFailure());
    }
  }

  void clear() => emit(const FileConvertInitial());
}
