import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'categories_response.g.dart';

CategoriesResponse categoriesResponseFromJson(String str) => CategoriesResponse.fromJson(json.decode(str));

String categoriesResponseToJson(CategoriesResponse data) => json.encode(data.toJson());

@JsonSerializable()
class CategoriesResponse {
  @JsonKey(name: "status")
  final int? status;
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "data")
  final List<DatumCategory>? data;

  CategoriesResponse({
      this.status,
      this.message,
      this.data,
  });

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) => _$CategoriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesResponseToJson(this);
}

@JsonSerializable()
class DatumCategory {
  @JsonKey(name: "value")
  final String? value;
  @JsonKey(name: "label")
  final String? label;

  DatumCategory({
      this.value,
      this.label,
  });

  factory DatumCategory.fromJson(Map<String, dynamic> json) => _$DatumCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$DatumCategoryToJson(this);
}
