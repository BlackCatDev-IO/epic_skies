import 'package:epic_skies/features/location/bloc/location_bloc.dart';
import 'package:epic_skies/features/location/search/models/search_suggestion/search_suggestion.dart';
import 'package:epic_skies/view/dialogs/platform_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchDialogs {
  static const goBack = 'Go back';
  static const delete = 'Delete';

  static void confirmDeleteSearch(
    BuildContext context, {
    required SearchSuggestion suggestion,
  }) {
    final remoteLocationBloc = context.read<LocationBloc>();

    final content =
        'Delete ${suggestion.description} from your search history?';

    void deleteSearch() {
      remoteLocationBloc.add(
        LocationDeleteSelectedSearch(searchSuggestion: suggestion),
      );
      Navigator.of(context).pop();
    }

    final actions = {
      goBack: () => Navigator.of(context).pop(),
      delete: deleteSearch,
    };

    Dialogs.showPlatformDialog(
      context,
      stringContent: content,
      dialogActions: actions,
    );
  }

  static void confirmClearSearchHistory(BuildContext context) {
    const content = 'Delete your entire search history?';

    void clearSearchHistory() {
      context.read<LocationBloc>().add(LocationClearSearchHistory());
      Navigator.of(context).pop();
    }

    final actions = {
      goBack: () => Navigator.of(context).pop(),
      delete: clearSearchHistory,
    };

    Dialogs.showPlatformDialog(
      context,
      stringContent: content,
      dialogActions: actions,
    );
  }

  static void selectSearchFromListDialog(BuildContext context) {
    const content = 'Please select location from list';

    final actions = {
      'Got it!': () => Navigator.of(context).pop(),
    };

    Dialogs.showPlatformDialog(
      context,
      stringContent: content,
      dialogActions: actions,
    );
  }
}
