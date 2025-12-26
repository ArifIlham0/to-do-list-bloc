import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_bloc/common/widgets/export_widgets.dart';
import 'package:todolist_bloc/presentation/export_cubit.dart';

class LoadingIndicatorCubit<C extends Cubit<S>, S> extends StatelessWidget {
  const LoadingIndicatorCubit({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<C, S>(
      builder: (context, state) {
        if ((state is ToDoListLoadingStack) ||
            (state is ToDoListOverdueLoadingStack)) {
          return Container(
            color: kBlack.withOpacity(0.6),
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
        return const SizedBox.shrink();
      },
    );
  }
}
