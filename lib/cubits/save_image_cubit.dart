import 'package:flutter_bloc/flutter_bloc.dart';

// States
abstract class SaveImageState {}

class SaveImageLoading extends SaveImageState {}

class SaveImageSuccess extends SaveImageState {}

class SaveImageFailed extends SaveImageState {}

// Cubit
class SaveImageCubit extends Cubit<SaveImageState> {
  SaveImageCubit() : super(SaveImageLoading());

  void saveImageLoading() {
    emit(SaveImageLoading());
  }

  void saveImageSuccess() {
    emit(SaveImageSuccess());
  }

  void saveImageFailed() {
    emit(SaveImageFailed());
  }
}
