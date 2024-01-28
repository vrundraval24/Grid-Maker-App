import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AddGridCubitState {}

class AddGridCubitInitialState extends AddGridCubitState {}

class AddGridCubit extends Cubit<AddGridCubitState> {
  AddGridCubit() : super(AddGridCubitInitialState());

  void launchInitialState() {
    emit(AddGridCubitInitialState());
  }
}
