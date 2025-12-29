import 'package:podcast_finder/features/home/data/models/podcast_model.dart';

class PodcastModelBuilder {
  String _id = 'podcast-1';
  String _title = 'Default Podcast Title';
  String _publisher = 'Default Publisher';
  String? _imageUrl = 'https://picsum.photos/seed/podcast1/200';
  String? _description = 'Default podcast description';

  PodcastModelBuilder();

  PodcastModelBuilder withId(String id) {
    _id = id;
    return this;
  }

  PodcastModelBuilder withTitle(String title) {
    _title = title;
    return this;
  }

  PodcastModelBuilder withPublisher(String publisher) {
    _publisher = publisher;
    return this;
  }

  PodcastModelBuilder withImageUrl(String? imageUrl) {
    _imageUrl = imageUrl;
    return this;
  }

  PodcastModelBuilder withDescription(String? description) {
    _description = description;
    return this;
  }

  PodcastModel build() {
    return PodcastModel(
      id: _id,
      title: _title,
      publisher: _publisher,
      imageUrl: _imageUrl,
      description: _description,
    );
  }
}
