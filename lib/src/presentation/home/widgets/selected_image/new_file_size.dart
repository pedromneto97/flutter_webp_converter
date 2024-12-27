import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/conversion.dart';
import '../../../../core/utils/localizations.dart';
import '../../cubit/convert_file/convert_file_cubit.dart';

class NewFileSize extends StatelessWidget {
  const NewFileSize({
    required this.originalFile,
    super.key,
  });

  final File originalFile;

  @override
  Widget build(BuildContext context) =>
      BlocSelector<ConvertFileCubit, ConvertFileState, File?>(
        selector: (state) =>
            state is ConvertFileSuccess ? state.convertedFile : null,
        builder: (context, file) {
          if (file == null) {
            return const SizedBox.shrink();
          }

          return Row(
            children: [
              const Icon(Icons.arrow_forward),
              FutureBuilder<List<int>>(
                future: Future.wait([
                  file.length(),
                  originalFile.length(),
                ]),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const SizedBox.shrink();
                  }
                  final strings = context.strings;

                  final newFileSize = snapshot.data!.first;
                  final originalFileSize = snapshot.data!.last;
                  final reducedSize = originalFileSize - newFileSize;
                  final percentage = reducedSize / originalFileSize * 100;

                  return Column(
                    children: [
                      Text(strings.newSize(size: newFileSize.byteToString)),
                      Text(
                        strings.sizeReduction(
                          percentage: percentage.toStringAsFixed(2),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          );
        },
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<File>('originalFile', originalFile));
  }
}
