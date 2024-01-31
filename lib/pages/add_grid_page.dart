import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grid_maker/cubits/add_grid_cubit.dart';
import 'package:grid_maker/models/grid_model.dart';
import 'package:grid_maker/models/image_model.dart';
import 'package:grid_maker/utils/image_grid_painter.dart';
import 'package:grid_maker/utils/leave_editing_page_handler.dart';
import 'package:grid_maker/widgets/bottom_toolbar.dart';
import 'package:grid_maker/widgets/top_toolbar.dart';

class AddGridPage extends StatelessWidget {
  const AddGridPage({super.key, required this.image});

  final ImageModel image;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) async {
        try {
          await LeaveEditingPageHandler.leaveEditingPage(context);
        } catch (e) {
          log(e.toString());
        }
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
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: InteractiveViewer(
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
