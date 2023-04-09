import 'dart:io';

import 'package:epic_skies/features/location/bloc/location_bloc.dart';
import 'package:epic_skies/features/location/search/models/search_suggestion/search_suggestion.dart';
import 'package:epic_skies/global/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchDialogs {
  static void confirmDeleteSearch({
    required SearchSuggestion suggestion,
    required BuildContext context,
  }) {
    final remoteLocationBloc = context.read<LocationBloc>();

    final content =
        'Delete ${suggestion.description} from your search history?';
    const delete = 'Delete';
    const goBack = 'Go back';

    void deleteSearch() {
      remoteLocationBloc.add(
        LocationDeleteSelectedSearch(searchSuggestion: suggestion),
      );
      Navigator.of(context).pop();
    }

    final dialog = Platform.isIOS
        ? CupertinoAlertDialog(
            content: Text(content, style: iOSContentTextStyle),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(goBack),
              ),
              CupertinoDialogAction(
                onPressed: deleteSearch,
                isDestructiveAction: true,
                child: const Text(delete),
              ),
            ],
          )
        : AlertDialog(
            content: Text(content),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(goBack, style: dialogActionTextStyle),
              ),
              TextButton(
                onPressed: deleteSearch,
                child: Text(
                  delete,
                  style: dialogActionTextStyle.copyWith(color: Colors.red),
                ),
              ),
            ],
          );
    showDialog<void>(context: context, builder: (context) => dialog);
  }

  static void confirmClearSearchHistory(BuildContext context) {
    const content = 'Delete your entire search history?';
    const delete = 'Delete';
    const goBack = 'Go back';

    void clearSearchHistory() {
      context.read<LocationBloc>().add(LocationClearSearchHistory());
      Navigator.of(context).pop();
    }

    final dialog = Platform.isIOS
        ? CupertinoAlertDialog(
            content: const Text(
              content,
              style: iOSContentTextStyle,
            ),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(goBack),
              ),
              CupertinoDialogAction(
                onPressed: clearSearchHistory,
                isDestructiveAction: true,
                child: const Text(delete),
              ),
            ],
          )
        : AlertDialog(
            content: const Text(content),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(goBack, style: dialogActionTextStyle),
              ),
              TextButton(
                onPressed: clearSearchHistory,
                child: Text(
                  delete,
                  style: dialogActionTextStyle.copyWith(color: Colors.red),
                ),
              ),
            ],
          );

    showDialog<void>(context: context, builder: (context) => dialog);
  }

  static void selectSearchFromListDialog(BuildContext context) {
    const content = 'Please select location from list';
    const goBack = 'Got it!';

    final dialog = Platform.isIOS
        ? CupertinoAlertDialog(
            content: const Text(content, style: iOSContentTextStyle),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(goBack),
              ),
            ],
          )
        : AlertDialog(
            content: const Text(content),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(goBack, style: dialogActionTextStyle),
              ),
            ],
          );

    showDialog<void>(context: context, builder: (context) => dialog);
  }
}
