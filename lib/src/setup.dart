import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

import 'domain/domain.dart';
import 'presentation/home/cubit/parameter_cubit/parameter_cubit.dart';
import 'rust/frb_generated.dart';
import 'setup.config.dart';

Future<void> setup() async {
  await RustLib.init();

  _configureDependencies();
  await _setupCubit();
}

@InjectableInit()
void _configureDependencies() => GetIt.I.init();

Future<Directory> _setupDirectory() async {
  final documentsPath = await getApplicationDocumentsDirectory();
  final directory =
      Directory('${documentsPath.path}${Platform.pathSeparator}webp_converter');
  if (!directory.existsSync()) {
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
