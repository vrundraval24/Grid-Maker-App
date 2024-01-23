import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grid_maker/pages/add_grid_page.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

abstract class GalleryState {}

class InitialGalleryState extends GalleryState {}

class OpenGalleryState extends GalleryState {}

class GalleryCubit extends Cubit<GalleryState> {
  GalleryCubit() : super(InitialGalleryState());

  Future<String> openGallery() async {
    ImagePicker imagePicker = ImagePicker();

    XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);

    if (image != null) {
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

      return image.path;
    } else {
      throw Future.error('Something went wrong.');
    }
  }
}
