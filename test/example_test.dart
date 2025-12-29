import 'package:flutter_test/flutter_test.dart';
import 'package:podcast_finder/features/home/data/models/podcast_model.dart';

void main() {
  group('PodcastModel', () {
    test('fromJson creates valid model', () {
      // Arrange
      final json = {
        'id': 'test-1',
        'title': 'Test Podcast',
        'publisher': 'Test Publisher',
        'thumbnail': 'https://example.com/image.jpg',
        'description_original': 'Test description',
      };

      // Act
      final podcast = PodcastModel.fromJson(json);

      // Assert
      expect(podcast.id, 'test-1');
      expect(podcast.title, 'Test Podcast');
      expect(podcast.publisher, 'Test Publisher');
      expect(podcast.imageUrl, 'https://example.com/image.jpg');
      expect(podcast.description, 'Test description');
    });

    test('toJson creates valid JSON', () {
      // Arrange
      const podcast = PodcastModel(
        id: 'test-1',
        title: 'Test Podcast',
        publisher: 'Test Publisher',
        imageUrl: 'https://example.com/image.jpg',
        description: 'Test description',
      );

      // Act
      final json = podcast.toJson();

      // Assert
      expect(json['id'], 'test-1');
      expect(json['title'], 'Test Podcast');
      expect(json['publisher'], 'Test Publisher');
      expect(json['thumbnail'], 'https://example.com/image.jpg');
      expect(json['description_original'], 'Test description');
    });
  });
}