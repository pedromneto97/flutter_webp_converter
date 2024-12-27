import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../core/utils/localizations.dart';
import 'cubit/file_selector_cubit/file_selector_cubit.dart';
import 'cubit/parameter_cubit/parameter_cubit.dart';
import 'widgets/about_button.dart';
import 'widgets/converter_actions.dart';
import 'widgets/list_title.dart';
import 'widgets/parameters_form.dart';
import 'widgets/selected_images.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<FileSelectorCubit>(
            create: (context) => GetIt.I.get<FileSelectorCubit>(),
          ),
          BlocProvider<ParameterCubit>(
            create: (context) => GetIt.I.get<ParameterCubit>(),
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: Text(context.strings.title),
          ),
          endDrawer: Drawer(
            width: MediaQuery.of(context).size.width * 0.3,
            child: const ParametersForm(),
          ),
          body: const Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            child: Column(
              spacing: 12,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      ListTitle(),
                      SelectedImages(),
                    ],
                  ),
                ),
                ConverterActions(),
                SafeArea(
                  child: AboutButton(),
                ),
              ],
            ),
          ),
        ),
      );
}
