import 'dart:developer' as developer;

import 'package:animateditems/basket_bloc.dart';
import 'package:animateditems/favorite_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:animateditems/bloc1.dart';
import 'package:animateditems/shoe_class.dart';
import 'package:animateditems/widgets.dart';
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      height: 300,
      // color: const Color.fromARGB(255, 255, 186, 209),
      child: Stack(
        children: [
          Center(
            child: AspectRatio(
              aspectRatio: 1.6,
              child: Container(
                // height: 200,
                // width: MediaQuery.of(context).size.width - 100,
                // color: Colors.red,
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
          Container(
              // height: 5000,
              // width: 5000,
              // flex: 4,
              child: Container(
                  // color: Colors.green,
                  child: Stack(children: [
            RotatedBox(
              quarterTurns: 1,
              child: TweenAnimationBuilder(
                key: UniqueKey(),
                tween: Tween(begin: 0.1, end: 1.2),
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
                        opacity: (value / 10),
                        child: Image.asset(shoe.logoUrl ?? "")),
                  ),
                ),
              ),
            ),
            item
          ]))),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              // color: Colors.red,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    // color: Colors.amberAccent,
                    child: Column(
                      children: [
                        Text("Size",
                            style: Theme.of(context).textTheme.bodySmall),
                        TweenAnimationBuilder(
                          key: UniqueKey(),
                          duration: const Duration(milliseconds: 600),
                          tween: Tween(begin: -10.0, end: 0.0),
                          curve: Curves.easeOutBack,
                          builder: (context, value, child) =>
                              Transform.translate(
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
                  ),
                  Container(
                    // color: const Color.fromARGB(255, 220, 255, 64),
                    child: Column(
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge))),
                        const SizedBox(height: 5),
                        Text("Price",
                            style: Theme.of(context).textTheme.bodySmall)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              // color: Colors.blue,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    // color: Colors.amberAccent,
                    child: Column(
                      children: [
                        Text("Fav",
                            style: Theme.of(context).textTheme.bodySmall),
                        const SizedBox(height: 5),
                        BlocBuilder<FavoriteBloc, FavoriteState>(
                          builder: (context, state) {
                            return MyRoundedButton(
                              onPress: (_) {
                                // print("${shoe.title}");
                                print("* ${state.favorite}");
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
                                      duration:
                                          const Duration(milliseconds: 600),
                                      tween: Tween(begin: 25.0, end: 32.0),
                                      curve: Curves.easeOutBack,
                                      builder: (context, value, child) => Icon(
                                        // key: UniqueKey(),
                                        Icons.favorite_border_outlined,
                                        color: BlocProvider.of<FavoriteBloc>(
                                                    context)
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
                                      color:
                                          BlocProvider.of<FavoriteBloc>(context)
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
                  ),
                  Container(
                    // color: const Color.fromARGB(255, 220, 255, 64),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TweenAnimationBuilder(
                          key: UniqueKey(),
                          duration: const Duration(milliseconds: 800),
                          tween: Tween(begin: 10.0, end: 0.0),
                          curve: const Interval(0.0, 1.0,
                              curve: Curves.easeOutBack),
                          builder: (context, value, child) =>
                              Transform.translate(
                            offset: Offset(value, 0),
                            child: OptionBoxes(
                                items: shoe.colors ?? [],
                                onPress: (index) {
                                  onSelectColor(index);
                                }),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text("Color",
                            style: Theme.of(context).textTheme.bodySmall)
                      ],
                    ),
                  )
                ],
              ),
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
    return Container(
      // height: 100,
      // color: Colors.orange,
      child: TweenAnimationBuilder(
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
    return Container(
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
                    child: Container(
                        // color: Colors.red,
                        child: Opacity(
                            opacity: .1,
                            child: Image.asset(shoe.logoUrl ?? ""))),
                  );
                }),
            Container(
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