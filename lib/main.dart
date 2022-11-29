// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:animateditems/bloc1.dart';
import 'package:animateditems/shoe_class.dart';
import 'package:animateditems/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CardBloc(),
      child: const MaterialApp(home: SafeArea(child: HomeScreen())),
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

                      TweenAnimationBuilder(
                        key: UniqueKey(),
                        duration: const Duration(milliseconds: 600),
                        tween: Tween(begin: -10.0, end: 0.0),
                        curve: Curves.easeOutBack,
                        builder: (context, value, child) => Transform.translate(
                          offset: Offset(value, 0),
                          child: OptionBoxes(items: shoe.sizes ?? []),
                        ),
                      )

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TweenAnimationBuilder(
                        key: UniqueKey(),
                        duration: Duration(seconds: 1),
                        tween: Tween(begin: 0.5, end: 1.0),
                        curve: Curves.easeOutBack,
                        builder: (context, value, child) => Transform.scale(
                          scale: value,
                          child: Text("${shoe.price}\$",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                        ),
                      ),
                      SizedBox(height: 5),
                      const Text("Price",
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
                      Text("Fav"),
                      SizedBox(height: 5),
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
                          child: OptionBoxes(items: shoe.colors ?? []),
                        ),
                      ),
                      SizedBox(height: 5),
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
      child: TweenAnimationBuilder(
        key: UniqueKey(),
        duration: Duration(seconds: 1),
        tween: Tween(begin: 0.4, end: 0.9),
        curve: Curves.easeOutBack,
        builder: (context, value, child) => Transform.scale(
          scale: value,
          child: Opacity(
            opacity: value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${shoe.title}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20)),
                Text(" ${shoe.category}", style: const TextStyle())
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

class OptionBoxes extends StatefulWidget {
  const OptionBoxes({
    Key? key,
    required this.items,
  }) : super(key: key);

  final List items;
  @override
  State<OptionBoxes> createState() => _OptionBoxesState();
}

class _OptionBoxesState extends State<OptionBoxes> {
  int? selectedboxID;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (int i = 0; i < widget.items.length; i++) {
      if (widget.items is List<Color>) {
        children.add(Padding(
          padding: const EdgeInsets.only(top: 10),
          child: MyRoundedButton(
              isActive: selectedboxID == i ? true : false,
              index: i,
              child: CircleAvatar(
                backgroundColor: widget.items[i],
                radius: 10,
              ),
              onPress: (int index) {
                setState(() {
                  selectedboxID = index;
                });
              }),
        ));
      } else {
        children.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: MyRoundedButton(
              isActive: selectedboxID == i ? true : false,
              index: i,
              child: Text("${widget.items[i]}"),
              onPress: (int index) {
                setState(() {
                  selectedboxID = index;
                });
              }),
        ));
      }
    }
    return Column(children: children
        // .map((e) => MyRoundedButton(onPress: (int buttonIndex) {
        //       setState(() {
        //         selectedboxID = buttonIndex;
        //       });
        //     }))
        // .toList()
        );
  }
}
