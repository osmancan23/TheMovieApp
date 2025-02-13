import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_app/core/base/viewModel/base_view_model.dart';

class IBaseView<T extends IBaseViewModel> extends StatelessWidget {
  const IBaseView({
    required this.viewModel,
    required this.builder,
    super.key,
  });

  final Widget Function(BuildContext context, T viewModel) builder;
  final T viewModel;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: viewModel,
      child: Consumer<T>(
        builder: (context, model, _) => builder(context, model),
      ),
    );
  }
}
