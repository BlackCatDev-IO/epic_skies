import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/features/location/bloc/location_bloc.dart';
import 'package:epic_skies/features/location/search/bloc/search_bloc.dart';
import 'package:epic_skies/view/widgets/labels/rounded_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class RecentSearchesLabel extends StatelessWidget {
  const RecentSearchesLabel({
    required this.isSearchPage,
    super.key,
  });

  final bool isSearchPage;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, searchState) {
        return BlocBuilder<LocationBloc, LocationState>(
          builder: (context, state) {
            late bool showLabel;
            if (isSearchPage) {
              showLabel =
                  state.searchHistory.isEmpty && searchState.query == '';
            } else {
              showLabel = state.searchHistory.isEmpty;
            }
            return showLabel
                ? RoundedLabel(
                    label: 'No recent searches',
                    fontWeight: FontWeight.w400,
                    width: 160,
                    fontSize: 10.sp,
                  ).paddingOnly(top: 10)
                : const SizedBox();
          },
        );
      },
    );
  }
}
