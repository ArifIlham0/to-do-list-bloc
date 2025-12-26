import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_bloc/common/widgets/export_widgets.dart';
import 'package:todolist_bloc/presentation/export_cubit.dart';
import 'package:todolist_bloc/presentation/export_pages.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  final List<Widget> topLevelPages = const [
    ToDoListPage(),
    CompletedToDoPage(),
    ProfilePage(),
  ];

  void onPageChanged(int page) {
    BlocProvider.of<BottomNavCubit>(context).changeSelectedIndex(page);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ToDoListCubit()
            ..fetchTodos()
            ..fetchUserPreferences(),
        ),
        BlocProvider(
            create: (context) => ToDoListOverdueCubit()..fetchTodosOverdue()),
        BlocProvider(
            create: (context) => ToDoListCompleteCubit()..fetchTodosComplete()),
      ],
      child: Scaffold(
        body: PageView(
          controller: pageController,
          onPageChanged: (page) => onPageChanged(page),
          children: topLevelPages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: kGrey,
          currentIndex: context.watch<BottomNavCubit>().state,
          onTap: (index) {
            pageController.jumpToPage(index);
            onPageChanged(index);
          },
          selectedItemColor: kWhite,
          iconSize: 30.w,
          items: [
            BottomNavigationBarItem(
              icon: context.watch<BottomNavCubit>().state != 0
                  ? const Icon(Icons.task_outlined)
                  : const Icon(Icons.task_rounded),
              label: 'Task',
            ),
            BottomNavigationBarItem(
              icon: context.watch<BottomNavCubit>().state != 1
                  ? const Icon(Icons.check_circle_outlined)
                  : const Icon(Icons.check_circle),
              label: 'Completed',
            ),
            BottomNavigationBarItem(
              icon: context.watch<BottomNavCubit>().state != 2
                  ? const Icon(Icons.person_pin_outlined)
                  : const Icon(Icons.person_pin_rounded),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
