import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grid_maker/models/image_model.dart';

abstract class AddGridCubitState {}

class AddGridCubitInitialState extends AddGridCubitState {}

// class AddGridCubitUpdateState extends AddGridCubitState {
//   final ImageModel imageModel;
//
//   static bool screenExited = false;
//
//   AddGridCubitUpdateState({
//     required this.imageModel,
//   });
// }

// class AddGridCubitDoneState extends AddGridCubitState {
//   // static int numberOfRows = 0;
//   // static int numberOfColumns = 0;
//   // static int numberOfBoth = 0;
//   // static Color gridColor = Colors.black;
//
//   final ImageModel imageModel;
//
//   static bool screenExited = false;
//
//   AddGridCubitDoneState({
//     required this.imageModel,
//   });
// }

// class AddRowsState extends AddGridCubitState {}
//
// class AddColumnsState extends AddGridCubitState {}
//
// class AddSquareGridState extends AddGridCubitState {}
//
// class ChangeGridColorState extends AddGridCubitState {}

// class RowState extends AddGridCubitState {}

class AddGridCubit extends Cubit<AddGridCubitState> {
  AddGridCubit() : super(AddGridCubitInitialState());


  void launchInitialState(){
    emit(AddGridCubitInitialState());
  }

  // void setImage(ImageModel imageModel) async {
  //
  //   print('done state is emitted...');
  //   emit(
  //     AddGridCubitDoneState(
  //       imageModel: imageModel
  //     ),
  //   );
  // }


}
