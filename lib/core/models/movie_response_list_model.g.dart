// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_response_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieResponseListModel _$MovieResponseListModelFromJson(
        Map<String, dynamic> json) =>
    MovieResponseListModel(
      page: (json['page'] as num?)?.toInt(),
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: (json['totalPages'] as num?)?.toInt(),
      totalResults: (json['totalResults'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MovieResponseListModelToJson(
        MovieResponseListModel instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results,
      'totalPages': instance.totalPages,
      'totalResults': instance.totalResults,
    };
