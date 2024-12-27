import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/file_convert_cubit/file_convert_cubit.dart';
import '../cubit/file_selector_cubit/file_selector_cubit.dart';
import '../cubit/parameter_cubit/parameter_cubit.dart';

class ConverterActions extends StatelessWidget {
  const ConverterActions({super.key});

  void clear(BuildContext context) {
    BlocProvider.of<FileSelectorCubit>(context).clear();
    BlocProvider.of<FileConvertCubit>(context).clear();
  }

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BlocSelector<FileSelectorCubit, FileSelectorState, List<File>>(
            selector: (state) =>
                state is FileSelectorSelected ? state.selectedFiles : const [],
            builder: (context, state) => ElevatedButton(
              onPressed: () =>
                  BlocProvider.of<FileConvertCubit>(context).convertFiles(
                state,
                BlocProvider.of<ParameterCubit>(context).state,
              ),
              child: const Text('Convert'),
            ),
          ),
          const SizedBox(height: 16.0),
          OutlinedButton(
            onPressed: () => clear(context),
            child: const Text('Clear file'),
          ),
        ],
      );
}
