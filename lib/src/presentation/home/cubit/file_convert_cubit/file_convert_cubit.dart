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
  final ConvertFileUseCase _useCase;

  FileConvertCubit(this._useCase) : super(const FileConvertInitial());

  Future<void> convertFiles(List<File> files, Parameters parameters) async {
    try {
      emit(const FileConvertLoading());

      final futures = <Future>[];
      final convertedFiles = <File>[];
      final failedFiles = <ConversionException>[];

      for (int index = 0; index < files.length; index++) {
        futures.add(
          _useCase
              .call(files[index], parameters)
              .then(
                (value) => convertedFiles.add(value),
              )
              .catchError(
                (exception) => failedFiles.add(exception),
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
