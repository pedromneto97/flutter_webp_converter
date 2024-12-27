import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/event_bus/base_event.dart';
import '../../../core/event_bus/event_bus.dart';
import '../../../core/utils/localizations.dart';
import '../cubit/file_selector_cubit/file_selector_cubit.dart';

class ConverterActions extends StatelessWidget {
  const ConverterActions({super.key});

  void _convertImages() => EventBus.I.fire(const ConvertFiles());

  void _clear(BuildContext context) =>
      BlocProvider.of<FileSelectorCubit>(context).clear();

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BlocSelector<FileSelectorCubit, FileSelectorState, List<File>>(
          selector: (state) =>
              state is FileSelectorSelected ? state.selectedFiles : const [],
          builder: (context, state) {
            if (state.isEmpty) {
              return const SizedBox.shrink();
            }

            return ElevatedButton(
              onPressed: _convertImages,
              child: Text(strings.convert),
            );
          },
        ),
        const SizedBox(height: 16.0),
        OutlinedButton(
          onPressed: () => _clear(context),
          child: Text(strings.clear),
        ),
      ],
    );
  }
}
