import 'dart:io';

import 'package:injectable/injectable.dart';

import '../drivers/converter_driver.dart';
import '../entities/entities.dart';

@LazySingleton()
class ConvertFileUseCase {
  final ConverterDriver _converterDriver;

  const ConvertFileUseCase(this._converterDriver);

  Future<File> call(File file, Parameters parameters) => _converterDriver.convertImage(file, parameters);
}
