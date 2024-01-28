import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../cubits/add_grid_cubit.dart';
import '../models/grid_model.dart';

class MyColorPicker {
  static void pickColor(BuildContext context) {
    final addGridCubit = BlocProvider.of<AddGridCubit>(context);

    Color temp = GridModel.gridColor;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text('Pick Color'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ColorPicker(
              pickerColor: GridModel.gridColor,
              onColorChanged: (value) {
                temp = value;
              },
              portraitOnly: true,
              pickerAreaBorderRadius: BorderRadius.circular(7),
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
              GridModel.gridColor = temp;
              addGridCubit.launchInitialState();
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
