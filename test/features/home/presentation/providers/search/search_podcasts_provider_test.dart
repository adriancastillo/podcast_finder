import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:podcast_finder/core/network/network_exceptions.dart';

import 'package:podcast_finder/features/home/data/repositories/podcast_repository.dart';
import 'package:podcast_finder/features/home/di/di.dart';
import 'package:podcast_finder/features/home/presentation/providers/search/search_podcasts_provider.dart';
import 'package:podcast_finder/features/home/presentation/providers/search/search_podcasts_state.dart';

import '../../../../../builders/podcast_model_builder.dart';

class MockPodcastRepository extends Mock implements PodcastRepository {}

void main() {
  late MockPodcastRepository mockRepository;
  late ProviderContainer container;

  setUp(() {
    mockRepository = MockPodcastRepository();

    container = ProviderContainer(
      overrides: [podcastRepositoryProvider.overrideWithValue(mockRepository)],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('SearchPodcastsNotifier', () {
    test(
      'Should emit Loading then Success when repository returns podcasts',
      () async {
        // Arrange
        final podcasts = [
          PodcastModelBuilder().withId('1').build(),
          PodcastModelBuilder().withId('2').build(),
        ];

        when(
          () => mockRepository.searchPodcasts('keyword'),
        ).thenAnswer((_) async => podcasts);

        final notifier = container.read(
          searchPodcastsNotifierProvider.notifier,
        );

        final states = <SearchPodcastsState>[];
        container.listen(
          searchPodcastsNotifierProvider,
          (previous, next) => states.add(next),
          fireImmediately: true,
        );

        // Act
        await notifier.search('keyword');

        // Assert
        expect(states, [
          const SearchPodcastsInitial(),
          const SearchPodcastsLoading(),
          isA<SearchPodcastsSuccess>(),
        ]);

        final successState = states.last as SearchPodcastsSuccess;
        expect(successState.podcasts.length, 2);
      },
    );

    test(
      'Should emit Loading then Empty when repository returns empty list',
      () async {
        // Arrange
        when(
          () => mockRepository.searchPodcasts('empty'),
        ).thenAnswer((_) async => []);

        final notifier = container.read(
          searchPodcastsNotifierProvider.notifier,
        );

        final states = <SearchPodcastsState>[];
        container.listen(
          searchPodcastsNotifierProvider,
          (previous, next) => states.add(next),
          fireImmediately: true,
        );

        // Act
        await notifier.search('empty');

        // Assert
        expect(states, [
          const SearchPodcastsInitial(),
          const SearchPodcastsLoading(),
          const SearchPodcastsEmpty(),
        ]);
      },
    );

    test(
      'Should emit Loading then Error when repository throws exception',
      () async {
        // Arrange
        when(
          () => mockRepository.searchPodcasts('keyword'),
        ).thenThrow(const TimeoutException());

        final notifier = container.read(
          searchPodcastsNotifierProvider.notifier,
        );

        final states = <SearchPodcastsState>[];
        container.listen(
          searchPodcastsNotifierProvider,
          (previous, next) => states.add(next),
          fireImmediately: true,
        );

        // Act
        await notifier.search('keyword');

        // Assert
        expect(states[0], const SearchPodcastsInitial());
        expect(states[1], const SearchPodcastsLoading());
        expect(states[2], isA<SearchPodcastsError>());

        final errorState = states[2] as SearchPodcastsError;
        expect(
          errorState.message,
          contains(
            'Connection timeout. Please check your internet connection.',
          ),
        );
      },
    );
  });
}
