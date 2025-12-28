import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todolist_bloc/common/widgets/export_widgets.dart';
import 'package:todolist_bloc/data/todo/models/request/to_do_request.dart';
import 'package:todolist_bloc/presentation/export_cubit.dart';

class CompletedToDoPage extends StatelessWidget {
  const CompletedToDoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBlack,
        centerTitle: true,
        scrolledUnderElevation: 0.0,
        title: Text(
          'Complete Task',
          style: textStyles(18, kWhite, reguler),
        ),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<ToDoListCompleteCubit, ToDoListCompleteState>(
                builder: (context, state) {
                  if (state is ToDoListCompleteLoading) {
                    return const LoadingIndicator();
                  } else if (state is FailureLoadedToDoListComplete) {
                    return Center(
                      child: Text(
                        state.message,
                        style: textStyles(16, kWhite, reguler),
                      ),
                    );
                  } else if (state is ToDoListCompleteLoaded ||
                      state is ToDoListCompleteLoadingStack) {
                    final todos = state is ToDoListCompleteLoaded
                        ? state.todos
                        : (state as ToDoListCompleteLoadingStack).todos;

                    if (todos.isEmpty) {
                      return Center(
                        child: Text(
                          "No Complete Task",
                          style: textStyles(16, kWhite, reguler),
                        ),
                      );
                    }

                    return Expanded(
                      child: RefreshIndicator(
                        color: kPurple,
                        backgroundColor: kGrey,
                        onRefresh: () async {
                          context
                              .read<ToDoListCompleteCubit>()
                              .fetchTodosComplete();
                        },
                        child: ListView(
                          children: todos.map((todos) {
                            var cubit = context.read<ToDoListCompleteCubit>();

                            return ToDoList(
                              todos: todos,
                              isSelected: state is ToDoListCompleteLoaded &&
                                  state.selectedTodos.contains(todos.id),
                              isCompleted: true,
                              onTap: () {
                                if (state is ToDoListCompleteLoaded) {
                                  if (state.isSelectionMode) {
                                    cubit.onTodoLongPress(todos.id ?? 0);
                                  }
                                }
                              },
                              onLongPress: () {
                                cubit.isSelectionMode = true;
                                cubit.onTodoLongPress(todos.id ?? 0);
                              },
                              onPressed: () {
                                String formattedDateTime = DateTime.now().toUtc().toIso8601String();
                                formattedDateTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(DateTime.parse(todos.dueDate ?? ""));

                                cubit.updateTodo(
                                  todos.id.toString(),
                                  ToDoRequest(
                                    title: todos.title,
                                    description: todos.description,
                                    dueDate: DateTime.parse(formattedDateTime),
                                    isCompleted: false,
                                  ),
                                  context,
                                );
                              },
                            );
                          }).toList(),
                        ),
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
            ],
          ),
          BlocBuilder<ToDoListCompleteCubit, ToDoListCompleteState>(
            builder: (context, state) {
              if (state is ToDoListCompleteLoaded && state.isSelectionMode) {
                return Positioned(
                  bottom: 20,
                  left: 20,
                  child: FloatingActionButton(
                    onPressed: () {
                      context
                          .read<ToDoListCompleteCubit>()
                          .confirmDeleteSelectedTodos(context);
                    },
                    backgroundColor: kRed,
                    child: const Icon(Icons.delete, color: kWhite),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          BlocBuilder<ToDoListCompleteCubit, ToDoListCompleteState>(
            builder: (context, state) {
              if (state is ToDoListCompleteLoadingStack) {
                return Container(
                  color: kBlack.withAlpha(153),
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: 140.w, vertical: 290.h),
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
          ),
        ],
      ),
    );
  }
}
