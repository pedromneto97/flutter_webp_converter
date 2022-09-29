import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/setup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();

  runApp(const App());
}
