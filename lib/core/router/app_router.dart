import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podcast_finder/features/home/data/models/podcast_model.dart';
import 'package:podcast_finder/features/home/presentation/screens/podcast_detail_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: '/podcast/:id',
            name: 'detail',
            builder: (context, state) {
              final podcast = state.extra as PodcastModel;
              return PodcastDetailScreen(podcast: podcast);
            },
          ),
        ],
      ),
    ],
  );
});
