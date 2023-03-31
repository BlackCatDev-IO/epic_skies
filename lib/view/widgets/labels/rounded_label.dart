import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/services/view_controllers/color_cubit/color_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoundedLabel extends StatelessWidget {
  const RoundedLabel({
    super.key,
    required this.label,
    this.labelColor,
    this.fontSize,
    this.width,
    this.height,
    this.fontWeight,
    this.icon,
  });

  final String label;
  final Color? labelColor;
  final double? fontSize;
  final double? width;
  final double? height;
  final FontWeight? fontWeight;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ColorCubit, ColorState>(
      builder: (context, state) {
        return RoundedContainer(
          width: width ?? 175,
          height: height,
          radius: 25,
          color: state.theme.roundedLabelColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon == null) const SizedBox() else icon!,
              MyTextWidget(
                text: label,
                fontSize: fontSize ?? 11,
                fontWeight: fontWeight,
                color: state.theme.roundedLabelColor == Colors.white54
                    ? Colors.black
                    : Colors.white70,
              ).center().paddingSymmetric(vertical: 2.5, horizontal: 10),
            ],
          ),
        );
      },
    );
  }
}
