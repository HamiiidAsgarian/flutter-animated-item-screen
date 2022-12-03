// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/animation.dart';
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
  // Color color;
  // int size;
  AddToShoppingBasket({required this.newShoppingShoe});
}

class SelectSize extends BasketEvent {
  // Shoe newShoppingShoe;
  // Color color;
  int size;
  SelectSize({required this.size});
}

class SelectColor extends BasketEvent {
  // Shoe newShoppingShoe;
  Color color;
  SelectColor({required this.color});
}

class ItemChanged extends BasketEvent {
  Shoe newShoppingShoe;
  // Color color;
  // int size;
  ItemChanged({required this.newShoppingShoe});
}
//-------------!SECTION

abstract class BasketState {
  BasketState({this.shoppingBasket});
  // List<Shoe>? favorite;
  List<SelectedShoe>? shoppingBasket;
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

  final List<SelectedShoe> shoppingBasket;
}
//---------------!SECTION

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  // List<Shoe> favoriteShoes = [];
  List<SelectedShoe> shoppingBasket = [];
  int? selectedSize;
  Color? selectedColor;
  Shoe? currentShoe;

  BasketBloc() : super(BasketInit()) {
    // on<AddFavorite>(onAddFavorites);
    on<AddToShoppingBasket>(onAddShoppingBasket);
    on<SelectSize>(onAddSize);
    on<SelectColor>(onAddColor);
    on<ItemChanged>(onItemChange);

    // on<SelectColor>(onAddShoppingBasket);
    // on<ItemChanged>(onAddShoppingBasket);
  }
  void onAddSize(SelectSize event, Emitter<BasketState> emit) {
    selectedSize = event.size;
    emit(BasketUpdate(shoppingBasket: state.shoppingBasket!));
    print(selectedSize);
  }

  void onAddColor(SelectColor event, Emitter<BasketState> emit) {
    selectedColor = event.color;
    emit(BasketUpdate(shoppingBasket: state.shoppingBasket!));
    print(selectedColor);
  }

  void onItemChange(ItemChanged event, Emitter<BasketState> emit) {
    currentShoe = event.newShoppingShoe;
    selectedColor = event.newShoppingShoe.colors![0];
    selectedSize = event.newShoppingShoe.sizes![0];
    // SelectedShoe newSelection = SelectedShoe(
    //     selectedColor: event.color,
    //     selectedSize: event.size,
    //     shoe: event.newShoppingShoe);
    // shoppingBasket.add(newSelection);
    emit(BasketUpdate(shoppingBasket: state.shoppingBasket!));
  }

  // void onAddShoppingBasket(
  //     AddToShoppingBasket event, Emitter<BasketState> emit) {
  //   SelectedShoe newSelection = SelectedShoe(
  //       selectedColor: event.color,
  //       selectedSize: event.size,
  //       shoe: event.newShoppingShoe);
  //   shoppingBasket.add(newSelection);
  //   emit(BasketUpdate(shoppingBasket: shoppingBasket));
  // }

  void onAddShoppingBasket(
      AddToShoppingBasket event, Emitter<BasketState> emit) {
    SelectedShoe newSelection = SelectedShoe(
        selectedColor: selectedColor!,
        selectedSize: selectedSize!,
        shoe: event.newShoppingShoe);
    shoppingBasket.add(newSelection);
    emit(BasketUpdate(shoppingBasket: shoppingBasket));

    (state.shoppingBasket!.forEach((element) =>
        print("${element.selectedColor} ${element.selectedSize}")));
  }
}
