import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SliderWithLabel extends StatelessWidget {
  const SliderWithLabel({
    required this.min,
    required this.max,
    required this.divisions,
    required this.value,
    required this.label,
    required this.onChanged,
    required this.title,
    required this.subtitle,
    super.key,
  });

  final double min;
  final double max;
  final int divisions;
  final double value;
  final String label;
  final ValueChanged<double> onChanged;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          ListTile(
            title: Text(title),
            subtitle: Text(subtitle),
            dense: true,
          ),
          Slider(
            min: min,
            max: max,
            divisions: divisions,
            value: value,
            label: label,
            onChanged: onChanged,
          ),
        ],
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('min', min))
      ..add(DoubleProperty('max', max))
      ..add(IntProperty('divisions', divisions))
      ..add(DoubleProperty('value', value))
      ..add(StringProperty('label', label))
      ..add(
        ObjectFlagProperty<ValueChanged<double>>.has('onChanged', onChanged),
      )
      ..add(StringProperty('title', title))
      ..add(StringProperty('subtitle', subtitle));
  }
}
