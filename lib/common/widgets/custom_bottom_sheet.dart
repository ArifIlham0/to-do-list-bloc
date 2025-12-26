import 'package:flutter/material.dart';
import 'package:todolist_bloc/common/widgets/export_widgets.dart';
import 'package:todolist_bloc/domain/todo/entities/todo.dart';

Future<void> customBottomSheet({
  required BuildContext context,
  required TextEditingController title,
  required TextEditingController description,
  required Function() onPressed,
  required Function() onPressed2,
  required VoidCallback onDismiss,
  GlobalKey<FormState>? formKey,
  DateTime? time,
  TodoEntity? todo,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            height: 310.h,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: kGrey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Task',
                        style: textStyles(18, kWhite, FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  CustomTextField(
                    isTask: true,
                    controller: title,
                    hintText: 'Title',
                    keyboardType: TextInputType.text,
                    validator: (title) {
                      if (title!.isEmpty) {
                        return 'Title cannot be empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15.h),
                  CustomTextField(
                    isTask: true,
                    controller: description,
                    hintText: 'Description',
                    keyboardType: TextInputType.text,
                    validator: (description) {
                      if (description!.isEmpty) {
                        return 'Description cannot be empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: onPressed,
                        icon: const Icon(
                          Icons.timer_sharp,
                          color: kWhite,
                          size: 30,
                        ),
                      ),
                      IconButton(
                        onPressed: onPressed2,
                        icon: const Icon(
                          Icons.send,
                          color: kPurple,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  ).whenComplete(onDismiss);
}
