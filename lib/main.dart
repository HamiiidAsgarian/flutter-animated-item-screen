// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer' as developer;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:animateditems/bloc1.dart';
import 'package:animateditems/shoe_class.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CardBloc(),
      child: const MaterialApp(home: HomeScreen()),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    CardState blocState = BlocProvider.of<CardBloc>(context).state;
    var shoes = blocState.shoesMap ?? [];

    developer.log("0-MainScreenBuilt");

    return Scaffold(
      body: Container(
        color: Colors.blueGrey[800],
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: BlocBuilder<CardBloc, CardState>(
          builder: (context, state) {
            // state.
            return Column(
              children: [
                AppBarSection(
                  shoe: shoes[state.currentPage ?? 0],
                  cardItemsNumber: 0,
                ),
                TitleSection(shoe: shoes[state.currentPage ?? 0]),
                ItemSection(
                  lastDragDirection:
                      state.lastDragDirection ?? CdragDirection.na,
                  currentPage: state.currentPage ?? 0,
                  shoe: shoes[state.currentPage ?? 0],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ItemSection extends StatelessWidget {
  const ItemSection({
    Key? key,
    required this.lastDragDirection,
    required this.currentPage,
    required this.shoe,
  }) : super(key: key);
  final CdragDirection lastDragDirection;
  final int currentPage;

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
        },
        // child: Text(shoe.title ?? "NA"),
        child: Image.asset(shoe.imageUrl ?? ""),
      ),
    );
    return SizedBox(
      height: 500,
      child: Row(
        children: [
          Container(
            color: Colors.red,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: Colors.amberAccent,
                  child: Column(
                    children: [
                      const Text("size", style: TextStyle()),
                      ...shoe.sizes!
                          .map((e) => TweenAnimationBuilder(
                                key: UniqueKey(),
                                duration: const Duration(milliseconds: 600),
                                tween: Tween(begin: -10.0, end: 0.0),
                                curve: Curves.easeOutBack,
                                builder: (context, value, child) =>
                                    Transform.translate(
                                  offset: Offset(value, 0),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: MyRoundedButton(
                                        fillColor: Colors.white,
                                        onPress: () {},
                                        child: Text("$e",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15))),
                                  ),
                                ),
                              ))
                          .toList(),
                      // MyRoundedButton(
                      //   onPress: () {},
                      //   child: const Center(
                      //     child: ,
                      //   ),
                      // ),
                      // MyRoundedButton(
                      //   onPress: () {},
                      //   child: const Center(
                      //     child: Text("8.5",
                      //         style: TextStyle(
                      //             fontWeight: FontWeight.bold, fontSize: 15)),
                      //   ),
                      // ),
                      // MyRoundedButton(
                      //   onPress: () {},
                      //   child: const Center(
                      //     child: Text("9.5",
                      //         style: TextStyle(
                      //             fontWeight: FontWeight.bold, fontSize: 15)),
                      //   ),
                      // ),
                      // MyRoundedButton(
                      //   onPress: () {},
                      //   child: const Center(
                      //     child: Text("8",
                      //         style: TextStyle(
                      //             fontWeight: FontWeight.bold, fontSize: 15)),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Container(
                  color: const Color.fromARGB(255, 220, 255, 64),
                  child: Column(
                    children: const [
                      Text("170\$",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      Text("Price",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12))
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
              flex: 4,
              child: Container(
                  color: Colors.green,
                  child: Stack(children: [
                    RotatedBox(
                      quarterTurns: 1,
                      child: TweenAnimationBuilder(
                        key: UniqueKey(),
                        tween: Tween(begin: 0.1, end: 1.2),
                        duration: const Duration(seconds: 2),
                        curve:
                            const Interval(0.0, 1.0, curve: Curves.easeOutQuad),
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
          Container(
            color: Colors.blue,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: Colors.amberAccent,
                  child: Column(
                    children: [
                      MyRoundedButton(
                        onPress: () {},
                        child: const Center(
                          child: Icon(
                            Icons.favorite_border_outlined,
                            size: 23,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: const Color.fromARGB(255, 220, 255, 64),
                  child: Column(
                    children: [
                      MyRoundedButton(onPress: () {}),
                      MyRoundedButton(onPress: () {}),
                      const Text("Color",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12))
                    ],
                  ),
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
    return Container(
        height: 50,
        color: Colors.orange,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Nike Air Max 270${shoe.title}",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            Text("Men's shoes ${shoe.category}", style: const TextStyle())
          ],
        ));
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
        height: 50,
        color: Colors.yellow,
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
                            opacity: 1,
                            child: Image.asset(shoe.logoUrl ?? ""))),
                  );
                }),
            Stack(
              children: [
                MyRoundedButton(
                    onPress: () {
                      // BlocProvider.of<CardBloc>(context).add(
                      //     AddToCardPressed(
                      //         shoe: Shoe(id: Random().nextInt(100))));
                      // print(
                      //     BlocProvider.of<CardBloc>(context).shoesList);
                    },
                    child: const Icon(Icons.shopping_bag_outlined)),
                CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: FittedBox(child: Text("$cardItemsNumber")),
                  ),
                )
              ],
            )
          ],
        ));
  }
}

class MyRoundedButton extends StatefulWidget {
  const MyRoundedButton(
      {super.key,
      // this.onPressed,
      required this.onPress,
      this.borderColor = Colors.blueGrey,
      this.fillColor = const Color.fromARGB(0, 255, 255, 255),
      this.child});
  final Color? borderColor;
  final Color? fillColor;
  final Widget? child;
  final Function onPress;
  @override
  State<MyRoundedButton> createState() => _MyRoundedButtonState();
}

class _MyRoundedButtonState extends State<MyRoundedButton> {
  bool isActive = false;
// class MyRoundedButton extends StatefulWidget {

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      key: UniqueKey(),
      tween: Tween(begin: 1.5, end: 5.0),
      duration: const Duration(milliseconds: 300),
      curve: Curves.bounceOut,
      builder: (context, value, child) => Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            color: widget.fillColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                width: isActive ? value : 1.5, color: widget.borderColor!)),
        child: RawMaterialButton(
            onPressed: () {
              setState(() {
                isActive = !isActive;
              });
              widget.onPress();
            },
            child: widget.child),
      ),
    );
  }
}

class Item extends StatefulWidget {
  const Item(
      {this.child,
      this.beginingAnimationDirection,
      required this.onAnimationEnd,
      super.key});
  final Function onAnimationEnd;
  final CdragDirection? beginingAnimationDirection;
  final Widget? child;

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> with SingleTickerProviderStateMixin {
  late CdragDirection dragDirectionRes = CdragDirection.na;

  late AnimationController mainAnimCntrl;
  late Animation itemAnimToLeft;
  late Animation itemAnimToRight;

  late Animation itemAnimOpacity;
  // late Animation itemOpacityTweenPrevious;

  // late Animation itemTweenBackward;

  double tempAngle = 0;
  Tween<double> beginningTween = Tween(begin: 0, end: 0);

  @override
  void initState() {
    mainAnimCntrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    itemAnimToLeft = Tween(
      begin: 0.0,
      end: pi / 3,

      // begin: widget.beginingAnimationDirection == null ? 0.0 : -pi / 2,
      // end: widget.beginingAnimationDirection == null ? pi / 2 : 00,
    ).animate(CurvedAnimation(parent: mainAnimCntrl, curve: Curves.easeInOut));

    itemAnimToRight = Tween(
      begin: 0.0,
      end: -pi / 3,

      // begin: widget.beginingAnimationDirection == null ? 0.0 : pi / 2,
      // end: widget.beginingAnimationDirection == null ? -pi / 2 : 0.0,
    ).animate(CurvedAnimation(parent: mainAnimCntrl, curve: Curves.easeInOut));

    itemAnimOpacity = Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
        parent: mainAnimCntrl,
        curve: const Interval(0.0, 1.0, curve: Curves.easeInOut)));
    WidgetsBinding.instance.addPostFrameCallback((_) {});

    // if (widget.beginingAnimationDirection != null) {
    //   dragDirectionRes = widget.beginingAnimationDirection!;
    //   mainAnimCntrl.forward();
    // }
    if (widget.beginingAnimationDirection == null) {
      beginningTween = Tween(begin: 0, end: 0);
    } else if (widget.beginingAnimationDirection == CdragDirection.left) {
      beginningTween = Tween(begin: -pi / 3, end: 0.0);
    } else if (widget.beginingAnimationDirection == CdragDirection.right) {
      beginningTween = Tween(begin: pi / 3, end: 0.0);
    }

    super.initState();
  }

  @override
  void dispose() {
    mainAnimCntrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Tween beginningTween = widget.beginingAnimationDirection == null
    //     ? Tween(begin: 0, end: 0)
    //     : Tween(begin: -pi / 2, end: 0.0);

    return TweenAnimationBuilder(
        tween: beginningTween,
        // curve: Curves.elasticOut,
        curve: Curves.easeOutBack,

        // tween: Tween(begin: -pi / 2, end: 0.0),
        duration: const Duration(milliseconds: 500),
        builder: ((context, value, child) => Transform.rotate(
              angle: value,
              origin: const Offset(0, -250),
              // angle: 3.14 * 2,
              child: GestureDetector(
                onHorizontalDragUpdate: (details) {
                  // print(details.delta.dx);
                },
                onHorizontalDragEnd: (details) {
                  // print(details.primaryVelocity);
                  if (details.primaryVelocity! < 0.0) {
                    setState(() {
                      dragDirectionRes = CdragDirection.left;
                    });
                  }
                  if (details.primaryVelocity! > 0.0) {
                    setState(() {
                      dragDirectionRes = CdragDirection.right;
                    });
                    // print("> $dragDirectionRes ");
                  }
                  if (dragDirectionRes != CdragDirection.na) {
                    mainAnimCntrl.forward().then((value) {
                      widget.onAnimationEnd(dragDirectionRes);
                    });
                  }
                },
                child: AnimatedBuilder(
                  animation: dragDirectionRes == CdragDirection.left
                      ? itemAnimToLeft
                      : itemAnimToRight,
                  builder: (context, child) {
                    return Transform.rotate(
                      origin: const Offset(0, -250),
                      angle: dragDirectionRes == CdragDirection.left
                          ? itemAnimToLeft.value
                          : itemAnimToRight.value,
                      child: AspectRatio(
                        aspectRatio: 1,
                        // width: 500,
                        // height: 500,
                        // color: Colors.amberAccent,
                        //     .withOpacity(itemAnimOpacity.value),
                        child: Opacity(
                            opacity: itemAnimOpacity.value,
                            child: Transform.rotate(
                                angle: -pi / 4, child: widget.child)),
                      ),
                    );
                  },
                  //
                ),
              ),
            )));
  }
}

enum CdragDirection { left, right, na }

// class MyWidget extends StatefulWidget {
//   const MyWidget({super.key});

//   @override
//   State<MyWidget> createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<MyWidget> {
//   late int dimension;

//   @override
//   void initState() {
//     dimension = 0;
//     super.initState();
//   }

//   @override
//   void dispose() async {
//     dimension = 5;
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       color: Color.fromARGB(255, Random().nextInt(255), 200, 0),
//       duration: Duration(seconds: 1),
//       width: dimension.toDouble(),
//       height: dimension.toDouble(),
//     );
//   }
// }
