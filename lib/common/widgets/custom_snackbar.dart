import 'package:flutter/material.dart';
import 'package:todolist_bloc/common/widgets/export_widgets.dart';

SnackbarController? customSnackbar(String text, {Color? color}) {
  if (SnackbarController.isSnackbarBeingShown == false) {
    return Get.snackbar(
      "",
      text,
      titleText: const SizedBox.shrink(),
      duration: const Duration(milliseconds: 1500),
      backgroundColor: color ?? kPurple,
      borderRadius: 10,
      messageText: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              text,
              style: textStyles(14, kWhite, medium),
              maxLines: null,
            ),
          ),
          const SizedBox(width: 16),
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Text(
              "Close",
              style: textStyles(14, kBlack, medium),
            ),
          ),
        ],
      ),
    );
  } else {
    return null;
  }
}
