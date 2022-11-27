import 'dart:developer' as developer;
import 'dart:math';

import 'package:animateditems/bloc1.dart';
import 'package:animateditems/shoe_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
  // final CdragDirection lastDragDirection;
  // final int currentPage;
  // final List<Shoe> shoes;

  // @override
  // void initState() {
  //   currentPage = 0;
  //   lastDragDirection = CdragDirection.na;

  //   // shoes = products.map((e) => Shoe.fromMap(e)).toList();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    CardState blocState = BlocProvider.of<CardBloc>(context).state;
    var shoes = blocState.shoesMap ?? [];
    var currentPage = blocState.currentPage ?? 0;
    var lastDragDirection = blocState.lastDragDirection ?? CdragDirection.na;

    // print(shoes.length);

    developer.log("0-MainScreenBuilt");
    Widget item = Center(
        // alignment: Alignment.topCenter,
        child: Item(
      beginingAnimationDirection: lastDragDirection,
      key: Key(currentPage.toString()),
      onAnimationEnd: (CdragDirection direction) {
        if (direction == CdragDirection.right) {
          switch (currentPage < shoes.length - 1) {
            case true:
              currentPage++;
              break;

            case false:
              currentPage = 0;
              break;
          }
        }
        if (direction == CdragDirection.left) {
          switch (currentPage > 0) {
            case true:
              currentPage--;
              break;

            case false:
              currentPage = shoes.length - 1;
              break;
          }
        }
        setState(() {
          lastDragDirection = direction;
        });
        print(currentPage);
      },
      child: Text(shoes[currentPage].title ?? "NA"),
    ));

    return Scaffold(
      body: Container(
        color: Colors.blueGrey[800],
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(
          children: [
            Container(
                height: 50,
                color: Colors.yellow,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyRoundedButton(
                        onPress: () {},
                        child: const Icon(Icons.arrow_back_outlined)),
                    const FlutterLogo(),
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
                        const CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 10,
                          child: Padding(
                            padding: EdgeInsets.all(3),
                            child: FittedBox(child: Text("2")
                                //      BlocBuilder<CardBloc, CardState>(
                                //   builder: (context, state) {
                                //     if (state is InitState) {
                                //       return Text("00".toString());
                                //     }
                                //     if (state is UpdateCardState) {
                                //       return Text("2");
                                //     }
                                //     return const SizedBox();
                                //   },
                                // )
                                ),
                          ),
                        )
                      ],
                    )
                  ],
                )),
            Container(
                height: 50,
                color: Colors.orange,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Nike Air Max 270${shoes[currentPage].title}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    const Text("Men's shoes", style: TextStyle())
                  ],
                )),
            SizedBox(
              height: 500,
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    color: Colors.red,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          color: Colors.amberAccent,
                          child: Column(
                            children: [
                              const Text("size", style: TextStyle()),
                              MyRoundedButton(
                                onPress: () {},
                                child: const Center(
                                  child: Text("9",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                ),
                              ),
                              MyRoundedButton(
                                onPress: () {},
                                child: const Center(
                                  child: Text("8.5",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                ),
                              ),
                              MyRoundedButton(
                                onPress: () {},
                                child: const Center(
                                  child: Text("9.5",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                ),
                              ),
                              MyRoundedButton(
                                onPress: () {},
                                child: const Center(
                                  child: Text("8",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: const Color.fromARGB(255, 220, 255, 64),
                          child: Column(
                            children: const [
                              Text("170\$",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                              Text("Price",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12))
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
                  Expanded(
                      flex: 4,
                      child: Container(color: Colors.green, child: item)),
                  Expanded(
                      child: Container(
                    color: Colors.blue,
                    child: Column(
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
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12))
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
                ],
                // child: Column(
                //   children: [
                //     Expanded(child: item),
                //     Expanded(
                //         child: Column(
                //       children: [
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             FloatingActionButton(onPressed: () {
                //               setState(() {
                //                 currentPage--;
                //                 lastDragDirection = CdragDirection.left;
                //               });
                //             }),
                //             FloatingActionButton(onPressed: () {
                //               setState(() {
                //                 currentPage++;
                //                 lastDragDirection = CdragDirection.right;
                //               });
                //             })
                //           ],
                //         )
                //       ],
                //     ))
                //   ],
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyRoundedButton extends MaterialButton {
  const MyRoundedButton(
      {super.key,
      super.onPressed,
      required this.onPress,
      this.borderColor = Colors.blueGrey,
      this.fillColor = const Color.fromARGB(0, 255, 255, 255),
      super.child});
  final Color? borderColor;
  final Color? fillColor;
  // final Widget? child;
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
          color: fillColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1.5, color: borderColor!)),
      child: RawMaterialButton(
          onPressed: () {
            onPress();
          },
          child: child),
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
      end: pi / 2,

      // begin: widget.beginingAnimationDirection == null ? 0.0 : -pi / 2,
      // end: widget.beginingAnimationDirection == null ? pi / 2 : 00,
    ).animate(CurvedAnimation(parent: mainAnimCntrl, curve: Curves.easeInOut));

    itemAnimToRight = Tween(
      begin: 0.0,
      end: -pi / 2,

      // begin: widget.beginingAnimationDirection == null ? 0.0 : pi / 2,
      // end: widget.beginingAnimationDirection == null ? -pi / 2 : 0.0,
    ).animate(CurvedAnimation(parent: mainAnimCntrl, curve: Curves.easeInOut));

    itemAnimOpacity = Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: mainAnimCntrl, curve: Curves.easeInOut));
    WidgetsBinding.instance.addPostFrameCallback((_) {});

    // if (widget.beginingAnimationDirection != null) {
    //   dragDirectionRes = widget.beginingAnimationDirection!;
    //   mainAnimCntrl.forward();
    // }

    if (widget.beginingAnimationDirection == null) {
      beginningTween = Tween(begin: 0, end: 0);
    } else if (widget.beginingAnimationDirection == CdragDirection.left) {
      beginningTween = Tween(begin: -pi / 2, end: 0.0);
    } else if (widget.beginingAnimationDirection == CdragDirection.right) {
      beginningTween = Tween(begin: pi / 2, end: 0.0);
    }

    super.initState();
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
                    print("<  $dragDirectionRes");
                  }
                  if (details.primaryVelocity! > 0.0) {
                    setState(() {
                      dragDirectionRes = CdragDirection.right;
                    });
                    // print("> $dragDirectionRes ");
                  }
                  if (dragDirectionRes != CdragDirection.na) {
                    mainAnimCntrl.forward().then((value) {
                      print("End");
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
                      child: Container(
                        width: 250,
                        height: 250,
                        color: Colors.amberAccent
                            .withOpacity(itemAnimOpacity.value),
                        child: widget.child,
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
