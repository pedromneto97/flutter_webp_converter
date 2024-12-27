part of 'convert_file_cubit.dart';

sealed class ConvertFileState extends Equatable {
  const ConvertFileState();

  @override
  List<Object> get props => [];
}

final class ConvertFileInitial extends ConvertFileState {
  const ConvertFileInitial();
}

final class ConvertingFile extends ConvertFileState {
  const ConvertingFile();
}

final class ConvertFileSuccess extends ConvertFileState {
  const ConvertFileSuccess({
    required this.convertedFile,
  });

  final File convertedFile;

  @override
  List<Object> get props => [convertedFile];
}

final class ConvertFileFailure extends ConvertFileState {
  const ConvertFileFailure();
}
