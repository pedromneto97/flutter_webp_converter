import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../domain/exceptions/exceptions.dart';
import 'cubit/file_convert_cubit/file_convert_cubit.dart';
import 'cubit/file_selector_cubit/file_selector_cubit.dart';
import 'cubit/parameter_cubit/parameter_cubit.dart';
import 'widgets/converted_images.dart';
import 'widgets/converter_actions.dart';
import 'widgets/parameters_form.dart';
import 'widgets/selected_images.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  bool listenFileConvertWhen(FileConvertState previous, FileConvertState current) =>
      (current is FileConvertSuccess && current.failedFiles.isNotEmpty) || current is FileConvertFailure;

  void onFileConvertFailure(BuildContext context, FileConvertFailure state) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: colorScheme.error,
        content: Text(
          'You don\'t have the webp converter, please install it and try again',
          style: theme.textTheme.subtitle2!.copyWith(
            color: colorScheme.onError,
          ),
        ),
      ),
    );
  }

  void onFileConvertSuccess(BuildContext context, FileConvertSuccess state) {
    final errorMessages = <String>[];
    for (int index = 0; index < state.failedFiles.length; index++) {
      final failedFile = state.failedFiles[index];

      if (failedFile is FileNotFound) {
        errorMessages.add('- File not found, file path: ${failedFile.file.path}');
      } else if (failedFile is FailedToConvertFile) {
        errorMessages.add(
          '- Failed to convert file, check if output folder exists and image format is supported: ${failedFile.file.path}',
        );
      }
    }

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Failed to convert some images:\n${errorMessages.join('\n')}',
          style: theme.textTheme.subtitle2!.copyWith(
            color: colorScheme.onError,
          ),
        ),
        backgroundColor: colorScheme.error,
        duration: const Duration(seconds: 30),
      ),
    );
  }

  void fileConvertListener(BuildContext context, FileConvertState state) {
    if (state is FileConvertFailure) {
      onFileConvertFailure(context, state);
    } else if (state is FileConvertSuccess && state.failedFiles.isNotEmpty) {
      onFileConvertSuccess(context, state);
    }
  }

  @override
  Widget build(BuildContext context) {
    const contentPadding = 16.0;

    return MultiBlocProvider(
      providers: [
        BlocProvider<FileSelectorCubit>(
          create: (context) => GetIt.I.get<FileSelectorCubit>(),
        ),
        BlocProvider<FileConvertCubit>(
          create: (context) => GetIt.I.get<FileConvertCubit>(),
        ),
        BlocProvider<ParameterCubit>(
          create: (context) => GetIt.I.get<ParameterCubit>(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('WebP Converter'),
        ),
        endDrawer: Drawer(
          width: MediaQuery.of(context).size.width * 0.3,
          child: const ParametersForm(),
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<FileSelectorCubit, FileSelectorState>(
              listener: (context, state) => BlocProvider.of<FileConvertCubit>(context).clear(),
            ),
            BlocListener<FileConvertCubit, FileConvertState>(
              listenWhen: listenFileConvertWhen,
              listener: fileConvertListener,
            ),
          ],
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(contentPadding),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight - (contentPadding * 2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      SelectedImages(),
                      SizedBox(height: 16),
                      ConvertedImages(),
                      SizedBox(height: 16),
                      ConverterActions(),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
