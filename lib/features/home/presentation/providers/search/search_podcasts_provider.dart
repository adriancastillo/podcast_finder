import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podcast_finder/features/home/data/repositories/podcast_repository.dart';
import 'package:podcast_finder/features/home/di/di.dart';
import 'package:podcast_finder/features/home/presentation/providers/search/search_podcasts_state.dart';

final searchPodcastsNotifierProvider =
    StateNotifierProvider<SearchPodcastsNotifier, SearchPodcastsState>((ref) {
      final repository = ref.read(podcastRepositoryProvider);
      return SearchPodcastsNotifier(repository);
    });

class SearchPodcastsNotifier extends StateNotifier<SearchPodcastsState> {
  SearchPodcastsNotifier(this._podcastRepository)
    : super(const SearchPodcastsInitial());

  final PodcastRepository _podcastRepository;

  Future<void> search(String query) async {
    state = const SearchPodcastsLoading();
    try {
      final podcasts = await _podcastRepository.searchPodcasts(query);
      state = podcasts.isEmpty
          ? const SearchPodcastsEmpty()
          : SearchPodcastsSuccess(podcasts);
    } catch (error) {
      state = SearchPodcastsError(error.toString());
    }
  }
}
