import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CardEvent {}

class AddToCardPressed extends CardEvent {}

class RemoveFromCardPressed extends CardEvent {}

class AddToCardBloc extends Bloc<CardEvent, int> {
  AddToCardBloc() : super(0) {
    on<AddToCardPressed>((event, emit) => state + 1);
    on<AddToCardPressed>((event, emit) => state - 1);
  }
}
