import 'package:flutter_test/flutter_test.dart';
import 'package:podcast_finder/features/home/data/models/episode_model.dart';
import 'package:podcast_finder/features/home/data/models/podcast_detail_model.dart';

void main() {
  group('PodcastDetailModel', () {
    test('fromJson creates valid model', () {
      // Arrange
      final json = {
        'id': 'podcast-1',
        'title': 'Tech Talk Daily',
        'publisher': 'Tech Media Inc',
        'image': 'https://picsum.photos/seed/podcast-1/400',
        'description':
            'Your daily dose of technology news and insights. We cover everything from startups to AI, blockchain to cloud computing. Join us every day for in-depth discussions with industry leaders.',
        'genre_ids': [127, 93],
        'episodes': [
          {
            'id': 'episode-1',
            'title': 'The Future of AI Development',
            'description':
                'We discuss the latest trends in AI with leading researchers.',
            'pub_date_ms': 1702857600000, // Dec 18, 2023
            'audio_length_sec': 3600,
          },
          {
            'id': 'episode-2',
            'title': 'Cloud Computing in 2024',
            'description': 'What to expect from cloud providers this year.',
            'pub_date_ms': 1702771200000, // Dec 17, 2023
            'audio_length_sec': 2700,
          },
        ],
      };

      // Act
      final podcastDetail = PodcastDetailModel.fromJson(json);

      // Assert
      expect(podcastDetail.id, 'podcast-1');
      expect(podcastDetail.title, 'Tech Talk Daily');
      expect(podcastDetail.publisher, 'Tech Media Inc');
      expect(podcastDetail.image, 'https://picsum.photos/seed/podcast-1/400');
      expect(
        podcastDetail.description,
        'Your daily dose of technology news and insights. We cover everything from startups to AI, blockchain to cloud computing. Join us every day for in-depth discussions with industry leaders.',
      );
      expect(podcastDetail.genreIds, [127, 93]);
      expect(podcastDetail.episodes.length, 2);
      expect(podcastDetail.episodes.first, isA<EpisodeModel>());
    });
  });
}
