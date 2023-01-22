import 'package:black_cat_lib/widgets/buttons.dart';
import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/services/view_controllers/color_cubit/color_cubit.dart';
import 'package:epic_skies/view/dialogs/search_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:sizer/sizer.dart';

import '../../../features/location/bloc/location_bloc.dart';
import '../../../features/location/search/bloc/search_bloc.dart';

class DeleteSavedLocationsButton extends StatelessWidget {
  const DeleteSavedLocationsButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ColorCubit, ColorState>(
      builder: (context, colorState) {
        return BlocBuilder<SearchBloc, SearchState>(
          builder: (context, searchState) {
            return BlocBuilder<LocationBloc, LocationState>(
              builder: (context, state) {
                final showDeleteSearchesButtton =
                    searchState.query.isEmpty && state.searchHistory.isNotEmpty;
                return Visibility(
                  visible: showDeleteSearchesButtton,
                  child: KeyboardVisibilityBuilder(
                    builder: (context, isKeyboardVisible) {
                      return Visibility(
                        visible: !isKeyboardVisible,
                        child: DefaultButton(
                          buttonColor: colorState.theme.soloCardColor,
                          label: 'Delete Search History',
                          onPressed: () =>
                              SearchDialogs.confirmClearSearchHistory(
                            context,
                          ),
                          fontSize: 14.sp,
                          fontColor: Colors.white70,
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        );
      },
    ).paddingSymmetric(vertical: 10, horizontal: 10);
  }
}
