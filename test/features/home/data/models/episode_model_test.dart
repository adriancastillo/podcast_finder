import 'package:flutter_test/flutter_test.dart';
import 'package:podcast_finder/features/home/data/models/episode_model.dart';

void main() {
  group('EpisodeModel', () {
    test('fromJson creates valid model', () {
      // Arrange
      final json = {
        'id': 'episode-1',
        'title': 'The Future of AI Development',
        'description':
            'We discuss the latest trends in AI with leading researchers.',
        'pub_date_ms': 1702857600000, // Dec 18, 2023
        'audio_length_sec': 3600,
      };

      // Act
      final episode = EpisodeModel.fromJson(json);

      // Assert
      expect(episode.id, 'episode-1');
      expect(episode.title, 'The Future of AI Development');
      expect(episode.description, 'We discuss the latest trends in AI with leading researchers.');
      expect(episode.publishDateMs, 1702857600000);
      expect(episode.audioLengthSec, 3600);
    });

    test('fromJson handles null description', () {
      // Arrange
      final json = {
        'id': 'episode-2',
        'title': 'Episode without description',
        'description': null,
        'pub_date_ms': 1690000001000,
        'audio_length_sec': 1800,
      };

      // Act
      final episode = EpisodeModel.fromJson(json);

      // Assert
      expect(episode.description, isNull);
    });
  });
}
