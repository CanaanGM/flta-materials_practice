import 'package:flutter/material.dart';
import 'package:yummy/components/categroy_card.dart';
import 'package:yummy/models/models.dart';

import 'components/color_button.dart';
import 'components/post_card.dart';
import 'components/resturant_landscape_card.dart';
import 'components/theme_button.dart';
import 'constants.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
    required this.changeTheme,
    required this.changeColor,
    required this.colorSelected,
  });

  final void Function(bool useLightMode) changeTheme;
  final void Function(int value) changeColor;
  final ColorSelection colorSelected;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int tab = 0;

  List<NavigationDestination> appBarDestinations = const [
    NavigationDestination(
      icon: Icon(Icons.credit_card),
      label: 'Category',
      selectedIcon: Icon(Icons.credit_card),
    ),
    NavigationDestination(
      icon: Icon(Icons.credit_card),
      label: 'Post',
      selectedIcon: Icon(Icons.credit_card),
    ),
    NavigationDestination(
      icon: Icon(Icons.credit_card),
      label: 'Resturant',
      selectedIcon: Icon(Icons.credit_card),
    ),
  ];
  final pages = [
    Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 300,
        ),
        child: CategoryCard(
          category: categories[0],
        ),
      ),
    ),
    Center(
      child: Padding(
        padding: const EdgeInsets.all(
          16,
        ),
        child: PostCard(
          post: posts[0],
        ),
      ),
    ),
    Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: RestaurantLandscapeCard(
          restaurant: restaurants[0],
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yummy'),
        elevation: 4.0,
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: [
          ThemeButton(
            changeThemeMode: widget.changeTheme,
          ),
          ColorButton(
            changeColor: widget.changeColor,
            colorSelection: widget.colorSelected,
          ),
        ],
      ),
      body: IndexedStack(
        index: tab,
        children: pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (index) {
          setState(() {
            tab = index;
          });
        },
        destinations: appBarDestinations,
      ),
    );
  }
}
