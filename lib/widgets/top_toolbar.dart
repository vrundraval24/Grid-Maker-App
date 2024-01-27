import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grid_maker/models/image_model.dart';
import 'package:grid_maker/utils/save_image.dart';
import 'package:popover/popover.dart';

import '../cubits/add_grid_cubit.dart';
import '../models/grid_model.dart';
import 'custom_dialogue_box.dart';

class TopToolbar extends StatelessWidget {
  const TopToolbar({super.key, required this.image});

  final ImageModel image;

  @override
  Widget build(BuildContext context) {
    final addNumberOfRowsController = TextEditingController();
    final addNumberOfColumnsController = TextEditingController();
    final addGridCubit = BlocProvider.of<AddGridCubit>(context);

    Size mq = MediaQuery.of(context).size;

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
          IconButton(
            onPressed: () {
              if (GridModel.crossLines) {
                GridModel.crossLines = false;
              } else {
                GridModel.crossLines = true;
              }
              addGridCubit.launchInitialState();
            },
            icon: Image.asset(
              'assets/icons/cross_icon.png',
              width: 24,
            ),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                    backgroundColor: Colors.white,
                    surfaceTintColor: Colors.white,
                    title: Text('Clear Grid'),
                    content: Text(
                        'Do you want to clear the grid and reset changes?'),
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
                        child: const Text('NO'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          GridModel.rows = 0;
                          GridModel.columns = 0;
                          GridModel.rowsForSquareGrid = 0;
                          GridModel.gridColor = Colors.black;
                          GridModel.strokeSize = 1;
                          GridModel.crossLines = false;

                          addGridCubit.launchInitialState();
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                                side: const BorderSide(color: Colors.black))),
                        child: const Text('YES'),
                      ),
                    ],
                  );
                },
              );
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
