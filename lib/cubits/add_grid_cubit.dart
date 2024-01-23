import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grid_maker/models/image_model.dart';

abstract class AddGridCubitState {}

class AddGridCubitInitialState extends AddGridCubitState {}

class AddGridCubitDrawRowState extends AddGridCubitState {
  final ImageModel imageModel;

  static bool screenExited = false;

  AddGridCubitDrawRowState({
    required this.imageModel,
  });
}

class AddGridCubitDoneState extends AddGridCubitState {
  final ImageModel imageModel;
  static int numberOfRows = 0;
  static int numberOfColumns = 0;
  static int numberOfBoth = 0;
  static Color gridColor = Colors.black;

  static bool screenExited = false;

  AddGridCubitDoneState({
    required this.imageModel,
  });
}

class AddGridCubit extends Cubit<AddGridCubitState> {
  AddGridCubit() : super(AddGridCubitInitialState());

  void setImage(
      String imgPath, Size size) async {
    double w, h;

    File image = File(imgPath);
    ui.Image decodedImage = await decodeImageFromList(image.readAsBytesSync());

    w = size.width * 0.8;
    h = (w * decodedImage.height) / decodedImage.width;

    if (h > size.height * 0.6) {
      h = size.height * 0.6;
      w = (h * decodedImage.width) / decodedImage.height;
    }

    emit(AddGridCubitDoneState(
      imageModel: ImageModel(
        width: w,
        height: h,
        uiImage: decodedImage,
      ),
    ));
  }

}
