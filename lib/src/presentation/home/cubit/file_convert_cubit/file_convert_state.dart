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
  const FileConvertSuccess({
    required this.convertedFiles,
    this.failedFiles = const [],
  });

  final List<File> convertedFiles;
  final List<ConversionException> failedFiles;

  @override
  List<Object> get props => [
        convertedFiles,
        failedFiles,
      ];
}

class FileConvertFailure extends FileConvertState {
  const FileConvertFailure({
    this.exception,
  });

  final Exception? exception;

  @override
  List<Object?> get props => [
        exception,
      ];
}
