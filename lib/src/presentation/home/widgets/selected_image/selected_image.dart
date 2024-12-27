import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/utils/localizations.dart';
import '../../../../widgets/file_size_display.dart';
import '../../cubit/convert_file/convert_file_cubit.dart';
import '../../cubit/file_selector_cubit/file_selector_cubit.dart';
import 'convert_image_status.dart';
import 'new_file_size.dart';

class SelectedImage extends StatefulWidget {
  const SelectedImage({
    required this.file,
    super.key,
  });

  final File file;

  @override
  State<SelectedImage> createState() => _SelectedImageState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<File>('file', file));
  }
}

class _SelectedImageState extends State<SelectedImage> {
  late final _cubit = GetIt.I.get<ConvertFileCubit>(
    param1: _file,
  );

  File get _file => widget.file;

  void _removeFile() => context.read<FileSelectorCubit>().removeFile(_file);

  @override
  void dispose() {
    _cubit.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const size = 160.0;

    return BlocProvider<ConvertFileCubit>.value(
      value: _cubit,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16,
        ),
        child: Row(
          children: [
            Image.file(
              widget.file,
              width: size,
              height: size,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.file.path),
                  FileSizeDisplay(file: _file),
                ],
              ),
            ),
            NewFileSize(originalFile: _file),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: ConvertImageStatus(),
            ),
            BlocSelector<ConvertFileCubit, ConvertFileState, bool>(
              selector: (state) => state is ConvertingFile,
              builder: (context, isConvertingFile) => IconButton(
                onPressed: isConvertingFile ? null : _removeFile,
                icon: const Icon(Icons.remove_circle_outline),
                tooltip: context.strings.removeImage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
