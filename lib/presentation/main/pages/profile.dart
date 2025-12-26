import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_bloc/common/helpers/user_preferences.dart';
import 'package:todolist_bloc/common/widgets/export_widgets.dart';
import 'package:todolist_bloc/presentation/auth/pages/login.dart';
import 'package:todolist_bloc/presentation/export_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Text(
              "Username",
              style: textStyles(25, kWhite, semiBold),
            ),
            SizedBox(height: 10.h),
            BlocBuilder<ToDoListCubit, ToDoListState>(
              builder: (context, state) {
                return Text(
                  context.read<ToDoListCubit>().username,
                  style: textStyles(25, kWhite, semiBold),
                );
              },
            ),
            SizedBox(height: 40.h),
            BlocBuilder<ToDoListCubit, ToDoListState>(
              builder: (context, state) {
                if (state is ToDoListLoading) {
                  return const Center(child: LoadingIndicator());
                } else if (state is ToDoListLoaded) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 15.h),
                        decoration: BoxDecoration(
                          color: kGrey,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "${state.todos.length} Task left",
                          style: textStyles(14, kWhite, reguler),
                        ),
                      ),
                      SizedBox(width: 15.w),
                      BlocBuilder<ToDoListCompleteCubit, ToDoListCompleteState>(
                        builder: (context, state) {
                          if (state is ToDoListCompleteLoading) {
                            return const Center(child: LoadingIndicator());
                          } else if (state is ToDoListCompleteLoaded) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 15.h),
                              decoration: BoxDecoration(
                                color: kGrey,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                "${state.todos.length} Task done",
                                style: textStyles(14, kWhite, reguler),
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
            SizedBox(height: 250.h),
            InkWell(
              onTap: () {
                customDialog(
                  content: "Are you sure want to logout?",
                  onConfirm: () async {
                    await UserPreferences().logout();
                    customNavigation(() => const LoginPage(), isOffAll: true);
                  },
                );
              },
              child: SizedBox(
                width: 160.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.exit_to_app,
                      color: kRed,
                      size: 30,
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      "Logout",
                      style: textStyles(25, kRed, reguler),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
