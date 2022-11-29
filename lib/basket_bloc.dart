// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:animateditems/shoe_class.dart';

abstract class BasketEvent {}

class AddFavorite extends BasketEvent {
  Shoe newFavorite;
  AddFavorite({
    required this.newFavorite,
  });
}

class RemoveFavorite extends BasketEvent {}

//-------------!SECTION

abstract class BasketState {
  BasketState({this.favorite});
  List<Shoe>? favorite;
}

class BasketInit extends BasketState {
  BasketInit() : super(favorite: []);
}

class BasketUpdate extends BasketState {
  BasketUpdate({required this.shoes}) : super(favorite: []);

  final List<Shoe> shoes;
}

//---------------!SECTION

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  List<Shoe> favoriteShoes = [];

  BasketBloc() : super(BasketInit()) {
    on<AddFavorite>(onAddbasket);
  }

  void onAddbasket(AddFavorite event, Emitter<BasketState> emit) {
    if (favoriteShoes.contains(event.newFavorite)) {
      favoriteShoes.removeWhere((element) => event.newFavorite == element);
    } else {
      favoriteShoes.add(event.newFavorite);
      favoriteShoes = favoriteShoes.toSet().toList();
    }
    emit(BasketUpdate(shoes: favoriteShoes));
    print("$favoriteShoes");
  }
}
