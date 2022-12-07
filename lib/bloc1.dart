import '/shoe_class.dart';
import '/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CardEvent {}

class ChangeCurrentPage extends CardEvent {
  final int currentPage;

  ChangeCurrentPage({required this.currentPage});
}

class ChangeDragDirection extends CardEvent {
  final CdragDirection lastDragDirection;

  ChangeDragDirection({required this.lastDragDirection});
}

class OnAnimationEnds extends CardEvent {
  final CdragDirection direction;

  OnAnimationEnds({required this.direction});
}

//----------------------------------------------
abstract class CardState {
  final List<Shoe>? shoesMap;
  final CdragDirection? lastDragDirection;
  final int? currentPage;
  // final AnimationController? animCntrlr1;

  CardState({this.shoesMap, this.lastDragDirection, this.currentPage
      // ,this.animCntrlr1
      });
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
  // final CdragDirection lastDragDirection;
  UpdateDragDirectionState({super.lastDragDirection});
}

class UpdateCurrentPageState extends CardState {
  // final int currentPage;
  UpdateCurrentPageState({required super.currentPage});
}

class RenewItem extends CardState {
  // final CdragDirection newDragDirection;
  RenewItem({required super.lastDragDirection, required super.currentPage});
  // : super(lastDragDirection: newDragDirection);
}

//------------------------------

class CardBloc extends Bloc<CardEvent, CardState> {
  int currentPage = 0;
  CdragDirection direction = CdragDirection.na;
  // List<Shoe> shoes = [];
  // List<Shoe> shoesList = [];
  List<Shoe> shoes = products.map((e) => Shoe.fromMap(e)).toList();

  CardBloc() : super(HomeInitState()) {
    // on<ChangeCurrentPage>(onChangeCurrentPage);
    // on<ChangeDragDirection>(onChangeDragDirection);
    on<OnAnimationEnds>(onItemAnimationEnd);
  }

  // void onChangeCurrentPage(
  //     ChangeCurrentPage event, Emitter<CardState> emit) async {
  //   currentPage++;
  //   emit(UpdateCurrentPageState(currentPage: event.currentPage));
  // }

  // void onChangeDragDirection(
  //     ChangeDragDirection event, Emitter<CardState> emit) async {
  //   direction = event.lastDragDirection;
  //   emit(UpdateDragDirectionState(lastDragDirection: event.lastDragDirection));
  // }

  void onItemAnimationEnd(
      OnAnimationEnds event, Emitter<CardState> emit) async {
    // print("0**- ${event.direction} -- ${currentPage} -- ${0}");
    if (event.direction == CdragDirection.right) {
      switch (currentPage < shoes.length - 1) {
        case true:
          currentPage++;
          // emit(UpdateCurrentPageState(currentPage: currentPage));

          break;

        case false:
          currentPage = 0;
          // emit(UpdateCurrentPageState(currentPage: currentPage));

          break;
      }
    }
    if (event.direction == CdragDirection.left) {
      switch (currentPage > 0) {
        case true:
          currentPage--;
          // emit(UpdateCurrentPageState(currentPage: currentPage));
          break;

        case false:
          currentPage = shoes.length - 1;
          // emit(UpdateCurrentPageState(currentPage: currentPage));

          break;
      }
    }
    emit(UpdateCurrentPageState(currentPage: currentPage));

    direction = event.direction;
    // print("1**- ${event.direction} -- ${currentPage} -- ${state.currentPage}");

    // emit(UpdateDragDirectionState(lastDragDirection: event.direction));
    // emit(UpdateCurrentPageState(currentPage: currentPage));

    emit(RenewItem(
      currentPage: currentPage,
      lastDragDirection: event.direction,
    ));
  }
}
