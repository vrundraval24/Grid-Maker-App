import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grid_maker/models/image_model.dart';
import 'package:grid_maker/utils/color_picker.dart';
import 'package:popover/popover.dart';

import '../cubits/add_grid_cubit.dart';
import '../models/grid_model.dart';
import 'custom_dialogue_box.dart';

class BottomToolbar extends StatelessWidget {
  const BottomToolbar({super.key, required this.image});

  final ImageModel image;

  @override
  Widget build(BuildContext context) {
    final addNumberOfRowsController = TextEditingController();
    final addNumberOfColumnsController = TextEditingController();
    final addGridCubit = BlocProvider.of<AddGridCubit>(context);

    Size mq = MediaQuery.of(context).size;

    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.black12))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              onPressed: () {
                MyColorPicker.pickColor(context);
              },
              icon: Image.asset(
                'assets/icons/palette.png',
                width: 24,
              )),
          IconButton(
              onPressed: () {
                final customDialogInstance = CustomDialogBox(
                    context: context,
                    imageModel: image,
                    controller: addNumberOfRowsController,
                    dialogueBoxTitle: 'Set Rows',
                    hintText: 'Enter number of rows',
                    dialogButtonName: 'SET',
                    action: () {
                      GridModel.rowsForSquareGrid = 0;
                      GridModel.rows =
                          int.parse(addNumberOfRowsController.text);
                      addGridCubit.launchInitialState();

                      Navigator.pop(context);
                    });

                customDialogInstance.customDialogFunction();
              },
              icon: Image.asset(
                'assets/icons/grip_lines.png',
                width: 24,
              )),

          IconButton(
              onPressed: () {
                final customDialogInstance = CustomDialogBox(
                    context: context,
                    imageModel: image,
                    controller: addNumberOfColumnsController,
                    dialogueBoxTitle: 'Set Columns',
                    hintText: 'Enter number of columns',
                    dialogButtonName: 'SET',
                    action: () {
                      GridModel.rowsForSquareGrid = 0;
                      GridModel.columns =
                          int.parse(addNumberOfColumnsController.text);
                      addGridCubit.launchInitialState();

                      Navigator.pop(context);
                    });

                customDialogInstance.customDialogFunction();
              },
              icon: Image.asset(
                'assets/icons/grip_lines_vertical.png',
                width: 24,
              )),
          IconButton(
              onPressed: () {
                showPopover(
                  barrierColor: Colors.transparent,
                  context: context,
                  width: mq.width * 0.9,
                  height: 50,
                  arrowDxOffset: mq.width * 0.2,
                  direction: PopoverDirection.top,
                  bodyBuilder: (context) {
                    return StatefulBuilder(
                      builder: (context, setState) {
                        return SliderTheme(
                          data: const SliderThemeData(
                            trackHeight: 2,
                          ),
                          child: Slider(
                            min: 0.1,
                            max: 3,
                            activeColor: Colors.black,
                            inactiveColor: Colors.black12,
                            value: GridModel.strokeSize,
                            onChanged: (value) {
                              setState(() {});
                              GridModel.strokeSize = value;
                              addGridCubit.launchInitialState();
                            },
                          ),
                        );
                      },
                    );
                  },
                );
              },
              icon: Image.asset(
                'assets/icons/circle.png',
                width: 24,
              )),
          // const MyIcon(),
          IconButton(
              onPressed: () {
                final customDialogInstance = CustomDialogBox(
                    context: context,
                    imageModel: image,
                    controller: addNumberOfColumnsController,
                    dialogueBoxTitle: 'Set square grid',
                    hintText: 'Enter number of rows',
                    dialogButtonName: 'SET',
                    action: () {
                      GridModel.columns = 0;
                      GridModel.rows = 0;
                      GridModel.rowsForSquareGrid =
                          int.parse(addNumberOfColumnsController.text);
                      addGridCubit.launchInitialState();

                      Navigator.pop(context);
                    });

                customDialogInstance.customDialogFunction();
              },
              icon: Image.asset(
                'assets/icons/apps.png',
                width: 24,
              )),
        ],
      ),
    );
  }
}
