import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podcast_finder/features/home/presentation/providers/search/search_podcasts_provider.dart';
import 'package:podcast_finder/features/home/presentation/providers/search/search_podcasts_state.dart';
import 'package:podcast_finder/features/home/presentation/widgets/empty_podcast_card.dart';
import 'package:podcast_finder/features/home/presentation/widgets/error_card.dart';
import 'package:podcast_finder/features/home/presentation/widgets/search/search_textfield.dart';
import 'package:podcast_finder/features/home/presentation/widgets/search/podcast_list.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final podcastsState = ref.watch(searchPodcastsNotifierProvider);
    var query = '';
    return Scaffold(
      appBar: AppBar(title: const Text('PodcastFinder')),
      body: Column(
        children: [
          SearchTextfield(
            onSearch: (value) {
              query = value;
              ref.read(searchPodcastsNotifierProvider.notifier).search(value);
            },
          ),
          switch (podcastsState) {
            SearchPodcastsInitial() => const Text(
              'Enter a keyword to begin your search',
            ),
            SearchPodcastsLoading() => const CircularProgressIndicator(),
            SearchPodcastsSuccess(:final podcasts) => PodcastList(
              podcasts: podcasts,
            ),
            SearchPodcastsEmpty() => const EmptyPodcastsCard(),
            SearchPodcastsError(:final message) => ErrorCard(
              message: message,
              onRetry: () => ref
                  .read(searchPodcastsNotifierProvider.notifier)
                  .search(query),
            ),
          },
        ],
      ),
    );
  }
}
