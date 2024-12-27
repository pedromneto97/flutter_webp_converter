import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../core/utils/conversion.dart';

class FileSizeDisplay extends StatelessWidget {
  const FileSizeDisplay({
    required this.file,
    super.key,
  });

  final File file;

  @override
  Widget build(BuildContext context) => FutureBuilder<int>(
        future: file.length(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          }

          return Text(
            snapshot.data!.byteToString,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          );
        },
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<File>('file', file));
  }
}
