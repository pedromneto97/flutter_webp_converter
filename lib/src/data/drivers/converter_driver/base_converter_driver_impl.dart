import 'dart:io';

import '../../../domain/domain.dart';

abstract class BaseConverterDriverImpl extends ConverterDriver {
  const BaseConverterDriverImpl();

  String get executable;

  @override
  Future<File> convertImage(File file, Parameters parameters) async {
    try {
      final arguments = <String>[
        file.path,
        '-m',
        parameters.compressionMethod.toString(),
        '-q',
        parameters.quality.toString(),
      ];

      if (parameters.lossless) {
        arguments.add('-lossless');
      }
      if (parameters.multiThreading) {
        arguments.add('-mt');
      }

      final filePath = '${parameters.outputFolder}${Platform.pathSeparator}${file.nameWithoutExt}.webp';

      arguments.addAll(['-o', filePath]);

      final data = await Process.run(executable, arguments);

      if (data.exitCode != 0) {
        if ((data.stderr as String).contains('cannot open input file')) {
          throw FileNotFound(file);
        }

        throw FailedToConvertFile(file);
      }

      return File(filePath);
    } on BaseException {
      rethrow;
    } on ProcessException {
      throw const ExecutableNotFound();
    } catch (_) {
      throw FailedToConvertFile(file);
    }
  }
}

extension FileName on File {
  String get name => path.split(Platform.pathSeparator).last;

  String get nameWithoutExt => name.split('.').first;
}
