import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';

import 'domain/domain.dart';
import 'presentation/home/cubit/convert_file/convert_file_cubit.dart';
import 'presentation/home/cubit/file_selector_cubit/file_selector_cubit.dart';
import 'presentation/home/cubit/parameter_cubit/parameter_cubit.dart';
import 'rust/frb_generated.dart';

Future<void> setup() async {
  await RustLib.init();

  _setupUseCase();
  await _setupCubit();
}

Future<Directory> _setupDirectory() async {
  final documentsPath = await getApplicationDocumentsDirectory();
  final directory =
      Directory('${documentsPath.path}${Platform.pathSeparator}webp_converter');
  if (!directory.existsSync()) {
    await directory.create();
  }

  return directory;
}

void _setupUseCase() {
  GetIt.I.registerLazySingleton<ConvertFileUseCase>(
    () => const ConvertFileUseCase(),
  );
}

Future<void> _setupCubit() async {
  final outputFolder = await _setupDirectory();

  GetIt.I
    ..registerLazySingleton<ParameterCubit>(
      () => ParameterCubit(
        Parameters(outputFolder: outputFolder.path),
      ),
    )
    ..registerLazySingleton(FileSelectorCubit.new)
    ..registerFactoryParam<ConvertFileCubit, File, void>(
      (file, _) => ConvertFileCubit(
        useCase: GetIt.I.get(),
        parameterCubit: GetIt.I.get(),
        file: file,
      ),
    );
}
