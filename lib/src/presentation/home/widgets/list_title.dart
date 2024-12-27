import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/localizations.dart';
import '../cubit/file_selector_cubit/file_selector_cubit.dart';

class ListTitle extends StatelessWidget {
  const ListTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return SliverPadding(
      padding: const EdgeInsets.only(bottom: 8),
      sliver: SliverToBoxAdapter(
        child: Row(
          children: [
            Expanded(
              child: Text(
                strings.selectedImages,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            IconButton(
              onPressed: context.read<FileSelectorCubit>().pickFile,
              icon: const Icon(Icons.add_circle_outline_outlined),
              tooltip: strings.pickImages,
            ),
          ],
        ),
      ),
    );
  }
}
