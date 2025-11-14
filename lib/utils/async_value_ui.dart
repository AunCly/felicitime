import 'package:felicitime/utils/string_hardcoded.dart';
import 'package:felicitime/ui/widgets/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AsyncValueUI on AsyncValue {

  void showSnackBarOnError(BuildContext context){
    if (!isLoading && hasError) {
      showSnackBar(
        context: context,
        title: 'Error'.hardcoded,
        content: error.toString().replaceAll('Exception: ', ''),
      );
    }
  }

  void showSnackBarOnSuccess(BuildContext context, String text){
    if (!isLoading && !hasError) {
      showSnackBar(
        context: context,
        title: 'Success'.hardcoded,
        content: text,
      );
    }
  }

  void showAlertDialogOnError(BuildContext context) {
    if (!isLoading && hasError) {
      showExceptionAlertDialog(
        context: context,
        title: 'Error'.hardcoded,
        exception: error,
      );
    }
  }
}
