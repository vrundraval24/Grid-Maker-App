import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:grid_maker/cubits/add_grid_cubit.dart';
import 'package:grid_maker/utils/image_grid_painter.dart';
import 'package:grid_maker/widgets/custom_black_button.dart';
import 'package:grid_maker/widgets/custom_dialogue_box.dart';

class AddGridPage extends StatelessWidget {
  const AddGridPage({super.key, required this.imagePath});

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
        AddGridCubitDoneState.gridColor = Colors.black;
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
                          strokeColor: AddGridCubitDoneState.gridColor,
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

  void pickColor(BuildContext context) {
    final addGridCubit = BlocProvider.of<AddGridCubit>(context);
    final mq = MediaQuery.of(context).size;

    Color temp = AddGridCubitDoneState.gridColor;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text('Pick a color'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ColorPicker(
              pickerColor: AddGridCubitDoneState.gridColor,
              onColorChanged: (value) {
                temp = value;
              },
              portraitOnly: true,
              pickerAreaBorderRadius: BorderRadius.circular(10),
              labelTypes: const [],
              pickerAreaHeightPercent: 0.7,
            )
          ],
        ),
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
            child: const Text('CANCEL'),
          ),
          ElevatedButton(
            onPressed: () {
              AddGridCubitDoneState.gridColor = temp;
              addGridCubit.setImage(
                imagePath,
                mq,
              );
              Navigator.pop(context);
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
