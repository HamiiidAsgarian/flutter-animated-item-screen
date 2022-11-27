import 'package:animateditems/main.dart';
import 'package:animateditems/shoe_class.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CardEvent {}

class AddToCardPressed extends CardEvent {
  final Shoe shoe;

  AddToCardPressed({required this.shoe});
}

class RemoveFromCardPressed extends CardEvent {}

//----------------------------------------------
abstract class CardState {}

class InitState extends CardState {}

class ItemsInitState extends CardState {
  final List<Map> shoesMap;
  ItemsInitState(this.shoesMap);

  List shoesClassed = products.map((e) => Shoe.fromMap(e)).toList();
}

// class InitCardState extends CardState {}

class UpdateCardState extends CardState {
  final List<Shoe> shoes;
  UpdateCardState(this.shoes);
}

// class UpdateState extends CardState {
//   final int counter;
//   UpdateState(this.counter);
// }

//------------------------------

class CardBloc extends Bloc<CardEvent, CardState> {
  int counter = 0;
  List<Shoe> shoesList = [];
  CardBloc() : super(InitState()) {
    // on<AddToCardPressed>((event, emit) => state + 1);
    // on<AddToCardPressed>((event, emit) => state - 1);
    on<AddToCardPressed>(onAddShoe);
    // on<RemoveFromCardPressed>(onNumDecrease);
  }

  void onAddShoe(AddToCardPressed event, Emitter<CardState> emit) async {
    shoesList.add(event.shoe);
    emit(UpdateCardState(shoesList));
  }

  // void onNumIncrease(AddToCardPressed event, Emitter<CardState> emit) async {
  //   counter++;
  //   emit(UpdateState(counter));
  // }

  // void onNumDecrease(
  //     RemoveFromCardPressed event, Emitter<CardState> emit) async {
  //   counter--;
  //   emit(UpdateState(counter));
  // }
}
