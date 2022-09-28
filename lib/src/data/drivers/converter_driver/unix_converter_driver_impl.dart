import 'base_converter_driver_impl.dart';

class UnixConverterDriverImpl extends BaseConverterDriverImpl {
  const UnixConverterDriverImpl();

  @override
  String get executable => 'cwebp';
}
