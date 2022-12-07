import 'dart:math';

import 'shoe_class.dart';
import 'package:flutter/material.dart';

class MyRoundedButton extends StatelessWidget {
  const MyRoundedButton({
    super.key,
    required this.child,
    // this.onPressed,
    required this.onPress,
    this.index,
    this.isActive,
    // this.borderColor = Colors.red,
    this.fillColor = const Color.fromARGB(0, 255, 255, 255),
  });
  // final Color? borderColor;
  final Color? fillColor;
  final Widget child;
  final Function onPress;
  final int? index;
  final bool? isActive;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      key: UniqueKey(),
      tween: Tween(begin: 1.5, end: 3.0),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutBack,
      builder: (context, value, _) => Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            color: fillColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                width: isActive ?? false ? value : 1.5,
                color: isActive ?? false
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).shadowColor)),
        child: RawMaterialButton(
          child: child,
          onPressed: () {
            // setState(() {
            //   isActive = !isActive;
            // });
            onPress(index ?? 0);
          },
        ),
      ),
    );
  }
}

class MyRoundedButtonFill extends StatelessWidget {
  const MyRoundedButtonFill({
    super.key,
    required this.child,
    // this.onPressed,
    required this.onPress,
    this.index,
    this.isActive,
    // this.borderColor = Colors.red,
    this.fillColor = const Color.fromARGB(0, 255, 255, 255),
  });
  // final Color? borderColor;
  final Color? fillColor;
  final Widget child;
  final Function onPress;
  final int? index;
  final bool? isActive;

  // bool isActive = false;
  @override
  Widget build(BuildContext context) {
    // borderColor = Theme.of(context).shadowColor;

    return TweenAnimationBuilder(
      key: UniqueKey(),
      tween: Tween(begin: 1.0, end: 1.15),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      builder: (context, value, _) => Transform.scale(
        scale: isActive! ? value : 1.0,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              color: isActive ?? false
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  width: 1.5,

                  // width: isActive ?? false ? 1.5 : 0,
                  color: isActive ?? false
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).shadowColor)),
          child: RawMaterialButton(
            child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                    isActive! ? Colors.white : Colors.black, BlendMode.srcATop),
                child: child),
            onPressed: () {
              // setState(() {
              //   isActive = !isActive;
              // });
              onPress(index ?? 0);
            },
          ),
        ),
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
              child: SizedBox(
                // height: 5000,
                // width: 5000,
                // color: Colors.purple,
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
                                  angle: -pi / 8, child: widget.child)),
                        ),
                      );
                    },
                    //
                  ),
                ),
              ),
            )));
  }
}

enum CdragDirection { left, right, na }

class MyItemCard extends StatelessWidget {
  const MyItemCard(
      {required this.selectedShoe,
      required this.index,
      super.key,
      required this.onPressDelete});
  final SelectedShoe selectedShoe;
  final int index;
  final Function onPressDelete;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1,
      child: Container(
        padding: const EdgeInsets.all(20),
        width: 150,
        height: 200,
        decoration: BoxDecoration(
            border: Border.all(width: 2),
            color: Theme.of(context).shadowColor.withOpacity(.5),
            borderRadius: BorderRadius.circular(10)),
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              // color: Colors.red,
              child: Image.asset(
                selectedShoe.shoe.imageUrl.toString(),
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: FittedBox(
                        child: Text(
                          "${selectedShoe.shoe.title}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      Text(
                        "Color  ",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontSize: 13),
                      ),
                      CircleAvatar(
                        radius: 5,
                        backgroundColor: selectedShoe.selectedColor,
                      ),
                    ]),
                    Row(children: [
                      Text(
                        "Size ",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontSize: 13),
                      ),
                      Text(
                        "${selectedShoe.selectedSize}",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontSize: 15),
                      ),
                    ]),
                  ],
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Price",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontSize: 13),
                        ),
                        Text(
                          "\$${selectedShoe.shoe.price}",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontSize: 20),
                        ),
                      ],
                    ),
                    MyRoundedButton(
                        child: Icon(Icons.close,
                            color: Theme.of(context).primaryColor),
                        onPress: (e) {
                          onPressDelete(e);
                          // anim1 = Tween(begin: 1.0, end: 0.0).animate(
                          //     CurvedAnimation(
                          //         parent: cntrl1, curve: Curves.easeIn));
                          // cntrl1.reverse().then((value) {

                          // BlocProvider.of<BasketBloc>(context).add(
                          //     DeleteFromShoppingBasket(
                          //         selectedShoe: selectedShoe,
                          //         selectedShoeListIndex: index));

                          // });
                        })
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OptionBoxes extends StatefulWidget {
  const OptionBoxes({
    Key? key,
    required this.items,
    required this.onPress,
  }) : super(key: key);
  final Function onPress;
  final List items;
  @override
  State<OptionBoxes> createState() => _OptionBoxesState();
}

class _OptionBoxesState extends State<OptionBoxes> {
  int? selectedboxID;
  @override
  void initState() {
    widget.items.isNotEmpty ? selectedboxID = 0 : null;
    super.initState();
  }

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
              child: Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: widget.items[i]),
              ),
              onPress: (int index) {
                setState(() {
                  selectedboxID = index;
                });

                widget.onPress(index);
              }),
        ));
      } else {
        children.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: MyRoundedButtonFill(
              isActive: selectedboxID == i ? true : false,
              index: i,
              child: Text("${widget.items[i]}",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: selectedboxID == i
                          ? const Color.fromARGB(255, 255, 255, 255)
                          : const Color.fromARGB(255, 0, 0, 0))),
              onPress: (int index) {
                setState(() {
                  selectedboxID = index;
                });
                widget.onPress(index);
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
