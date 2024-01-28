import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grid_maker/cubits/add_grid_cubit.dart';
import 'package:grid_maker/models/grid_model.dart';
import 'package:grid_maker/models/image_model.dart';
import 'package:grid_maker/utils/image_grid_painter.dart';
import 'package:grid_maker/widgets/bottom_toolbar.dart';
import 'package:grid_maker/widgets/custom_warning_dialog.dart';
import 'package:grid_maker/widgets/top_toolbar.dart';

class AddGridPage extends StatelessWidget {
  const AddGridPage({super.key, required this.image});

  final ImageModel image;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) async {
        await leaveEditingPage(context);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: Colors.white,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          child: BlocBuilder<AddGridCubit, AddGridCubitState>(
            builder: (context, state) {
              if (state is AddGridCubitInitialState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TopToolbar(image: image),
                    InteractiveViewer(
                      maxScale: 100,
                      child: CustomPaint(
                        size: Size(
                          image.width,
                          image.height,
                        ),
                        painter: ImageGridPainter(
                          img: image.uiImage,
                          width: image.width,
                          height: image.height,
                          numberOfRows: GridModel.rows,
                          numberOfColumns: GridModel.columns,
                          numberOfBoth: GridModel.rowsForSquareGrid,
                          strokeColor: GridModel.gridColor,
                          strokeSize: GridModel.strokeSize,
                          crossLines: GridModel.crossLines,
                        ),
                      ),
                    ),
                    BottomToolbar(image: image),
                  ],
                );
              }

              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

Future<void> leaveEditingPage(BuildContext context) async {
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
