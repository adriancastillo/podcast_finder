import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podcast_finder/features/home/data/repositories/podcast_repository.dart';
import 'package:podcast_finder/features/home/di/di.dart';
import 'package:podcast_finder/features/home/presentation/providers/detail/podcasts_detail_state.dart';

final podcastDetailNotifierProvider =
    StateNotifierProvider.family<
      PodcastDetailNotifier,
      PodcastDetailState,
      String
    >((ref, podcastId) {
      final repository = ref.read(podcastRepositoryProvider);
      return PodcastDetailNotifier(repository, podcastId);
    });

class PodcastDetailNotifier extends StateNotifier<PodcastDetailState> {
  PodcastDetailNotifier(this._podcastRepository, String podcastId)
    : super(const PodcastDetailLoading());

  final PodcastRepository _podcastRepository;

  Future<void> getPodcastById(String id) async {
    state = const PodcastDetailLoading();
    try {
      final podcastDetail = await _podcastRepository.getPodcastById(id);

      state = PodcastDetailSuccess(podcastDetail);
    } catch (error) {
      state = PodcastDetailError(error.toString());
    }
  }
}
