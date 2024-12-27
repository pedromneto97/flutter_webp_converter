// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:webp_converter/src/domain/use_cases/convert_file_use_case.dart'
    as _i766;
import 'package:webp_converter/src/presentation/home/cubit/file_convert_cubit/file_convert_cubit.dart'
    as _i862;
import 'package:webp_converter/src/presentation/home/cubit/file_selector_cubit/file_selector_cubit.dart'
    as _i579;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i579.FileSelectorCubit>(() => _i579.FileSelectorCubit());
    gh.lazySingleton<_i766.ConvertFileUseCase>(
        () => const _i766.ConvertFileUseCase());
    gh.factory<_i862.FileConvertCubit>(
        () => _i862.FileConvertCubit(gh<_i766.ConvertFileUseCase>()));
    return this;
  }
}
