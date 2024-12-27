import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/localizations.dart';
import '../cubit/file_selector_cubit/file_selector_cubit.dart';
import 'selected_image/selected_image.dart';

class SelectedImages extends StatelessWidget {
  const SelectedImages({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return BlocSelector<FileSelectorCubit, FileSelectorState, List<File>>(
      selector: (state) =>
          state is FileSelectorSelected ? state.selectedFiles : const [],
      builder: (context, state) => SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => SelectedImage(
            key: ValueKey(state[index].path),
            file: state[index],
          ),
          childCount: state.length,
        ),
      ),
    );
  }
}
