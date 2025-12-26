import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_bloc/common/widgets/export_widgets.dart';
import 'package:todolist_bloc/presentation/export_cubit.dart';

class DeleteButtonCubit<C extends Cubit<S>, S> extends StatelessWidget {
  const DeleteButtonCubit({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<C, S>(
      builder: (context, state) {
        if ((state is ToDoListLoaded && state.isSelectionMode) ||
            (state is ToDoListOverdueLoaded && state.isSelectionMode)) {
          return Positioned(
            bottom: 20,
            left: 20,
            child: FloatingActionButton(
              onPressed: () {
                if (state is ToDoListLoaded) {
                  context.read<ToDoListCubit>().confirmDeleteSelectedTodos();
                } else if (state is ToDoListOverdueLoaded) {
                  context
                      .read<ToDoListOverdueCubit>()
                      .confirmDeleteSelectedTodos();
                }
              },
              backgroundColor: kRed,
              child: const Icon(Icons.delete, color: kWhite),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
