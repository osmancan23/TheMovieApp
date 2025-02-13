import 'package:flutter/material.dart';
import 'package:the_movie_app/core/constants/app_constants.dart';
import 'package:the_movie_app/core/constants/padding_constants.dart';
import 'package:the_movie_app/core/constants/text_constants.dart';
import 'package:the_movie_app/core/utils/animation_helper.dart';

class SearchFieldWidget extends StatelessWidget {
  const SearchFieldWidget({
    required this.onChanged,
    super.key,
  });

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return AnimationHelper.slideInTransition(
      child: Padding(
        padding: const EdgeInsets.all(PaddingConstants.medium),
        child: TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: TextConstants.searchHint,
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.radiusM),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: PaddingConstants.medium,
              vertical: PaddingConstants.small,
            ),
          ),
        ),
      ),
    );
  }
}
