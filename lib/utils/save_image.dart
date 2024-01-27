import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grid_maker/models/image_model.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';

import '../cubits/save_image_cubit.dart';
import '../models/grid_model.dart';
import 'image_grid_painter.dart';

class SaveImage {
  final screenshotController = ScreenshotController();
  final ImageModel image;
  final BuildContext context;

  SaveImage({required this.image, required this.context});

  void saveImage() async {
    final saveImageCubit = BlocProvider.of<SaveImageCubit>(context);

    saveImageCubit.saveImageLoading();
    saveDialog(context);

    final ss = await screenshotController.captureFromWidget(
      CustomPaint(
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
            strokeSize: GridModel.strokeSize),
      ),
    );

    final result = await ImageGallerySaver.saveImage(ss);

    if (result['isSuccess']) {
      saveImageCubit.saveImageSuccess();
    } else {
      saveImageCubit.saveImageFailed();
    }
  }
}

void saveDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: BlocBuilder<SaveImageCubit, SaveImageState>(
          builder: (context, state) {
            if (state is SaveImageSuccess) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 20,
                ),
                child: const Text(
                  'Image saved.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                  ),
                ),
              );
            }

            if (state is SaveImageFailed) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 20,
                ),
                child: const Text(
                  'Failed to save image, please try again.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                  ),
                ),
              );
            }

            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 20,
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Saving image, please wait...',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}
