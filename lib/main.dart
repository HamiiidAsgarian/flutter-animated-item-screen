// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:animateditems/shoe_class.dart';
import '/basket_bloc.dart';
import '/consts.dart';
import '/favorite_bloc.dart';
import '/sections.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/bloc1.dart';
import '/widgets.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Shoe> shoes = BlocProvider.of<CardBloc>(context).state.shoesMap ?? [];

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
