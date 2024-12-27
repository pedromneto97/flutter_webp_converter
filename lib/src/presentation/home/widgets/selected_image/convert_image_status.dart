import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/localizations.dart';
import '../../cubit/convert_file/convert_file_cubit.dart';

class ConvertImageStatus extends StatelessWidget {
  const ConvertImageStatus({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ConvertFileCubit, ConvertFileState>(
        builder: (context, state) => switch (state) {
          ConvertFileInitial() => Chip(
              label: Text(context.strings.waiting),
            ),
          ConvertingFile() => Chip(
              label: Text(context.strings.converting),
              avatar: const CircularProgressIndicator(),
            ),
          ConvertFileSuccess() => Chip(
              label: Text(context.strings.success),
              avatar: const Icon(Icons.check),
            ),
          ConvertFileFailure() => Chip(
              label: Text(context.strings.error),
              avatar: const Icon(Icons.error),
            ),
        },
      );
}
