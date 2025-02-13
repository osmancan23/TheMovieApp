import 'package:flutter/material.dart';
import 'package:the_movie_app/core/base/view/base_view.dart';
import 'package:the_movie_app/core/constants/text_constants.dart';
import 'package:the_movie_app/core/init/cache/cache_manager.dart';
import 'package:the_movie_app/feature/home/components/movieList/movie_grid_view.dart';
import 'package:the_movie_app/feature/home/components/search/search_field_widget.dart';
import 'package:the_movie_app/feature/home/viewModel/home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return IBaseView<HomeViewModel>(
      viewModel: HomeViewModel(),
      builder: (context, viewModel) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(TextConstants.appTitle),
            actions: [
              IconButton(
                icon: const Icon(Icons.favorite_border_outlined),
                onPressed: () => viewModel.navigateToFavorites(context),
              ),
            ],
          ),
          body: Column(
            children: [
              SearchFieldWidget(
                onChanged: viewModel.onSearchQueryChanged,
              ),
              Expanded(
                child: MovieGridView(
                  movies: viewModel.movies,
                  isLoading: viewModel.isLoading,
                  searchQuery: viewModel.searchQuery,
                  onFavoritePressed: viewModel.toggleFavorite,
                  isMovieFavorite: CacheManager.isMovieFavorite,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
