import 'package:flutter/material.dart';

class SliderWithLabel extends StatelessWidget {
  final double min;
  final double max;
  final int divisions;
  final double value;
  final String label;
  final ValueChanged<double> onChanged;
  final String title;
  final String subtitle;

  const SliderWithLabel({
    super.key,
    required this.min,
    required this.max,
    required this.divisions,
    required this.value,
    required this.label,
    required this.onChanged,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(title),
          subtitle: Text(subtitle),
          dense: true,
        ),
        Slider.adaptive(
          min: min,
          max: max,
          divisions: divisions,
          value: value,
          label: label,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
