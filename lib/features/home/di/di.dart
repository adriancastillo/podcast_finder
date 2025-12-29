import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podcast_finder/core/network/dio_client.dart';
import 'package:podcast_finder/features/home/data/data_sources/podcast_remote_data_source.dart';
import 'package:podcast_finder/features/home/data/data_sources/podcast_remote_data_source_impl.dart';
import 'package:podcast_finder/features/home/data/repositories/podcast_repository.dart';

final podcastRepositoryProvider = Provider<PodcastRepository>((ref) {
  final podcastRemoteDataSource = ref.read(podcastRemoteDataSourceProvider);
  return PodcastRepository(podcastRemoteDataSource);
});

final podcastRemoteDataSourceProvider = Provider<PodcastRemoteDataSource>((
  ref,
) {
  final dio = ref.read(dioProvider);
  return PodcastRemoteDataSourceImpl(dio);
});
