import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'constants.dart';
import 'home.dart';
import '../models/models.dart';
import 'screens/screens.dart';

void main() {
  runApp(const Yummy());
}

/// Allows the ability to scroll by dragging with touch, mouse, and trackpad.
class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad
      };
}

class Yummy extends StatefulWidget {
  const Yummy({super.key});

  @override
  State<Yummy> createState() => _YummyState();
}

class _YummyState extends State<Yummy> {
  ThemeMode themeMode = ThemeMode.light;
  ColorSelection colorSelected = ColorSelection.pink;

  /// Authentication to manage user login session
  // ignore: unused_field
  final YummyAuth _auth = YummyAuth();

  /// Manage user's shopping cart for the items they order.
  final CartManager _cartManager = CartManager();

  /// Manage user's orders submitted
  final OrderManager _orderManager = OrderManager();

  late final _router = GoRouter(
      initialLocation: '/login',
      redirect: _appRedirect,
      routes: [
        GoRoute(
            path: '/login',
            builder: (context, state) =>
                LoginPage(onLogIn: (Credentials credentials) async {
                  _auth.signIn(credentials.username, credentials.password).then(
                        (value) => context.go('/${YummyTab.home.value}'),
                      );
                })),
        GoRoute(
            path: '/:tab',
            builder: ((context, state) {
              return Home(
                auth: _auth,
                cartManager: _cartManager,
                ordersManager: _orderManager,
                changeTheme: changeThemeMode,
                changeColor: changeColor,
                colorSelected: colorSelected,
                tab: int.tryParse(state.pathParameters['tab'] ?? '') ?? 0,
              );
            }),
            routes: [
              GoRoute(
                path: 'restaurant/:id',
                builder: (context, state) {
                  final id =
                      int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
                  final restaurant = restaurants[id];
                  return RestaurantPage(
                    restaurant: restaurant,
                    cartManager: _cartManager,
                    ordersManager: _orderManager,
                  );
                },
              ),
            ]),
      ],
      errorPageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: Scaffold(
            body: Center(
              child: Text(
                '404\n${state.error.toString()}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
        );
      });

  Future<String?> _appRedirect(
      BuildContext context, GoRouterState state) async {
    final loggedIn = await _auth.loggedIn;
    final isOnLoginPage = state.matchedLocation == '/login';

    if (!loggedIn) return '/login';
    if (loggedIn && isOnLoginPage) return '/${YummyTab.home.value}';
    return null;
  }

  void changeThemeMode(bool useLightMode) {
    setState(() {
      themeMode = useLightMode
          ? ThemeMode.light //
          : ThemeMode.dark;
    });
  }

  void changeColor(int value) {
    setState(() {
      colorSelected = ColorSelection.values[value];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowMaterialGrid: false,
      routerConfig: _router,
      title: 'Yummy',
      debugShowCheckedModeBanner: false, // Uncomment to remove Debug banner
      scrollBehavior: CustomScrollBehavior(),
      themeMode: themeMode,
      theme: ThemeData(
        colorSchemeSeed: colorSelected.color,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: colorSelected.color,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
    );
  }
}
