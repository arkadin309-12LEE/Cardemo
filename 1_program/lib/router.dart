import 'package:go_router/go_router.dart';
import 'screens/home_screen.dart';
import 'screens/card_list_screen.dart';
import 'screens/card_edit_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/cards',
      builder: (context, state) => const CardListScreen(),
    ),
    GoRoute(
      path: '/card/new',
      builder: (context, state) => const CardEditScreen(),
    ),
    GoRoute(
      path: '/card/edit/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return CardEditScreen(cardId: id);
      },
    ),
  ],
);
