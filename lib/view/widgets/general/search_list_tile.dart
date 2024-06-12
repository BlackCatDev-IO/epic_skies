import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/features/location/bloc/location_bloc.dart';
import 'package:epic_skies/features/location/search/models/search_suggestion/search_suggestion.dart';
import 'package:epic_skies/features/location/search/models/search_text/search_text.dart';
import 'package:epic_skies/services/view_controllers/color_cubit/color_cubit.dart';
import 'package:epic_skies/view/dialogs/search_dialogs.dart';
import 'package:epic_skies/view/widgets/containers/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchListTile extends StatelessWidget {
  const SearchListTile({
    required this.suggestion,
    required this.searching,
    super.key,
  });

  final SearchSuggestion suggestion;
  final bool searching;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ColorCubit, ColorState>(
      builder: (context, state) {
        return RoundedContainer(
          color: state.theme.soloCardColor,
          radius: 7,
          child: ListTile(
            title: !searching
                ? Text(
                    suggestion.description,
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  )
                : _SearchTextWidget(
                    searchTextList: suggestion.searchTextList!,
                  ),
            onTap: () async {
              context.read<LocationBloc>().add(
                    LocationUpdateRemote(
                      searchSuggestion: suggestion,
                    ),
                  );
            },
            trailing: searching
                ? const SizedBox()
                : IconButton(
                    onPressed: () => SearchDialogs.confirmDeleteSearch(
                      context,
                      suggestion: suggestion,
                    ),
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.white38,
                      size: 25,
                    ),
                  ),
          ),
        ).paddingSymmetric(vertical: 2.5);
      },
    );
  }
}

class _SearchTextWidget extends StatelessWidget {
  const _SearchTextWidget({required this.searchTextList});

  final List<SearchText> searchTextList;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: searchTextList
          .map(
            (searchText) => Text(
              searchText.text,
              style: TextStyle(
                fontWeight: searchText.isBold ? FontWeight.bold : null,
              ),
            ),
          )
          .toList(),
    );
  }
}
