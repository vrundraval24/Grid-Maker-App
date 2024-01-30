import 'package:flutter/material.dart';

import '../models/grid_model.dart';
import '../widgets/custom_warning_dialog.dart';

class LeaveEditingPageHandler {
  static Future<void> leaveEditingPage(BuildContext context) async {
    final warningDialogInstance = WarningDialog(
      context: context,
      dialogTitle: 'Discard Changes?',
      dialogMessage:
          "If you leave this page, you'll lose all of the edits you've made.",
      okButtonName: 'DISCARD',
      cancelButtonName: 'KEEP EDITING',
      action: () {
        // Reset GridModel properties
        GridModel.rows = 0;
        GridModel.columns = 0;
        GridModel.rowsForSquareGrid = 0;
        GridModel.gridColor = Colors.black;
        GridModel.strokeSize = 1;
        GridModel.crossLines = false;

        // Pop the Dialog Box
        Navigator.pop(context);

        // Pop the Editing Page
        Navigator.pop(context);
      },
    );

    warningDialogInstance.warningDialogFunction();
  }
}
