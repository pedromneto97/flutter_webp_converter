part of 'file_selector_cubit.dart';

abstract class FileSelectorState extends Equatable {
  const FileSelectorState();

  @override
  List<Object> get props => const [];
}

class FileSelectorInitial extends FileSelectorState {
  const FileSelectorInitial();
}

class FileSelectorSelected extends FileSelectorState {
  const FileSelectorSelected({
    required this.selectedFiles,
  });

  final List<File> selectedFiles;

  @override
  List<Object> get props => [selectedFiles];
}
