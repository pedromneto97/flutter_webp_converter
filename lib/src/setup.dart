import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

import 'data/drivers/converter_driver/converter_driver.dart';
import 'domain/domain.dart';
import 'presentation/home/cubit/parameter_cubit/parameter_cubit.dart';
import 'setup.config.dart';

Future<void> setup() async {
  _setupDrivers();
  _configureDependencies();
  await _setupCubit();
}

@InjectableInit()
void _configureDependencies() => $initGetIt(GetIt.I);

void _setupDrivers() {
  GetIt.I.registerLazySingleton<ConverterDriver>(() {
    if (Platform.isWindows) {
      return const WinConverterDriverImpl();
    }
    return const UnixConverterDriverImpl();
  });
}

Future<Directory> _setupDirectory() async {
  final documentsPath = await getApplicationDocumentsDirectory();
  final directory = Directory('${documentsPath.path}${Platform.pathSeparator}webp_converter');
  if (!await directory.exists()) {
    await directory.create();
  }

  return directory;
}

Future<void> _setupCubit() async {
  final outputFolder = await _setupDirectory();

  GetIt.I.registerFactory<ParameterCubit>(
    () => ParameterCubit(
      Parameters(outputFolder: outputFolder.path),
    ),
  );
}
