import 'package:flutter_bloc/flutter_bloc.dart';

// States
abstract class AddGridCubitState {}

class AddGridCubitInitialState extends AddGridCubitState {}

// Cubit
class AddGridCubit extends Cubit<AddGridCubitState> {
  AddGridCubit() : super(AddGridCubitInitialState());

  void launchInitialState() {
    emit(AddGridCubitInitialState());
  }
}
