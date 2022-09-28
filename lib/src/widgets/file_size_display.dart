import 'dart:io';

import 'package:flutter/material.dart';

import '../utils/conversion.dart';

class FileSizeDisplay extends StatelessWidget {
  final File file;

  const FileSizeDisplay({
    super.key,
    required this.file,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
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
  }
}
