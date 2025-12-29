import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:podcast_finder/core/network/network_exceptions.dart';

import 'package:podcast_finder/features/home/data/repositories/podcast_repository.dart';
import 'package:podcast_finder/features/home/di/di.dart';
import 'package:podcast_finder/features/home/presentation/providers/detail/podcast_detail_provider.dart';
import 'package:podcast_finder/features/home/presentation/providers/detail/podcasts_detail_state.dart';

import '../../../../../builders/podcast_detail_model_builder.dart';

class MockPodcastRepository extends Mock implements PodcastRepository {}

void main() {
  late MockPodcastRepository mockRepository;
  late ProviderContainer container;

  const podcastId = 'podcast-1';

  setUp(() {
    mockRepository = MockPodcastRepository();

    container = ProviderContainer(
      overrides: [podcastRepositoryProvider.overrideWithValue(mockRepository)],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('PodcastDetailNotifier', () {
    test(
      'Should emit Loading then Success when getPodcastById succeeds',
      () async {
        // Arrange
        final podcastDetail = PodcastDetailModelBuilder()
            .withId(podcastId)
            .withTitle('Tech Talk Daily')
            .build();

        when(
          () => mockRepository.getPodcastById(podcastId),
        ).thenAnswer((_) async => podcastDetail);

        final notifier = container.read(
          podcastDetailNotifierProvider(podcastId).notifier,
        );

        final states = <PodcastDetailState>[];
        container.listen(
          podcastDetailNotifierProvider(podcastId),
          (_, next) => states.add(next),
          fireImmediately: true,
        );

        // Act
        await notifier.getPodcastById(podcastId);

        // Assert
        expect(states.first, const PodcastDetailLoading());
        expect(states.last, isA<PodcastDetailSuccess>());

        final successState = states[1] as PodcastDetailSuccess;
        expect(successState.podcastDetail.id, podcastId);

        verify(() => mockRepository.getPodcastById(podcastId)).called(1);
      },
    );

    test(
      'Should emit Loading then Error when getPodcastById throws exception',
      () async {
        // Arrange
        when(
          () => mockRepository.getPodcastById(podcastId),
        ).thenAnswer((_) async => throw const UnknownException());

        final notifier = container.read(
          podcastDetailNotifierProvider(podcastId).notifier,
        );

        final states = <PodcastDetailState>[];
        container.listen(
          podcastDetailNotifierProvider(podcastId),
          (_, next) => states.add(next),
          fireImmediately: true,
        );

        // Act
        await notifier.getPodcastById(podcastId);

        // Assert
        expect(states.first, const PodcastDetailLoading());
        expect(states.last, isA<PodcastDetailError>());

        final errorState = states.last as PodcastDetailError;
        expect(
          errorState.message,
          contains('An unexpected error occurred. Please try again.'),
        );

        verify(() => mockRepository.getPodcastById(podcastId)).called(1);
      },
    );

    test('Should remain in Loading state before getPodcastById is called', () {
      // Arrange
      final state = container.read(podcastDetailNotifierProvider(podcastId));

      // Assert
      expect(state, const PodcastDetailLoading());

      verifyNever(() => mockRepository.getPodcastById(any()));
    });

    test('Should allow multiple calls to getPodcastById', () async {
      // Arrange
      final podcastDetail = PodcastDetailModelBuilder()
          .withId(podcastId)
          .build();

      when(
        () => mockRepository.getPodcastById(podcastId),
      ).thenAnswer((_) async => podcastDetail);

      final notifier = container.read(
        podcastDetailNotifierProvider(podcastId).notifier,
      );

      // Act
      await notifier.getPodcastById(podcastId);
      await notifier.getPodcastById(podcastId);

      // Assert
      verify(() => mockRepository.getPodcastById(podcastId)).called(2);

      final state = container.read(podcastDetailNotifierProvider(podcastId));

      expect(state, isA<PodcastDetailSuccess>());
    });
  });
}
