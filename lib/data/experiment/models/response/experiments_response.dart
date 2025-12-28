import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'experiments_response.g.dart';

ExperimentsResponse experimentsResponseFromJson(String str) => ExperimentsResponse.fromJson(json.decode(str));

String experimentsResponseToJson(ExperimentsResponse data) => json.encode(data.toJson());

@JsonSerializable()
class ExperimentsResponse {
  @JsonKey(name: "status")
  final int? status;
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "data")
  final List<DatumExperiment>? data;

  ExperimentsResponse({
      this.status,
      this.message,
      this.data,
  });

  factory ExperimentsResponse.fromJson(Map<String, dynamic> json) => _$ExperimentsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ExperimentsResponseToJson(this);
}

@JsonSerializable()
class DatumExperiment {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "category")
  final String? category;
  @JsonKey(name: "image")
  final Image? image;

  DatumExperiment({
      this.id,
      this.name,
      this.category,
      this.image,
  });

  factory DatumExperiment.fromJson(Map<String, dynamic> json) => _$DatumExperimentFromJson(json);

  Map<String, dynamic> toJson() => _$DatumExperimentToJson(this);
}

@JsonSerializable()
class Image {
  @JsonKey(name: "url")
  final String? url;
  @JsonKey(name: "name")
  final String? name;

  Image({
      this.url,
      this.name,
  });

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);

  Map<String, dynamic> toJson() => _$ImageToJson(this);
}
