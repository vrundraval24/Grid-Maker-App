import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:grid_maker/cubits/add_grid_cubit.dart';
import 'package:grid_maker/utils/image_grid_painter.dart';
import 'package:grid_maker/widgets/custom_black_button.dart';
import 'package:grid_maker/widgets/custom_dialogue_box.dart';

class AddGridPage extends StatelessWidget {
  AddGridPage({super.key, required this.imagePath});

  Color color = Colors.red;

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    final addGridCubit = BlocProvider.of<AddGridCubit>(context);

    final addNumberOfRowsController = TextEditingController();
    final addNumberOfColumnsController = TextEditingController();

    Size mq = MediaQuery.of(context).size;

    return PopScope(
      onPopInvoked: (_) {
        AddGridCubitDoneState.numberOfRows = 0;
        AddGridCubitDoneState.numberOfColumns = 0;
        AddGridCubitDoneState.numberOfBoth = 0;
        AddGridCubitDoneState.screenExited = true;
      },
      child: Scaffold(
        // backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Add Grid'),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BlocBuilder<AddGridCubit, AddGridCubitState>(
                builder: (context, state) {
                  if (state is AddGridCubitInitialState) {
                    // print('initial state...');
                    addGridCubit.setImage(imagePath, mq);
                  }

                  if (state is AddGridCubitDoneState) {
                    // print('done state...');

                    if (AddGridCubitDoneState.screenExited == true) {
                      AddGridCubitDoneState.screenExited = false;
                      addGridCubit.setImage(imagePath, mq);
                    } else {
                      return CustomPaint(
                        size: Size(
                            state.imageModel.width, state.imageModel.height),
                        painter: ImageGridPainter(
                          img: state.imageModel.uiImage,
                          width: state.imageModel.width,
                          height: state.imageModel.height,
                          numberOfRows: AddGridCubitDoneState.numberOfRows,
                          numberOfColumns:
                              AddGridCubitDoneState.numberOfColumns,
                          numberOfBoth: AddGridCubitDoneState.numberOfBoth,
                          strokeColor: color,
                        ),
                      );
                    }
                  }

                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  );
                },
              ),
              Column(
                children: [
                  customBlackButton('PICK COLOR', () {
                    pickColor(context);
                  }),
                  customBlackButton(
                    'SET ROWS',
                    () {
                      final customDialogInstance = CustomDialogBox(
                          context: context,
                          imagePath: imagePath,
                          mq: mq,
                          controller: addNumberOfRowsController,
                          dialogueBoxTitle: 'Set Rows',
                          hintText: 'Enter number of rows',
                          dialogButtonName: 'SET',
                          action: () {
                            AddGridCubitDoneState.numberOfBoth = 0;

                            AddGridCubitDoneState.numberOfRows =
                                int.parse(addNumberOfRowsController.text);

                            addGridCubit.setImage(
                              imagePath,
                              mq,
                            );

                            Navigator.pop(context);
                          });

                      customDialogInstance.customDialogFunction();
                    },
                  ),
                  customBlackButton(
                    'SET COLUMNS',
                    () {
                      final customDialogInstance = CustomDialogBox(
                          context: context,
                          imagePath: imagePath,
                          mq: mq,
                          controller: addNumberOfColumnsController,
                          dialogueBoxTitle: 'Set Columns',
                          hintText: 'Enter number of columns',
                          dialogButtonName: 'SET',
                          action: () {
                            AddGridCubitDoneState.numberOfBoth = 0;
                            AddGridCubitDoneState.numberOfColumns =
                                int.parse(addNumberOfColumnsController.text);

                            addGridCubit.setImage(
                              imagePath,
                              mq,
                            );

                            Navigator.pop(context);
                          });

                      customDialogInstance.customDialogFunction();
                    },
                  ),
                  customBlackButton(
                    'SET SQUARE GRID',
                    () {
                      final customDialogInstance = CustomDialogBox(
                          context: context,
                          imagePath: imagePath,
                          mq: mq,
                          controller: addNumberOfColumnsController,
                          dialogueBoxTitle: 'Set square grid',
                          hintText: 'Enter number of rows',
                          dialogButtonName: 'SET',
                          action: () {
                            AddGridCubitDoneState.numberOfColumns = 0;
                            AddGridCubitDoneState.numberOfRows = 0;
                            AddGridCubitDoneState.numberOfBoth =
                                int.parse(addNumberOfColumnsController.text);

                            addGridCubit.setImage(
                              imagePath,
                              mq,
                            );

                            Navigator.pop(context);
                          });

                      customDialogInstance.customDialogFunction();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildColorPicker() {
    return ColorPicker(
      pickerColor: color,
      onColorChanged: (value) {
        color = value;
      },

      portraitOnly: true,
      pickerAreaBorderRadius: BorderRadius.circular(10),
      labelTypes: const [],
      pickerAreaHeightPercent: 0.7,
    );
  }

  void pickColor(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text('Pick a color'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildColorPicker(),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {

            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                    side: const BorderSide(color: Colors.black))),
            child: const Text('SET'),
          ),
        ],
      ),
    );
  }
}
