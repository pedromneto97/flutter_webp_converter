import 'dart:io';

import 'package:injectable/injectable.dart';

import '../../rust/api/converter.dart';
import '../entities/entities.dart';

@LazySingleton()
class ConvertFileUseCase {
  const ConvertFileUseCase();

  Future<File> call(File file, Parameters parameters) async {
    final outputPath = await convertImage(
      imagePath: file.path,
      convertParameters: ConvertParameters(
        quality: parameters.quality.toDouble(),
        outputDirectory: parameters.outputFolder,
        lossless: parameters.lossless,
        method: parameters.compressionMethod,
      ),
    );

    return File(outputPath);
  }
}
