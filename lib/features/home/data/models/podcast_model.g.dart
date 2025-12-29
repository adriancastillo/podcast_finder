// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'podcast_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PodcastModel _$PodcastModelFromJson(Map<String, dynamic> json) => PodcastModel(
  id: json['id'] as String,
  title: json['title'] as String,
  publisher: json['publisher'] as String,
  imageUrl: json['thumbnail'] as String?,
  description: json['description_original'] as String?,
);

Map<String, dynamic> _$PodcastModelToJson(PodcastModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'publisher': instance.publisher,
      'thumbnail': instance.imageUrl,
      'description_original': instance.description,
    };
