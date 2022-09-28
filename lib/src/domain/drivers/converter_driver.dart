import 'dart:io';

import '../entities/entities.dart';

abstract class ConverterDriver {
  const ConverterDriver();

  Future<File> convertImage(File file, Parameters parameters);
}
