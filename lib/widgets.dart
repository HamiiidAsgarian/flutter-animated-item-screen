import 'dart:math';

import 'package:animateditems/shoe_class.dart';
import 'package:flutter/material.dart';

class MyRoundedButton extends StatelessWidget {
  const MyRoundedButton({
    super.key,
    required this.child,
    // this.onPressed,
    required this.onPress,
    this.index,
    this.isActive,
    this.borderColor = Colors.blueGrey,
    this.fillColor = const Color.fromARGB(0, 255, 255, 255),
  });
  final Color? borderColor;
  final Color? fillColor;
  final Widget child;
  final Function onPress;
  final int? index;
  final bool? isActive;

  // bool isActive = false;
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      key: UniqueKey(),
      tween: Tween(begin: 1.5, end: 5.0),
      duration: const Duration(milliseconds: 300),
      curve: Curves.bounceOut,
      builder: (context, value, _) => Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            color: fillColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                width: isActive ?? false ? value : 1.5, color: borderColor!)),
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
                                  angle: -pi / 4, child: widget.child)),
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
  const MyItemCard({required this.selectedShoe, super.key});
  final SelectedShoe selectedShoe;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: 150,
      height: 200,
      decoration: BoxDecoration(
          color: Color(0xFFf4f9fc), borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Text(
            "${selectedShoe.shoe.title}",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 17),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  child: Row(children: [
                const Text("Color "),
                CircleAvatar(
                  radius: 5,
                  backgroundColor: selectedShoe.selectedColor,
                ),
              ])),
              Container(
                  child: Row(children: [
                const Text("Size "),
                Text("${selectedShoe.selectedSize}",
                    style: const TextStyle(fontSize: 17)),
              ])),
            ],
          ),
          Expanded(
            child: Image.asset(selectedShoe.shoe.imageUrl.toString()),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("\$${selectedShoe.shoe.price}",
                  style: const TextStyle(fontSize: 17)),
              MyRoundedButton(child: const Icon(Icons.close), onPress: (e) {})
            ],
          )
        ],
      ),
    );
  }
}
