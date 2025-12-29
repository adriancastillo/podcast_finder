import 'package:dio/dio.dart';
import 'package:podcast_finder/core/network/network_exceptions.dart';
import 'package:podcast_finder/features/home/data/data_sources/podcast_remote_data_source.dart';
import 'package:podcast_finder/features/home/data/models/podcast_model.dart';

class PodcastRemoteDataSourceImpl implements PodcastRemoteDataSource {
  const PodcastRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<PodcastModel>> searchPodcasts(String query) async {
    try {
      final response = await _dio.get('/search', queryParameters: {'q': query});
      final results = response.data['results'] as List;
      return results.map((json) => PodcastModel.fromJson(json)).toList();
    } on DioException catch (error) {
      throw NetworkException.fromDioError(error);
    } catch (_) {
      throw const UnknownException();
    }
  }
}
