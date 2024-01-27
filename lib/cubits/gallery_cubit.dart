import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grid_maker/models/image_model.dart';
import 'package:image_picker/image_picker.dart';

abstract class GalleryState {}

class InitialGalleryState extends GalleryState {}

class OpenGalleryState extends GalleryState {}

class GalleryCubit extends Cubit<GalleryState> {
  GalleryCubit() : super(InitialGalleryState());

  Future<ImageModel> openGallery(Size size) async {
    ImagePicker imagePicker = ImagePicker();

    XFile? tempImage = await imagePicker.pickImage(source: ImageSource.gallery);

    final ImageModel imageModel;

    if (tempImage != null) {
      // CROP AND EDIT IMAGE BEFORE ADDING GRID
      // CroppedFile? croppedImage = await ImageCropper().cropImage(sourcePath: image.path,uiSettings: [
      //   AndroidUiSettings(
      //     statusBarColor: Colors.white,
      //     activeControlsWidgetColor: Colors.redAccent,
      //   )
      // ]);
      // if(croppedImage != null){
      //   return croppedImage.path;
      // }

      double w, h;
      String imgPath = tempImage.path;

      File image = File(imgPath);
      ui.Image decodedImage = await decodeImageFromList(image.readAsBytesSync());

      w = size.width * 0.9;
      h = (w * decodedImage.height) / decodedImage.width;

      if (h > size.height * 0.7) {
        h = size.height * 0.7;
        w = (h * decodedImage.width) / decodedImage.height;
      }

      imageModel = ImageModel(width: w, height: h, uiImage: decodedImage);


      return imageModel;
    } else {
      throw Future.error('Something went wrong.');
    }
  }
}
