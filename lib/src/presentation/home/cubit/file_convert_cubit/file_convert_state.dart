part of 'file_convert_cubit.dart';

@immutable
abstract class FileConvertState extends Equatable {
  const FileConvertState();

  @override
  List<Object?> get props => const [];
}

class FileConvertInitial extends FileConvertState {
  const FileConvertInitial();
}

class FileConvertLoading extends FileConvertState {
  const FileConvertLoading();
}

class FileConvertSuccess extends FileConvertState {
  final List<File> convertedFiles;
  final List<ConversionException> failedFiles;

  const FileConvertSuccess({
    required this.convertedFiles,
    this.failedFiles = const [],
  });

  @override
  List<Object> get props => [
        convertedFiles,
        failedFiles,
      ];
}

class FileConvertFailure extends FileConvertState {
  final Exception? exception;

  const FileConvertFailure({
    this.exception,
  });

  @override
  List<Object?> get props => [
        exception,
      ];
}
