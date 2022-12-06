// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer' as developer;

import 'package:animateditems/basket_bloc.dart';
import 'package:animateditems/consts.dart';
import 'package:animateditems/favorite_bloc.dart';
import 'package:animateditems/sections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:animateditems/bloc1.dart';
import 'package:animateditems/widgets.dart';
// import '';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CardBloc(),
        ),
        BlocProvider(
          create: (context) => BasketBloc(),
        ),
        BlocProvider(
          create: (context) => FavoriteBloc(),
        ),
      ],
      child: MaterialApp(
          theme: Theming.mainTheme,
          debugShowCheckedModeBanner: false,
          home: const SafeArea(child: HomeScreen())),
    );
  }
}

// BlocProvider(
//       create: (context) => CardBloc(),
//       child: const MaterialApp(home: SafeArea(child: HomeScreen())),
//     );
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CardState blocState = BlocProvider.of<CardBloc>(context).state;
    var shoes = blocState.shoesMap ?? [];

    // Color? selectedColor;
    // int? selectedSize;

    // ValueNotifier<int> a = ValueNotifier(0);
    developer.log("0-MainScreenBuilt");

    return Scaffold(
      endDrawer: MyDrawer(),
      body: Container(
        color: Theme.of(context).backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: BlocBuilder<CardBloc, CardState>(
          builder: (context, state) {
            BlocProvider.of<BasketBloc>(context).add(
                ItemChanged(newShoppingShoe: shoes[state.currentPage ?? 0]));
            // state.
            return Column(
              children: [
                // Center(
                //   child: ColorFiltered(
                //     colorFilter: ColorFilter.mode(Colors.red, BlendMode.hue),
                //     child: Container(
                //       margin: const EdgeInsets.all(50),
                //       width: 20,
                //       height: 20,
                //       // color: Colors.purple,
                //       child: Opacity(
                //         opacity: (1),
                //         child: FlutterLogo(),
                //       ),
                //     ),
                //   ),
                // ),
                AppBarSection(
                  shoe: shoes[state.currentPage ?? 0],
                  cardItemsNumber: 0,
                ),
                TitleSection(shoe: shoes[state.currentPage ?? 0]),
                ItemSection(
                  onSelectColor: (index) {
                    BlocProvider.of<BasketBloc>(context).add(SelectColor(
                        color: shoes[state.currentPage ?? 0].colors![index]));
                    // print(BlocProvider.of<BasketBloc>(context).selectedColor);
                  },
                  onSelectSize: (index) {
                    BlocProvider.of<BasketBloc>(context).add(SelectSize(
                        size: shoes[state.currentPage ?? 0].sizes![index]));
                    // setState(() {});
                  },
                  lastDragDirection:
                      state.lastDragDirection ?? CdragDirection.na,
                  currentPage: state.currentPage ?? 0,
                  shoe: shoes[state.currentPage ?? 0],
                ),
                AddToBasketSection(
                    shoe: shoes[state.currentPage ?? 0],
                    onAddToBasket: () {
                      BlocProvider.of<BasketBloc>(context)
                          .add(AddToShoppingBasket(
                        newShoppingShoe: shoes[state.currentPage ?? 0],
                      ));
                      // }
                    })
              ],
            );
          },
        ),
      ),
    );
  }
}
