import 'package:podcast_finder/features/home/data/models/podcast_model.dart';

sealed class SearchPodcastsState {
  const SearchPodcastsState();
}

class SearchPodcastsInitial extends SearchPodcastsState {
  const SearchPodcastsInitial();
}

class SearchPodcastsLoading extends SearchPodcastsState {
  const SearchPodcastsLoading();
}

class SearchPodcastsSuccess extends SearchPodcastsState {
  SearchPodcastsSuccess(this.podcasts);

  final List<PodcastModel> podcasts;
}

class SearchPodcastsError extends SearchPodcastsState {
  SearchPodcastsError(this.message);

  final String message;
}

class SearchPodcastsEmpty extends SearchPodcastsState {
  const SearchPodcastsEmpty();
}
