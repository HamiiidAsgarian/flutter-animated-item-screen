// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:animateditems/shoe_class.dart';

abstract class BasketEvent {}

// class AddFavorite extends BasketEvent {
//   Shoe newFavorite;
//   AddFavorite({
//     required this.newFavorite,
//   });
// }

class AddToShoppingBasket extends BasketEvent {
  Shoe newShoppingShoe;
  AddToShoppingBasket({
    required this.newShoppingShoe,
  });
}

//-------------!SECTION

abstract class BasketState {
  BasketState({this.shoppingBasket});
  // List<Shoe>? favorite;
  List<Shoe>? shoppingBasket;
}

class BasketInit extends BasketState {
  BasketInit() : super(shoppingBasket: []);
}

// class FavoritesUpdate extends BasketState {
//   FavoritesUpdate({required this.bagshoes, required this.shoes});
//   final List<Shoe> bagshoes;

//   final List<Shoe> shoes;
// }

class BasketUpdate extends BasketState {
  BasketUpdate({required this.shoppingBasket});
  // final List<Shoe> shoes;

  final List<Shoe> shoppingBasket;
}
//---------------!SECTION

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  // List<Shoe> favoriteShoes = [];
  List<Shoe> shoppingBasket = [];

  BasketBloc() : super(BasketInit()) {
    // on<AddFavorite>(onAddFavorites);
    on<AddToShoppingBasket>(onAddShoppingBasket);
  }

  void onAddShoppingBasket(
      AddToShoppingBasket event, Emitter<BasketState> emit) {
    // if (shoppingBasket.contains(event.newShoppingShoe)) {
    //   shoppingBasket.removeWhere((element) => event.newShoppingShoe == element);
    // } else {
    shoppingBasket.add(event.newShoppingShoe);
    // shoppingBasket = shoppingBasket.toSet().toList();
    // }
    emit(BasketUpdate(shoppingBasket: shoppingBasket));
    // print("$shoppingBasket");
    // print("${state.shoppingBasket}");
  }

  // void onAddFavorites(AddFavorite event, Emitter<BasketState> emit) {
  //   if (favoriteShoes.contains(event.newFavorite)) {
  //     favoriteShoes.removeWhere((element) => event.newFavorite == element);
  //   } else {
  //     favoriteShoes.add(event.newFavorite);
  //     favoriteShoes = favoriteShoes.toSet().toList();
  //   }
  //   emit(FavoritesUpdate(
  //       shoes: favoriteShoes, bagshoes: state.shoppingBasket ?? []));
  //   print("$favoriteShoes");
  // }
}
