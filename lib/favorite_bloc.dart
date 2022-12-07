// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_bloc/flutter_bloc.dart';

import '/shoe_class.dart';

abstract class FavoriteEvent {}

class AddFavorite extends FavoriteEvent {
  Shoe newFavorite;
  AddFavorite({
    required this.newFavorite,
  });
}

class AddToFavoriteList extends FavoriteEvent {
  Shoe newShoppingShoe;
  AddToFavoriteList({
    required this.newShoppingShoe,
  });
}

//-------------!SECTION

abstract class FavoriteState {
  FavoriteState({this.favorite});
  List<Shoe>? favorite;
}

class FavoriteInit extends FavoriteState {
  FavoriteInit() : super(favorite: []);
}

class FavoritesUpdate extends FavoriteState {
  FavoritesUpdate({required this.shoes});

  final List<Shoe> shoes;
}

//---------------!SECTION

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  List<Shoe> favoriteShoes = [];

  FavoriteBloc() : super(FavoriteInit()) {
    on<AddFavorite>(onAddFavorites);
  }

  void onAddFavorites(AddFavorite event, Emitter<FavoriteState> emit) {
    if (favoriteShoes.contains(event.newFavorite)) {
      favoriteShoes.removeWhere((element) => event.newFavorite == element);
    } else {
      favoriteShoes.add(event.newFavorite);
      favoriteShoes = favoriteShoes.toSet().toList();
    }
    emit(FavoritesUpdate(shoes: favoriteShoes));
    print("$favoriteShoes");
  }
}
