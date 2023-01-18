import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../features/location/bloc/location_bloc.dart';
import '../../../features/location/search/bloc/search_bloc.dart';
import 'rounded_label.dart';

class RecentSearchesLabel extends StatelessWidget {
  const RecentSearchesLabel({required this.isSearchPage});

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
