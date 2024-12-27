import 'dart:io';

abstract class BaseException implements Exception {
  const BaseException();
}

abstract class ConversionException extends BaseException {
  const ConversionException(this.file);

  final File file;
}

class FailedToConvertFile extends ConversionException {
  const FailedToConvertFile(super.file);
}

class FileNotFound extends ConversionException {
  const FileNotFound(super.file);
}
