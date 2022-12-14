import 'dart:io';

abstract class BaseException implements Exception {
  const BaseException();
}

abstract class ConversionException extends BaseException {
  final File file;

  const ConversionException(this.file);
}

class FailedToConvertFile extends ConversionException {
  const FailedToConvertFile(super.file);
}

class FileNotFound extends ConversionException {
  const FileNotFound(super.file);
}

class ExecutableNotFound extends BaseException {
  const ExecutableNotFound();
}
