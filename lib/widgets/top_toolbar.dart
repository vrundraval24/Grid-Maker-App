import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grid_maker/models/image_model.dart';
import 'package:grid_maker/utils/save_image.dart';
import 'package:grid_maker/widgets/custom_warning_dialog.dart';

import '../cubits/add_grid_cubit.dart';
import '../models/grid_model.dart';

class TopToolbar extends StatelessWidget {
  const TopToolbar({super.key, required this.image});

  final ImageModel image;

  @override
  Widget build(BuildContext context) {
    final addGridCubit = BlocProvider.of<AddGridCubit>(context);

    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.black12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {
              SaveImage(context: context, image: image).saveImage();
            },
            icon: Image.asset(
              'assets/icons/disk.png',
              width: 24,
            ),
          ),
          StatefulBuilder(
            builder: (context, setState) {
              return IconButton(
                onPressed: () {
                  if (GridModel.crossLines) {
                    GridModel.crossLines = false;
                  } else {
                    GridModel.crossLines = true;
                  }
                  setState(() {});
                  addGridCubit.launchInitialState();
                },
                icon: Image.asset(
                  GridModel.crossLines
                      ? 'assets/icons/cross_icon.png'
                      : 'assets/icons/cross_icon_border.png',
                  width: 24,
                  color: Colors.black,
                ),
              );
            },
          ),
          IconButton(
            onPressed: () {
              final warningDialogInstance = WarningDialog(
                context: context,
                dialogTitle: 'Clear Grid',
                dialogMessage:
                    'Do you want to clear the grid and reset changes?',
                okButtonName: 'YES',
                cancelButtonName: 'NO',
                action: () {
                  GridModel.rows = 0;
                  GridModel.columns = 0;
                  GridModel.rowsForSquareGrid = 0;
                  GridModel.gridColor = Colors.black;
                  GridModel.strokeSize = 1;
                  GridModel.crossLines = false;

                  addGridCubit.launchInitialState();
                  Navigator.pop(context);
                },
              );

              warningDialogInstance.warningDialogFunction();
            },
            icon: Image.asset(
              'assets/icons/trash.png',
              width: 24,
            ),
          ),
        ],
      ),
    );
  }
}
