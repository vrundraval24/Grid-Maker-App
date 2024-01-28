import 'package:flutter/material.dart';

class WarningDialog {
  final BuildContext context;
  final String dialogTitle;
  final String dialogMessage;
  final String okButtonName;
  final String cancelButtonName;
  final Function action;

  WarningDialog({
    required this.context,
    required this.dialogTitle,
    required this.dialogMessage,
    required this.okButtonName,
    required this.cancelButtonName,
    required this.action,
  });

  warningDialogFunction() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: Text(dialogTitle),
          content: Text(dialogMessage),
          actions: [
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                      side: const BorderSide(color: Colors.black))),
              child: Text(cancelButtonName),
            ),
            ElevatedButton(
              onPressed: () {
                action();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                  side: const BorderSide(color: Colors.redAccent),
                ),
              ),
              child: Text(okButtonName),
            ),
          ],
        );
      },
    );
  }
}
