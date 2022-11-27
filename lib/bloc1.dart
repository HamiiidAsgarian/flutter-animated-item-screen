import 'package:animateditems/shoe_class.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'main.dart';

abstract class CardEvent {}

class ChangeCurrentPage extends CardEvent {
  final int currentPage;

  ChangeCurrentPage({required this.currentPage});
}

class ChangeDragDirection extends CardEvent {
  final CdragDirection lastDragDirection;

  ChangeDragDirection({required this.lastDragDirection});
}

//----------------------------------------------
abstract class CardState {
  final List<Shoe>? shoesMap;
  final CdragDirection? lastDragDirection;
  final int? currentPage;

  CardState({this.shoesMap, this.lastDragDirection, this.currentPage});
}

// class InitState extends CardState {}

class HomeInitState extends CardState {
  HomeInitState()
      : super(
            currentPage: 0,
            lastDragDirection: CdragDirection.na,
            shoesMap: products.map((e) => Shoe.fromMap(e)).toList());
}

// class InitCardState extends CardState {}

class UpdateDragDirectionState extends CardState {
  final CdragDirection lastDragDirection;
  UpdateDragDirectionState({required this.lastDragDirection});
}

class UpdateCurrentPageState extends CardState {
  final int currentPage;
  UpdateCurrentPageState({required this.currentPage});
}

//------------------------------

class CardBloc extends Bloc<CardEvent, CardState> {
  int currentPage = 0;
  // List<Shoe> shoesList = [];
  // List<Shoe> shoesListFromMap = products.map((e) => Shoe.fromMap(e)).toList();

  CardBloc() : super(HomeInitState()) {
    on<ChangeCurrentPage>(onChangeCurrentPage);
    on<ChangeDragDirection>(onChangeDragDirection);
  }

  void onChangeCurrentPage(
      ChangeCurrentPage event, Emitter<CardState> emit) async {
    currentPage++;
    emit(UpdateCurrentPageState(currentPage: event.currentPage));
  }

  void onChangeDragDirection(
      ChangeDragDirection event, Emitter<CardState> emit) async {
    currentPage++;
    emit(UpdateDragDirectionState(lastDragDirection: state.lastDragDirection!));
  }
}
