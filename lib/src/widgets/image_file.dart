import 'dart:io';

import 'package:flutter/material.dart';

import 'file_size_display.dart';

class ImageFile extends StatelessWidget {
  final File file;
  final void Function(File file)? onPressRemove;

  const ImageFile({
    super.key,
    required this.file,
    this.onPressRemove,
  });

  @override
  Widget build(BuildContext context) {
    const size = 220.0;
    final colorScheme = Theme.of(context).colorScheme;

    Widget widget = Material(
      clipBehavior: Clip.antiAlias,
      color: colorScheme.onBackground,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: Stack(
        children: [
          Image.file(
            file,
            fit: BoxFit.contain,
            height: size,
            width: size,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 16.0,
            child: FileSizeDisplay(file: file),
          ),
        ],
      ),
    );

    if (onPressRemove != null) {
      widget = Stack(
        children: [
          widget,
          Positioned(
            right: 0,
            top: 0,
            child: IconButton(
              onPressed: () => onPressRemove!.call(file),
              icon: const Icon(Icons.remove_circle_outline),
              color: colorScheme.error,
              tooltip: 'Remove photo',
            ),
          ),
        ],
      );
    }

    return widget;
  }
}
