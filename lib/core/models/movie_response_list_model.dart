import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_app/core/base/model/i_network_model.dart';
import 'package:the_movie_app/core/models/movie_model.dart';
part 'movie_response_list_model.g.dart';

@JsonSerializable()
class MovieResponseListModel extends INetworkModel<MovieResponseListModel> {
  MovieResponseListModel({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });
  @override
  factory MovieResponseListModel.fromJson(Map<String, dynamic> json) {
    return _$MovieResponseListModelFromJson(json);
  }
  int? page;
  List<MovieModel>? results;
  int? totalPages;
  int? totalResults;
  @override
  Map<String, dynamic> toJson() {
    return _$MovieResponseListModelToJson(this);
  }

  @override
  MovieResponseListModel fromJson(Map<String, dynamic> json) {
    return _$MovieResponseListModelFromJson(json);
  }
}
