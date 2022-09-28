import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../widgets/image_file.dart';
import '../cubit/file_convert_cubit/file_convert_cubit.dart';
import '../cubit/parameter_cubit/parameter_cubit.dart';

class ConvertedImages extends StatelessWidget {
  const ConvertedImages({super.key});

  void openFolder(BuildContext context) async {
    final uri = Uri.directory(
      BlocProvider.of<ParameterCubit>(context).state.outputFolder,
    );
    final canLaunch = await canLaunchUrl(uri);
    if (canLaunch) {
      launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scroll = ScrollController();

    return BlocBuilder<FileConvertCubit, FileConvertState>(
      builder: (context, state) {
        if (state is! FileConvertSuccess) {
          return const SizedBox();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Text(
                  'Converted images',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () => openFolder(context),
                  icon: const Icon(Icons.open_in_new),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Scrollbar(
              controller: scroll,
              child: Container(
                height: 220.0,
                margin: const EdgeInsets.only(bottom: 16.0),
                child: ListView.separated(
                  controller: scroll,
                  scrollDirection: Axis.horizontal,
                  itemCount: state.convertedFiles.length,
                  clipBehavior: Clip.hardEdge,
                  primary: false,
                  separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 16),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final file = state.convertedFiles[index];

                    return ImageFile(
                      key: ValueKey(file.path),
                      file: file,
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
