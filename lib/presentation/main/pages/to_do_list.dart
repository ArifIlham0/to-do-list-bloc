import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_bloc/common/widgets/export_widgets.dart';
import 'package:todolist_bloc/presentation/export_cubit.dart';

class ToDoListPage extends StatelessWidget {
  const ToDoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBlack,
        centerTitle: true,
        scrolledUnderElevation: 0.0,
        title: Text(
          'Task',
          style: textStyles(18, kWhite, reguler),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: 400.h,
                child: BlocBuilder<ToDoListCubit, ToDoListState>(
                  builder: (context, state) {
                    if (state is ToDoListLoading) {
                      return const LoadingIndicator();
                    } else if (state is FailureLoadedToDoList) {
                      return Center(
                        child: Text(
                          state.message,
                          style: textStyles(16, kWhite, reguler),
                        ),
                      );
                    } else if (state is ToDoListLoaded ||
                        state is ToDoListLoadingStack) {
                      final todos = state is ToDoListLoaded
                          ? state.todos
                          : (state as ToDoListLoadingStack).todos;

                      if (todos.isEmpty) {
                        return Center(
                          child: Text(
                            "No Task",
                            style: textStyles(16, kWhite, reguler),
                          ),
                        );
                      }

                      return RefreshIndicator(
                        color: kPurple,
                        backgroundColor: kGrey,
                        onRefresh: () async {
                          context.read<ToDoListCubit>().fetchTodos();
                        },
                        child: ListView(
                          children: todos.map((todos) {
                            var cubit = context.read<ToDoListCubit>();

                            return ToDoList(
                              todos: todos,
                              isSelected: state is ToDoListLoaded &&
                                  state.selectedTodos.contains(todos.id),
                              onTap: () {
                                cubit.onTodoTap(
                                  todos,
                                  context,
                                  cubit.title,
                                  cubit.description,
                                  cubit.formattedDateTime,
                                );
                              },
                              onLongPress: () {
                                cubit.onTodoLongPress(todos.id ?? 0);
                              },
                              onPressed: () {
                                cubit.markTodoCompleted(todos, context);
                              },
                            );
                          }).toList(),
                        ),
                      );
                    } else {
                      return Center(
                        child: Text(
                          "Something went wrong",
                          style: textStyles(16, kWhite, reguler),
                        ),
                      );
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                      decoration: BoxDecoration(
                        color: kGrey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        "Overdue",
                        style: textStyles(14, kWhite, reguler),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 200.h,
                child: BlocBuilder<ToDoListOverdueCubit, ToDoListOverdueState>(
                  builder: (context, state) {
                    if (state is ToDoListOverdueLoading) {
                      return const LoadingIndicator();
                    } else if (state is FailureLoadedToDoListOverdue) {
                      return Center(
                        child: Text(
                          state.message,
                          style: textStyles(16, kWhite, reguler),
                        ),
                      );
                    } else if (state is ToDoListOverdueLoaded ||
                        state is ToDoListOverdueLoadingStack) {
                      final todos = state is ToDoListOverdueLoaded
                          ? state.todos
                          : (state as ToDoListOverdueLoadingStack).todos;

                      if (todos.isEmpty) {
                        return Center(
                          child: Text(
                            "No Overdue Task",
                            style: textStyles(16, kWhite, reguler),
                          ),
                        );
                      }

                      return RefreshIndicator(
                        color: kPurple,
                        backgroundColor: kGrey,
                        onRefresh: () async {
                          context
                              .read<ToDoListOverdueCubit>()
                              .fetchTodosOverdue();
                        },
                        child: ListView(
                          children: todos.map((todos) {
                            var cubit = context.read<ToDoListOverdueCubit>();

                            return ToDoListOverdue(
                              todos: todos,
                              isSelected: state is ToDoListOverdueLoaded &&
                                  state.selectedTodos.contains(todos.id),
                              onTap: () => cubit.onTodoLongPress(todos.id ?? 0),
                              onLongPress: () =>
                                  cubit.onTodoLongPress(todos.id ?? 0),
                            );
                          }).toList(),
                        ),
                      );
                    } else {
                      return Center(
                        child: Text(
                          "Something went wrong",
                          style: textStyles(16, kWhite, reguler),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
          const DeleteButtonCubit<ToDoListCubit, ToDoListState>(),
          const DeleteButtonCubit<ToDoListOverdueCubit, ToDoListOverdueState>(),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                var cubit = context.read<ToDoListCubit>();
                cubit.openAddTodoModal(context, cubit.title, cubit.description);
              },
              backgroundColor: kPurple,
              child: const Icon(Icons.add, color: kWhite),
            ),
          ),
          const LoadingIndicatorCubit<ToDoListCubit, ToDoListState>(),
          const LoadingIndicatorCubit<ToDoListOverdueCubit,
              ToDoListOverdueState>(),
        ],
      ),
    );
  }
}
