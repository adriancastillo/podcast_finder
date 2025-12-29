import 'package:podcast_finder/features/home/data/models/podcast_detail_model.dart';
import 'package:podcast_finder/features/home/data/models/podcast_model.dart';

abstract class PodcastRemoteDataSource {
  Future<List<PodcastModel>> searchPodcasts(String query);

  Future<PodcastDetailModel> getPodcastById(String podcastId);
}
