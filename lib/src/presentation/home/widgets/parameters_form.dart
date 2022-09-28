import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/domain.dart';
import '../../../widgets/slider_with_label.dart';
import '../cubit/parameter_cubit/parameter_cubit.dart';

class ParametersForm extends StatelessWidget {
  const ParametersForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const DrawerHeader(
          child: Text(
            'Parameter options',
          ),
        ),
        BlocSelector<ParameterCubit, Parameters, bool>(
          selector: (state) => state.multiThreading,
          builder: (context, state) => CheckboxListTile(
            title: const Text('Multi Threading'),
            subtitle: const Text('Uses multi-threading to convert images faster.'),
            value: state,
            onChanged: (value) => BlocProvider.of<ParameterCubit>(context).changeMultiThreading(value!),
            dense: true,
          ),
        ),
        BlocSelector<ParameterCubit, Parameters, bool>(
          selector: (state) => state.lossless,
          builder: (context, state) => CheckboxListTile(
            title: const Text('Lossless'),
            subtitle: const Text('Compress image without losing data.'),
            dense: true,
            value: state,
            onChanged: (value) => BlocProvider.of<ParameterCubit>(context).changeLossless(value!),
          ),
        ),
        BlocSelector<ParameterCubit, Parameters, int>(
          selector: (state) => state.compressionMethod,
          builder: (context, state) => SliderWithLabel(
            min: 1.0,
            max: 6.0,
            divisions: 5,
            value: state.toDouble(),
            label: state.toString(),
            onChanged: (value) => BlocProvider.of<ParameterCubit>(context).changeCompression(value.toInt()),
            title: 'Compression method',
            subtitle: 'Bigger compression method generates smaller files',
          ),
        ),
        BlocSelector<ParameterCubit, Parameters, int>(
          selector: (state) => state.quality,
          builder: (context, state) => SliderWithLabel(
            min: 0.0,
            max: 100.0,
            divisions: 100,
            value: state.toDouble(),
            label: state.toString(),
            onChanged: (value) => BlocProvider.of<ParameterCubit>(context).changeQuality(value.toInt()),
            title: 'Quality',
            subtitle: 'Set the quality level, higher value generate larger files',
          ),
        ),
        BlocSelector<ParameterCubit, Parameters, int>(
          selector: (state) => state.quality,
          builder: (context, state) => Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 4.0,
            ),
            child: InputDecorator(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                label: const Text('Output folder'),
                suffixIcon: IconButton(
                  onPressed: BlocProvider.of<ParameterCubit>(context).changeOutputDirectory,
                  icon: const Icon(Icons.folder_outlined),
                ),
              ),
              child: BlocSelector<ParameterCubit, Parameters, String>(
                selector: (state) => state.outputFolder,
                builder: (context, state) => Text(state),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
