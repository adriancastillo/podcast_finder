import 'package:json_annotation/json_annotation.dart';
import 'package:podcast_finder/features/home/data/models/episode_model.dart';

part 'podcast_detail_model.g.dart';

@JsonSerializable()
class PodcastDetailModel {
  PodcastDetailModel({
    required this.id,
    required this.title,
    required this.publisher,
    required this.image,
    required this.description,
    required this.genreIds,
    required this.episodes,
  });

  final String id;
  final String title;
  final String publisher;
  final String? image;
  final String? description;

  @JsonKey(name: 'genre_ids')
  final List<int>? genreIds;

  final List<EpisodeModel> episodes;

  List<String>? get genreLabels => genreIds
      ?.map(
        (genre) => switch (genre) {
          93 => 'Adventure',
          127 => 'Ramance',
          _ => 'Unknow',
        },
      )
      .toList();

  List<EpisodeModel> get lastFiveEpisodes {
    if (episodes.isEmpty) return [];

    final start = episodes.length > 5 ? episodes.length - 5 : 0;
    return episodes.sublist(start);
  }

  factory PodcastDetailModel.fromJson(Map<String, dynamic> json) =>
      _$PodcastDetailModelFromJson(json);
}
