// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'domain/drivers/converter_driver.dart' as _i4;
import 'domain/use_cases/convert_file_use_case.dart' as _i3;
import 'presentation/home/cubit/file_convert_cubit/file_convert_cubit.dart' as _i5;
import 'presentation/home/cubit/file_selector_cubit/file_selector_cubit.dart'
    as _i6; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i3.ConvertFileUseCase>(() => _i3.ConvertFileUseCase(get<_i4.ConverterDriver>()));
  gh.factory<_i5.FileConvertCubit>(() => _i5.FileConvertCubit(get<_i3.ConvertFileUseCase>()));
  gh.factory<_i6.FileSelectorCubit>(() => _i6.FileSelectorCubit());
  return get;
}
