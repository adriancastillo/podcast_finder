import 'package:flutter/material.dart';
import 'package:podcast_finder/features/home/data/data_sources/podcast_remote_data_source.dart';
import 'package:podcast_finder/features/home/data/models/podcast_detail_model.dart';
import '../models/podcast_model.dart';

class PodcastRepository {
  const PodcastRepository(this._remoteDataSource);

  final PodcastRemoteDataSource _remoteDataSource;

  Future<List<PodcastModel>> searchPodcasts(String query) async {
    await Future.delayed(Durations.long4);
    return _remoteDataSource.searchPodcasts(query);
  }

  Future<PodcastDetailModel> getPodcastById(String id) async {
    await Future.delayed(Durations.long4);
    return _remoteDataSource.getPodcastById(id);
  }
}
