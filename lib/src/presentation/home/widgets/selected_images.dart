import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/image_file.dart';
import '../cubit/file_selector_cubit/file_selector_cubit.dart';

class SelectedImages extends StatelessWidget {
  const SelectedImages({super.key});

  @override
  Widget build(BuildContext context) {
    const size = 220.0;
    const cardRadius = BorderRadius.all(Radius.circular(16));
    final scroll = ScrollController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Selected files',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 8),
        Scrollbar(
          controller: scroll,
          child: Container(
            height: size + 16.0,
            margin: const EdgeInsets.only(bottom: 16.0),
            child: BlocSelector<FileSelectorCubit, FileSelectorState, List<File>>(
              selector: (state) => state is FileSelectorSelected ? state.selectedFiles : const [],
              builder: (context, state) => ListView.separated(
                controller: scroll,
                scrollDirection: Axis.horizontal,
                itemCount: state.length + 1,
                clipBehavior: Clip.hardEdge,
                primary: false,
                separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 16),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return InkWell(
                      key: const Key('add_image'),
                      borderRadius: cardRadius,
                      onTap: () => WidgetsBinding.instance.addPostFrameCallback(
                        (_) => BlocProvider.of<FileSelectorCubit>(context).pickFile(),
                      ),
                      child: const Icon(
                        Icons.add_photo_alternate_rounded,
                        size: size,
                      ),
                    );
                  }

                  final file = state[index - 1];

                  return ImageFile(
                    key: ValueKey(file.path),
                    file: file,
                    onPressRemove: BlocProvider.of<FileSelectorCubit>(context).removeFile,
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
