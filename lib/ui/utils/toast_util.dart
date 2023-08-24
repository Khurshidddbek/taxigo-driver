import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:taxigo_driver/ui/widgets/progress_dialog.dart';

class ToastUtil {
  static void showSnackbar(BuildContext context, String? text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Center(child: Text(text ?? "")),
    ));

    log("ToastUtil.showSnackbar: $text");
  }

  static void showProgressDialog(BuildContext context, String text) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => ProgressDialog(status: text),
    );

    log("ToastUtil.showDialog: $text");
  }

  static void closeDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();

    log("ToastUtil.closeDialog");
  }
}
