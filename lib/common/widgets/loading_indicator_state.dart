import 'package:flutter/material.dart';
import 'package:todolist_bloc/common/widgets/export_widgets.dart';

class LoadingIndicatorState extends StatelessWidget {
  const LoadingIndicatorState({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBlack.withAlpha(153),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 140.w, vertical: 290.h),
        decoration: BoxDecoration(
          color: kBlack,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const LoadingIndicator(
          evenOne: kPurple,
          evenTwo: kDarkGrey,
        ),
      ),
    );
  }
}
