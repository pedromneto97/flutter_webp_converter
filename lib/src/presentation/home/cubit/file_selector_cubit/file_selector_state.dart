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
  final List<File> selectedFiles;

  const FileSelectorSelected({
    required this.selectedFiles,
  });

  @override
  List<Object> get props => [selectedFiles];
}
