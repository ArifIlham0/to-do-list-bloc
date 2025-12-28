import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'global_query_params.g.dart';

GlobalQueryParams globalQueryParamsFromJson(String str) => GlobalQueryParams.fromJson(json.decode(str));

String globalQueryParamsToJson(GlobalQueryParams data) => json.encode(data.toJson());

@JsonSerializable()
class GlobalQueryParams {
  @JsonKey(name: "page")
  final int? page;
  @JsonKey(name: "page_size")
  final int? pageSize;
  @JsonKey(name: "query")
  final String? query;
  @JsonKey(name: "is_overdue")
  final bool? isOverdue;
  @JsonKey(name: "is_completed")
  final bool? isCompleted;

  GlobalQueryParams({
      this.page,
      this.pageSize,
      this.query,
      this.isOverdue,
      this.isCompleted,
  });

  factory GlobalQueryParams.fromJson(Map<String, dynamic> json) => _$GlobalQueryParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GlobalQueryParamsToJson(this);
}
