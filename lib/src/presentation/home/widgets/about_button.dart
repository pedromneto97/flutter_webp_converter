import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../core/utils/localizations.dart';

class AboutButton extends StatelessWidget {
  const AboutButton({super.key});

  Future<void> _onTapGithub() async {
    const url = 'https://github.com/pedromneto97/flutter_webp_converter';
    final canOpen = await canLaunchUrlString(
      url,
    );
    if (canOpen) {
      await launchUrlString(
        url,
      );
    }
  }

  Future<void> _onTap(BuildContext context) async {
    final packageInfo = await PackageInfo.fromPlatform();

    if (!context.mounted) {
      return;
    }

    return showAboutDialog(
      context: context,
      applicationLegalese: 'Copyright (C) 2024 dev.lospi. All rights reserved.',
      applicationName: 'WebP Converter',
      applicationVersion: packageInfo.version,
      children: [
        TextButton(
          onPressed: _onTapGithub,
          child: const Text('GitHub'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => TextButton.icon(
        onPressed: () => _onTap(context),
        label: Text(context.strings.about),
        icon: const Icon(Icons.info_outline),
      );
}
