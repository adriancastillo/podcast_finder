import 'package:podcast_finder/features/home/data/models/podcast_detail_model.dart';

sealed class PodcastDetailState {
  const PodcastDetailState();
}

class PodcastDetailLoading extends PodcastDetailState {
  const PodcastDetailLoading();
}

class PodcastDetailSuccess extends PodcastDetailState {
  PodcastDetailSuccess(this.podcastDetail);

  final PodcastDetailModel podcastDetail;
}

class PodcastDetailError extends PodcastDetailState {
  PodcastDetailError(this.message);

  final String message;
}
