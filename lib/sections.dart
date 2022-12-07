import 'dart:developer' as developer;

import 'basket_bloc.dart';
import 'shoe_class.dart';

import 'favorite_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/bloc1.dart';
import '/widgets.dart';
import 'package:rive/rive.dart' as rive;
// import '';

class AddToBasketSection extends StatefulWidget {
  const AddToBasketSection(
      {Key? key, required this.shoe, required this.onAddToBasket})
      : super(key: key);
  final Shoe shoe;
  final Function onAddToBasket;

  @override
  State<AddToBasketSection> createState() => _AddToBasketSectionState();
}

class _AddToBasketSectionState extends State<AddToBasketSection>
    with SingleTickerProviderStateMixin {
  double swipeStartValue = 0;
  double swipeUpdateValue = -1;

  // bool _isPlaying = false;

  late rive.RiveAnimationController _controller;
  late AnimationController swipeReturnAnimCNTR;
  late Animation returnToPosition;
  late Animation returnToScale;

  @override
  void initState() {
    // _controller = rive.SimpleAnimation('Boxing');
    _controller = rive.OneShotAnimation(
      'PackingTimeline',
      autoplay: false,
      // onStop: () => setState(() => _isPlaying = false),
      // onStart: () => setState(() => _isPlaying = false),
    );
    swipeReturnAnimCNTR = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    returnToPosition = Tween(begin: 0.0, end: 0.1).animate(CurvedAnimation(
        parent: swipeReturnAnimCNTR, curve: Curves.easeInOutBack));
    returnToScale = Tween(begin: 1.0, end: 1.0).animate(CurvedAnimation(
        parent: swipeReturnAnimCNTR, curve: Curves.easeInOutBack));

    super.initState();
  }

  @override
  void dispose() {
    swipeReturnAnimCNTR.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SizedBox(
      height: 300,
      // color: const Color.fromARGB(255, 255, 186, 209),
      child: Stack(
        children: [
          Center(
            child: AspectRatio(
              aspectRatio: 1.6,
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                    // width: double.infinity,
                    // height: 300,
                    child: rive.RiveAnimation.asset(
                  "assets/animations/packing.riv",
                  fit: BoxFit.fill,
                  controllers: [_controller],
                  onInit: (p0) {
                    setState(() {});
                  },
                )),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, -1),
            child: Column(
              children: [
                Text("Add to basket",
                    style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 10),
                Container(
                    padding: const EdgeInsets.all(5),
                    width: 60,
                    height: 100,
                    decoration: BoxDecoration(
                        // gradient: const LinearGradient(
                        //   begin: Alignment.topCenter,
                        //   end: Alignment.bottomCenter,
                        //   stops: [0.5, 0.9],
                        //   colors: [
                        //     Color.fromARGB(123, 0, 0, 0),
                        //     Color.fromARGB(0, 0, 0, 0),
                        //   ],
                        // ),
                        border: Border.all(width: 5),
                        borderRadius: BorderRadius.circular(30)),
                    child: Stack(children: [
                      // const RiveAnimation.asset("assets/animations/packing.riv"),
                      Align(
                          alignment: const Alignment(0, 1),
                          child: Icon(
                            Icons.arrow_downward,
                            color: Theme.of(context).colorScheme.primary,
                          )),
                      GestureDetector(
                        onVerticalDragStart: (details) {
                          swipeStartValue = details.localPosition.dy / 20;
                        },
                        onVerticalDragEnd: (details) {
                          swipeReturnAnimCNTR.reset();

                          if (swipeUpdateValue > 0) {
                            _controller.isActive = true;
                            widget.onAddToBasket();
                          }
                          returnToPosition =
                              Tween(begin: swipeUpdateValue, end: -1).animate(
                                  CurvedAnimation(
                                      parent: swipeReturnAnimCNTR,
                                      curve: Curves.easeOutBack));

                          returnToScale = Tween(begin: 1.3, end: 1.0).animate(
                              CurvedAnimation(
                                  parent: swipeReturnAnimCNTR,
                                  curve: Curves.easeInOutBack));

                          swipeReturnAnimCNTR.forward();
                          swipeUpdateValue = -1;

                          // }
                        },
                        onVerticalDragUpdate: (details) {
                          setState(() {
                            swipeUpdateValue =
                                (((details.localPosition.dy / 20) -
                                            swipeStartValue) -
                                        1)
                                    .clamp(-1, 1);

                            // }
                          });
                        },
                        child: AnimatedBuilder(
                          animation: swipeReturnAnimCNTR,
                          builder: (context, child) {
                            return Align(
                                alignment: Alignment(
                                    0,
                                    swipeReturnAnimCNTR.isAnimating
                                        ? returnToPosition.value
                                        : swipeUpdateValue),
                                child: Transform.scale(
                                  scaleY: returnToScale.value,
                                  child: CircleAvatar(
                                    // radius: 30,
                                    backgroundColor:
                                        Theme.of(context).colorScheme.primary,
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 4),
                                      child: Icon(
                                        Icons.shopping_bag_outlined,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                    ),
                                  ),
                                ));
                          },
                        ),
                      ),
                    ])),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

class ItemSection extends StatelessWidget {
  const ItemSection({
    Key? key,
    required this.lastDragDirection,
    required this.currentPage,
    required this.shoe,
    required this.onSelectSize,
    required this.onSelectColor,
  }) : super(key: key);
  final CdragDirection lastDragDirection;
  final int currentPage;

  final Function onSelectSize;
  final Function onSelectColor;

  final Shoe shoe;
  // final Widget item;

  @override
  Widget build(BuildContext context) {
    developer.log("1-ItemSection buid");
    Widget item = Center(
      child: Item(
        beginingAnimationDirection: lastDragDirection,
        key: Key(currentPage.toString()),
        onAnimationEnd: (CdragDirection direction) {
          BlocProvider.of<CardBloc>(context)
              .add(OnAnimationEnds(direction: direction));

          // onItemChanged();
        },
        // child: Text(shoe.title ?? "NA"),
        child: Image.asset(
          shoe.imageUrl ?? "",
          scale: 0.8,
        ),
      ),
    );
    return SizedBox(
      height: 450,
      child: Stack(
        children: [
          Stack(children: [
            RotatedBox(
              quarterTurns: 1,
              child: TweenAnimationBuilder(
                key: UniqueKey(),
                tween: Tween(begin: 0.2, end: 1.2),
                duration: const Duration(seconds: 2),
                curve: const Interval(0.0, 1.0, curve: Curves.easeOutQuad),
                builder: (context, value, child) => Transform.scale(
                  scale: value,
                  child: Container(
                    margin: const EdgeInsets.all(50),
                    width: double.infinity,
                    height: double.infinity,
                    // color: Colors.purple,
                    child: Opacity(
                        opacity: (value - .2),
                        child: Image.asset(
                          shoe.logoUrl ?? "",
                          color: Theme.of(context).shadowColor,
                        )),
                  ),
                ),
              ),
            ),
            item
          ]),
          Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text("Size", style: Theme.of(context).textTheme.bodySmall),
                    const SizedBox(
                      height: 10,
                    ),
                    TweenAnimationBuilder(
                      key: UniqueKey(),
                      duration: const Duration(milliseconds: 600),
                      tween: Tween(begin: -10.0, end: 0.0),
                      curve: Curves.easeOutBack,
                      builder: (context, value, child) => Transform.translate(
                        offset: Offset(value, 0),
                        child: OptionBoxes(
                            items: shoe.sizes ?? [],
                            onPress: (index) {
                              onSelectSize(index);
                            }),
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TweenAnimationBuilder(
                        key: UniqueKey(),
                        duration: const Duration(seconds: 1),
                        tween: Tween(begin: 0.5, end: 1.0),
                        curve: Curves.easeOutBack,
                        builder: (context, value, child) => Transform.scale(
                            scale: value,
                            child: Text("${shoe.price}\$",
                                style:
                                    Theme.of(context).textTheme.titleLarge))),
                    const SizedBox(height: 5),
                    Text("Price", style: Theme.of(context).textTheme.bodySmall)
                  ],
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text("Fav", style: Theme.of(context).textTheme.bodySmall),
                    const SizedBox(height: 10),
                    BlocBuilder<FavoriteBloc, FavoriteState>(
                      builder: (context, state) {
                        return MyRoundedButton(
                          onPress: (_) {
                            // print("${shoe.title}");
                            // print(BlocProvider.of<BasketBloc>(context)
                            //     .favoriteShoes
                            //     .contains(shoe));
                            // print(state.favorite ?? [].contains(shoe));

                            BlocProvider.of<FavoriteBloc>(context)
                                .add(AddFavorite(newFavorite: shoe));
                          },
                          child: (BlocProvider.of<FavoriteBloc>(context)
                                  .favoriteShoes
                                  .contains(shoe))
                              ? TweenAnimationBuilder(
                                  // key: UniqueKey(),
                                  duration: const Duration(milliseconds: 600),
                                  tween: Tween(begin: 25.0, end: 32.0),
                                  curve: Curves.easeOutBack,
                                  builder: (context, value, child) => Icon(
                                    // key: UniqueKey(),
                                    Icons.favorite_border_outlined,
                                    color:
                                        BlocProvider.of<FavoriteBloc>(context)
                                                .favoriteShoes
                                                .contains(shoe)
                                            ? Colors.red
                                            : null,
                                    size: value,
                                  ),
                                )
                              : Icon(
                                  key: UniqueKey(),
                                  Icons.favorite_border_outlined,
                                  color: BlocProvider.of<FavoriteBloc>(context)
                                          .favoriteShoes
                                          .contains(shoe)
                                      ? Colors.red
                                      : null,
                                  size: 20,
                                ),
                        );
                      },
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TweenAnimationBuilder(
                      key: UniqueKey(),
                      duration: const Duration(milliseconds: 800),
                      tween: Tween(begin: 10.0, end: 0.0),
                      curve:
                          const Interval(0.0, 1.0, curve: Curves.easeOutBack),
                      builder: (context, value, child) => Transform.translate(
                        offset: Offset(value, 0),
                        child: OptionBoxes(
                            items: shoe.colors ?? [],
                            onPress: (index) {
                              onSelectColor(index);
                            }),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text("Color", style: Theme.of(context).textTheme.bodySmall)
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TitleSection extends StatelessWidget {
  const TitleSection({
    Key? key,
    required this.shoe,
  }) : super(key: key);

  final Shoe shoe;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      key: UniqueKey(),
      duration: const Duration(seconds: 1),
      tween: Tween(begin: 0.4, end: 0.9),
      curve: Curves.easeOutBack,
      builder: (context, value, child) => Transform.scale(
        scale: value,
        child: Opacity(
          opacity: value,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("${shoe.title}",
                  style: Theme.of(context).textTheme.titleLarge),
              Text(" ${shoe.category}",
                  style: Theme.of(context).textTheme.titleMedium)
            ],
          ),
        ),
      ),
    );
  }
}

class AppBarSection extends StatelessWidget {
  const AppBarSection({
    required this.cardItemsNumber,
    required this.shoe,
    Key? key,
  }) : super(key: key);
  final Shoe shoe;
  final int cardItemsNumber;

  @override
  Widget build(BuildContext context) {
    developer.log("3-Logo sec build");
    return SizedBox(
        height: 50, //NOTE
        // color: Colors.yellow,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyRoundedButton(
                onPress: () {}, child: const Icon(Icons.arrow_back_outlined)),
            TweenAnimationBuilder(
                key: UniqueKey(),
                duration: const Duration(milliseconds: 300),
                tween: Tween(begin: 100.0, end: 0.0),
                curve: Curves.easeOutBack,
                builder: (context, value, child) {
                  return Transform.translate(
                    offset: Offset(value, 0),
                    child: Opacity(
                        opacity: 1,
                        child: Image.asset(
                          shoe.logoUrl ?? "",
                          color: Theme.of(context).shadowColor,
                        )),
                  );
                }),
            SizedBox(
              // padding: EdgeInsets.only(left: 10),
              width: 45, //NOTE
              // color: Colors.green,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: MyRoundedButton(
                        onPress: (e) {
                          Scaffold.of(context).openEndDrawer();
                        },
                        child: const Icon(Icons.shopping_bag_outlined)),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: BlocBuilder<BasketBloc, BasketState>(
                      // key: UniqueKey(),
                      builder: (context, state) {
                        return TweenAnimationBuilder(
                          curve: Curves.easeInOutBack,
                          key: Key("${state.shoppingBasket!.length}"),
                          tween: Tween(begin: 12.0, end: 8.0),
                          duration: const Duration(milliseconds: 600),
                          // curve: const Interval(0.0, 1.0, curve: Curves.easeOutQuad),
                          builder: (context, value, child) => CircleAvatar(
                              backgroundColor: Colors.black,
                              radius: value,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: Text("${state.shoppingBasket!.length}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            fontSize: value + 2,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w200)),
                              )),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

class MyDrawer extends StatelessWidget {
  MyDrawer({
    Key? key,
  }) : super(key: key);

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BasketBloc, BasketState>(
      builder: (context, state) {
        return Drawer(
          // width: 200,
          backgroundColor: Theme.of(context).backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: BlocBuilder<BasketBloc, BasketState>(
              builder: (context, state) {
                // List<Widget> a =
                //     state.shoppingBasket!.map((SelectedShoe element) {
                //   return Padding(
                //       padding: const EdgeInsets.only(bottom: 15),
                //       child: MyItemCard(selectedShoe: element));
                // }).toList();

                // List<Widget> a = state.shoppingBasket!
                //     .asMap()
                //     .map((i, element) => MapEntry(
                //           i,
                //           Padding(
                //               key: Key(
                //                   element.shoe.title.toString() + i.toString()),
                //               padding: const EdgeInsets.only(bottom: 0),
                //               child:
                //                   MyItemCard(selectedShoe: element, index: i)),
                //         )) //NOTE
                //     .values
                //     .toList();

                return Column(
                  children: [
                    Container(
                      color: Theme.of(context).primaryColor,
                      height: 50,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                                onPressed: () {
                                  Scaffold.of(context).closeEndDrawer();
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: Theme.of(context).backgroundColor,
                                )),
                          ),
                          Align(
                              alignment: Alignment.center,
                              child: Text("Shopping Bag",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .backgroundColor))),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 25, right: 25, top: 10),
                        child: state.shoppingBasket!.isEmpty
                            ? const Text("Bag Is Empty")
                            : AnimatedList(
                                key: _listKey,
                                initialItemCount: state.shoppingBasket!.length,
                                itemBuilder: (context, index, animation) {
                                  return Padding(
                                      // key: Key(
                                      //     element.shoe.title.toString() + i.toString()),
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: MyItemCard(
                                        // key: ValueKey(state.shoppingBasket![index]),
                                        selectedShoe:
                                            state.shoppingBasket![index],
                                        index: index,
                                        onPressDelete: (e) async {
                                          SelectedShoe thisShoe =
                                              state.shoppingBasket![index];

                                          BlocProvider.of<BasketBloc>(context)
                                              .add(DeleteFromShoppingBasket(
                                                  selectedShoe: state
                                                      .shoppingBasket![index],
                                                  selectedShoeListIndex:
                                                      index));

                                          _listKey.currentState!.removeItem(
                                              index, (context, animation) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: SlideTransition(
                                                position: Tween(
                                                        begin:
                                                            const Offset(.9, 0),
                                                        end: const Offset(0, 0))
                                                    .animate(CurvedAnimation(
                                                        parent: animation,
                                                        curve: Curves
                                                            .easeOutBack)),
                                                child: MyItemCard(
                                                    onPressDelete: (e) {},
                                                    selectedShoe: thisShoe,
                                                    index: index),
                                              ),
                                            );
                                          },
                                              duration: const Duration(
                                                  milliseconds: 600));
                                          // await Future.delayed(const Duration(
                                          //     milliseconds: 300));
                                        },
                                      ));
                                },
                                // children: [...a],
                              ),
                      ),
                    ),
                    Container(
                      color: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 20),
                      // height: 50,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total Costs: ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          fontSize: 20,
                                          color: Theme.of(context)
                                              .backgroundColor)),
                              Text(
                                  "${double.parse((BlocProvider.of<BasketBloc>(context).totalItemsPrice).toStringAsFixed(2))}\$",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          fontSize: 25,
                                          color: Theme.of(context)
                                              .backgroundColor)),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Additional Tax: ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          fontSize: 13,
                                          color: Theme.of(context)
                                              .backgroundColor)),
                              Text(
                                  "${double.parse((BlocProvider.of<BasketBloc>(context).totalItemsPrice / 13.75).toStringAsFixed(2))}\$",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          fontSize: 15,
                                          color: Theme.of(context)
                                              .backgroundColor)),
                            ],
                          ),
                          const SizedBox(height: 25),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.wallet,
                                  color: Theme.of(context).backgroundColor,
                                ),
                                Text(" Go to the payment",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                            fontSize: 20,
                                            color: Theme.of(context)
                                                .backgroundColor))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
