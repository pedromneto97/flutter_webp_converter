import 'dart:io';

extension FileExtension on File {
  String get name => path.split(Platform.pathSeparator).last;
}
