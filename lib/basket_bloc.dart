// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:animateditems/shoe_class.dart';

abstract class BasketEvent {}

class AddFavorite extends BasketEvent {
  Shoe newFavorite;
  AddFavorite({
    required this.newFavorite,
  });
}

class AddToShoppingBasket extends BasketEvent {
  Shoe newShoppingShoe;
  AddToShoppingBasket({
    required this.newShoppingShoe,
  });
}

//-------------!SECTION

abstract class BasketState {
  BasketState({this.favorite, this.shoppingBasket});
  List<Shoe>? favorite;
  List<Shoe>? shoppingBasket;
}

class BasketInit extends BasketState {
  BasketInit() : super(favorite: [], shoppingBasket: []);
}

class FavoritesUpdate extends BasketState {
  FavoritesUpdate({required this.bagshoes, required this.shoes})
      : super(favorite: shoes, shoppingBasket: bagshoes);

  final List<Shoe> shoes;
  final List<Shoe> bagshoes;
}

// class BasketUpdate extends BasketState {
//   BasketUpdate({required this.bagshoes}) : super(shoppingBasket: bagshoes);

//   final List<Shoe> bagshoes;
// }
//---------------!SECTION

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  List<Shoe> favoriteShoes = [];
  List<Shoe> shoppingBasket = [];

  BasketBloc() : super(BasketInit()) {
    on<AddFavorite>(onAddFavorites);
    on<AddToShoppingBasket>(onAddShoppingBasket);
  }

  void onAddShoppingBasket(
      AddToShoppingBasket event, Emitter<BasketState> emit) {
    shoppingBasket.add(event.newShoppingShoe);
    shoppingBasket = shoppingBasket.toSet().toList();
    emit(FavoritesUpdate(shoes: favoriteShoes, bagshoes: shoppingBasket));

    // emit(BasketUpdate(bagshoes: shoppingBasket));
    print("i $shoppingBasket");
  }

  void onAddFavorites(AddFavorite event, Emitter<BasketState> emit) {
    favoriteShoes.add(event.newFavorite);
    favoriteShoes = favoriteShoes.toSet().toList();
    emit(FavoritesUpdate(shoes: favoriteShoes, bagshoes: shoppingBasket));
    print("ii $favoriteShoes");
  }
}
