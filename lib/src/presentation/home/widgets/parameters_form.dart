import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/localizations.dart';
import '../../../domain/domain.dart';
import '../../../widgets/slider_with_label.dart';
import '../cubit/parameter_cubit/parameter_cubit.dart';

class ParametersForm extends StatelessWidget {
  const ParametersForm({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DrawerHeader(
          child: Text(
            strings.conversionParameters,
          ),
        ),
        BlocSelector<ParameterCubit, Parameters, bool>(
          selector: (state) => state.multiThreading,
          builder: (context, state) => CheckboxListTile(
            title: Text(strings.multiThreading),
            subtitle: Text(strings.multiThreadingDescription),
            value: state,
            onChanged: (value) => BlocProvider.of<ParameterCubit>(context)
                .changeMultiThreading(isMultiThreading: value!),
            dense: true,
          ),
        ),
        BlocSelector<ParameterCubit, Parameters, bool>(
          selector: (state) => state.lossless,
          builder: (context, state) => CheckboxListTile(
            title: Text(strings.lossless),
            subtitle: Text(strings.losslessDescription),
            dense: true,
            value: state,
            onChanged: (value) => BlocProvider.of<ParameterCubit>(context)
                .changeLossless(lossless: value!),
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
            onChanged: (value) => BlocProvider.of<ParameterCubit>(context)
                .changeCompression(value.toInt()),
            title: strings.compressionMethod,
            subtitle: strings.compressionMethodDescription,
          ),
        ),
        BlocSelector<ParameterCubit, Parameters, double>(
          selector: (state) => state.quality,
          builder: (context, state) => SliderWithLabel(
            min: 0.0,
            max: 100.0,
            divisions: 100,
            value: state,
            label: state.toString(),
            onChanged: BlocProvider.of<ParameterCubit>(context).changeQuality,
            title: strings.quality,
            subtitle: strings.qualityDescription,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 4.0,
          ),
          child: InputDecorator(
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              label: Text(strings.outputFolder),
              suffixIcon: IconButton(
                onPressed: BlocProvider.of<ParameterCubit>(context)
                    .changeOutputDirectory,
                icon: const Icon(Icons.folder_outlined),
              ),
            ),
            child: BlocSelector<ParameterCubit, Parameters, String>(
              selector: (state) => state.outputFolder,
              builder: (context, state) => Text(state),
            ),
          ),
        ),
      ],
    );
  }
}
