import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:todolist_bloc/common/widgets/export_widgets.dart';

void customDialog({
  required String content,
  String confirmText = "Yes",
  String cancelText = "No",
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
}) {
  if (Platform.isIOS) {
    Get.dialog(
      CupertinoAlertDialog(
        content: Text(
          content,
          style:
              TextStyle(color: Colors.black, fontWeight: reguler, fontSize: 14),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: onCancel ?? () => Get.back(),
            child: Text(
              "Cancel",
              style: TextStyle(color: kBlue, fontWeight: reguler, fontSize: 14),
            ),
          ),
          CupertinoDialogAction(
            onPressed: onConfirm ?? () => Get.back(),
            child: Text(
              "OK",
              style: TextStyle(color: kBlue, fontWeight: reguler, fontSize: 14),
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  } else {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        content: Text(
          content,
          style: textStyles(14, kWhite, semiBold),
        ),
        backgroundColor: kGrey,
        actions: [
          SizedBox(
            width: 80.w,
            height: 30.h,
            child: ElevatedButton(
              onPressed: onCancel ?? () => Get.back(),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(kGrey),
                side: WidgetStateProperty.all<BorderSide>(
                    const BorderSide(color: kPurple)),
                shape: WidgetStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                )),
              ),
              child: Text(
                cancelText,
                style: textStyles(12, kPurple, semiBold),
              ),
            ),
          ),
          SizedBox(
            width: 80.w,
            height: 30.h,
            child: ElevatedButton(
              onPressed: onConfirm ?? () => Get.back(),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(kPurple),
                side: WidgetStateProperty.all<BorderSide>(
                    const BorderSide(color: kPurple)),
                shape: WidgetStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                )),
              ),
              child: Text(
                confirmText,
                style: textStyles(12, kWhite, semiBold),
              ),
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
