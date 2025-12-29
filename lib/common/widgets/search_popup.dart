import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_bloc/common/widgets/export_widgets.dart';
import 'package:todolist_bloc/data/export_data.dart';
import 'package:todolist_bloc/presentation/export_cubit.dart';

class SearchPopup extends StatefulWidget {
  const SearchPopup({super.key, required this.onClose});
  
  final void Function() onClose;

  @override
  State<SearchPopup> createState() => _SearchPopupState();
}

class _SearchPopupState extends State<SearchPopup> {
  final controller = TextEditingController();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (event, state) {
        if (state is CategoryLoaded) {
          return Container(
            width: 260,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: kDarkGrey,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: controller,
                  style: textStyles(13, kWhite, reguler),
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle: textStyles(13, kGrey, reguler),
                    prefixIcon: const Icon(Icons.search, color: kGrey, size: 18),
                    isDense: true,
                    filled: true,
                    fillColor: kBlack,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onSubmitted: (_) => applyFilter(context, state.data),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 32,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.data.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final isSelected = index == selectedIndex;
          
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                          applyFilter(context, state.data);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected ? kPurple : kBlack,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            state.data[index].label ?? "",
                            style: textStyles(
                              12,
                              isSelected ? kWhite : kGrey,
                              semiBold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      }
    );
  }

  void applyFilter(BuildContext context, List<DatumCategory> data) {
    context.read<ExperimentCubit>()
      ..name = controller.text
      ..category = data[selectedIndex].label == 'All'
          ? ''
          : data[selectedIndex].label?.toLowerCase() ?? ""
      ..fetchExperiments();

    widget.onClose();
  }
}