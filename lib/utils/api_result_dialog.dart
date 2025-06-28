import 'package:flutter/material.dart';
import 'package:translife_google_signin/models/sql_result_model.dart';

class ApiResultDialog {

  static void showInfoDialog({
    required BuildContext context,
    required String title,
    required String description,
    String confirmButton = 'OK', }) {
    showDialog(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(
            title: Text(title),
            content: Text(description),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(confirmButton),
              )
            ],
          ),
    );
  }

  static void showErrorDialog({
    required BuildContext context,
    required SQLResultmodel model,
  }) {
    String message = '''
    Error Message: ${model.errorMessage }
    SQL Message: ${model.sqlErrorMessage }
    Error No: ${model.errorNo}
    SQL Error Number: ${model.sqlErrorNumber}
    SQL Severity: ${model.sqlErrorSeverity}
    SQL State: ${model.sqlErrorState}
    Object: ${model.sqlObjectName }
    Line No: ${model.sqlErrorLineNo}
    ''';

    showDialog(context: context, builder: (BuildContext context) =>
        AlertDialog(
          title: const Text("Server Error"),
          content: Text(message),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(),
              child: const Text("Ok"),
            ),
          ],
        ));
  }
}