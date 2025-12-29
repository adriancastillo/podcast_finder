import 'package:podcast_finder/features/home/data/models/episode_model.dart';
import 'package:podcast_finder/features/home/data/models/podcast_detail_model.dart';

class PodcastDetailModelBuilder {
  String _id = 'podcast-id';
  String _title = 'Default Podcast Title';
  String _publisher = 'Default Publisher';
  String? _image = 'https://picsum.photos/200';
  String? _description = 'Default podcast description';
  List<int> _genreIds = const [1];
  List<EpisodeModel> _episodes = const [];

  PodcastDetailModelBuilder withId(String id) {
    _id = id;
    return this;
  }

  PodcastDetailModelBuilder withTitle(String title) {
    _title = title;
    return this;
  }

  PodcastDetailModelBuilder withPublisher(String publisher) {
    _publisher = publisher;
    return this;
  }

  PodcastDetailModelBuilder withImage(String? image) {
    _image = image;
    return this;
  }

  PodcastDetailModelBuilder withDescription(String? description) {
    _description = description;
    return this;
  }

  PodcastDetailModelBuilder withGenreIds(List<int> genreIds) {
    _genreIds = genreIds;
    return this;
  }

  PodcastDetailModelBuilder withEpisodes(List<EpisodeModel> episodes) {
    _episodes = episodes;
    return this;
  }

  PodcastDetailModel build() {
    return PodcastDetailModel(
      id: _id,
      title: _title,
      publisher: _publisher,
      image: _image,
      description: _description,
      genreIds: _genreIds,
      episodes: _episodes,
    );
  }
}
